//
//  DetailViewController.swift
//  unspashApp
//
//  Created by Sergey Simashov on 02.09.2022.
//

import UIKit
import Alamofire
import RealmSwift

class DetailViewController: UIViewController {
    
    lazy var detailView: DetailView = {
        let view = DetailView()
        return view
    }()
    
    let networkService = NetworkService()
    var data: DetailedPhotoResults?
    var results: Results<DetailedPhotoResults>?
    var photoID: String?
    var isLiked: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        fetchData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let viewWidth = view.bounds.width
        
        guard let imageWidth = data?.width, let imageHeight = data?.height else { return }
        let floatWidth = CGFloat(imageWidth)
        let floatHeight = CGFloat(imageHeight)
        let aspectRatio = floatHeight / floatWidth
        let height = viewWidth * aspectRatio
        detailView.imageView.heightAnchor.constraint(equalToConstant: height).isActive = true
        detailView.likeControl.setupLikeColor()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        navigationItem.title = "Подробная информация"
        
        detailView.detailVC = self
        detailView.likeControl.addTarget(self, action: #selector(addToFavorites), for: .touchUpInside)
    }
    
    @objc func addToFavorites(_ : UIButton) {
        guard let data = data else { return }
        
        var idFromRealm = ""
        
        do {
            let realm = try Realm()
            results = realm.objects(DetailedPhotoResults.self).filter("id CONTAINS '\(data.id)'")
            if let id = results?.first?.id {
                idFromRealm = id
            }
        } catch {
            print(error)
        }
        
        if isLiked == false && photoID != idFromRealm {
            data.currentTime = getCurrentTime()
            data.isLiked = true
            
            RealmService.saveData(data)
            
            alert(message: "Фото добавлено!")
            
        } else if isLiked == true && photoID == idFromRealm {
            
            RealmService.deleteData(data)
            
            alert(message: "Фото удалено!")
        }
    }
    
    private func fetchData() {
        guard let id = photoID else { return }
        
        networkService.getPhoto(photoId: id) { [weak self] response in
            guard let self = self else { return }
            
            self.data = response
            
            guard let data = self.data else { return }
            guard let name = data.user?.name else { return }
            guard let url = data.urls?.regular else { return }
            let downloads = Double(data.downloads).addSeparator()
            let createdAt = data.createdAt
            
            self.fetchPhoto(url: url)
            self.detailView.creatorNameView.label.text = name
            self.detailView.downloadsView.label.text = downloads
            self.detailView.createdAtView.label.text = self.changeDateFormat(date: createdAt)
            
            if let country = data.location?.country,
               let city = data.location?.city {
                self.detailView.locationView.label.text = "\(city), \(country)"
            }
        }
        
        do {
            let realm = try Realm()
            results = realm.objects(DetailedPhotoResults.self).filter("id CONTAINS '\(id)'")
            guard let isLikedFromRealm = results?.first?.isLiked else { return isLiked = false}
            detailView.likeControl.isLiked = isLikedFromRealm
            isLiked = isLikedFromRealm
        } catch {
            print(error)
        }
    }
    
    private func fetchPhoto(url: String) {
        if let url = URL(string: url) {
            DispatchQueue.global().async {
                AF.download(url, method: .get).responseData { response in
                    guard let data = response.value else { return }
                    DispatchQueue.main.async {
                        self.detailView.imageView.image = UIImage(data: data)
                    }
                }
            }
        }
    }
    
    func changeDateFormat(date: String) -> String {
        let oldDateFormat = DateFormatter()
        oldDateFormat.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let newDateFormat = DateFormatter()
        newDateFormat.dateFormat = "d MMMM, yyyy"
        
        if let oldDate = oldDateFormat.date(from: date) {
            let newDate = newDateFormat.string(from: oldDate)
            return newDate
        } else {
            return "There was an error decoding the string"
        }
    }
    
    func addPoints(inputNumber: NSMutableString) -> String {
        var count: Int = inputNumber.length
        while count >= 4 {
            count = count - 3
            inputNumber.insert(" ", at: count) // you also can use ","
        }
        print(inputNumber)
        return String(inputNumber)
    }
    
    func getCurrentTime() -> String {
        let now = Date()
        let formatter = DateFormatter()
        formatter.timeZone = .current
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        let dateString = formatter.string(from: now)
        return dateString
    }
    
    func alert(message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
}
