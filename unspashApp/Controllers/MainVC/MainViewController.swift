//
//  MainViewController.swift
//  unspashApp
//
//  Created by Sergey Simashov on 02.09.2022.
//

import UIKit
import Alamofire
import CHTCollectionViewWaterfallLayout


class MainViewController: UICollectionViewController {

    // MARK: - Properties
    
    let networkService = NetworkService()
    var photos = [Photos]()
    
    private let searchBar = UISearchBar()
    var timer: Timer?
    
    // MARK: - Init
    
    init() {
        let layout = CHTCollectionViewWaterfallLayout()
        layout.itemRenderDirection = .leftToRight
        layout.columnCount = 2
        layout.minimumColumnSpacing = 2
        layout.minimumInteritemSpacing = 2
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - Methods
    
    private func configureUI() {
        collectionView.backgroundColor = .white
        collectionView.registerCell(MainCollectionViewCell.self)
        
        searchBar.sizeToFit()
        searchBar.delegate = self
        showSearchBarButton(shouldShow: true)
        
        navigationItem.title = ControllerTitleNames.searchPhotosControllerTitle.rawValue
    }
    
    private func showSearchBarButton(shouldShow: Bool) {
        if shouldShow {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleShowSearchBar))
        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    @objc private func handleShowSearchBar() {
        search(shouldShow: true)
        searchBar.becomeFirstResponder()
    }
    
    func search(shouldShow: Bool) {
        showSearchBarButton(shouldShow: !shouldShow)
        searchBar.showsCancelButton = shouldShow
        
        navigationItem.titleView = shouldShow ? searchBar : nil
    }
    
    // MARK: - Collection view data source

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as MainCollectionViewCell
    
        let urlString = photos[indexPath.item].urls.small
        
        if let url = URL(string: urlString) {
            AF.download(url).responseData(queue: .global()) { response in
                guard let data = response.value, let image = UIImage(data: data) else { return }
                
                DispatchQueue.main.async {
                    cell.photoImageView.image = image
                }
            }
        }
    
        return cell
    }
    
    // MARK: - Collection view delegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let detailVC = DetailViewController()
////        detailVC.photoID = photos[indexPath.item].id
//        navigationController?.pushViewController(detailVC, animated: true)
    }

}

extension MainViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        search(shouldShow: false)
        photos.removeAll()
        collectionView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
            self.networkService.searchPhotos (searchText: searchText) { [weak self] photos in
                guard let self = self else { return }
                self.photos = photos
                DispatchQueue.main.async() {
                    self.collectionView.reloadData()
                }
            }
        }
    }
}


extension MainViewController: CHTCollectionViewDelegateWaterfallLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionWidth = collectionView.frame.width
        let cellWidth = collectionWidth / 2.0
        
        let photoWidth: CGFloat = CGFloat(photos[indexPath.item].width)
        let photoHeight: CGFloat = CGFloat(photos[indexPath.item].height)

        let aspectRatio = photoHeight / photoWidth
        
        let cellHeight = cellWidth * aspectRatio
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
