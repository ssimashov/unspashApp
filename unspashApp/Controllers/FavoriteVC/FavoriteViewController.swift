//
//  FavoriteViewController.swift
//  unspashApp
//
//  Created by Sergey Simashov on 02.09.2022.
//
import UIKit
import Alamofire
import RealmSwift

class FavoriteTableVC: UITableViewController {
    
    private let networkService = NetworkService()
    var results: Results<DetailedPhotoResults>?
    private var token: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pareTableAndRealm()
        configureUI()
    }
    
    private func configureUI() {
        tableView.backgroundColor = .white
        tableView.registerCell(FavoriteTableViewCell.self)
        navigationItem.title = "Избранное"
    }
    
    private func loadData() {
        do {
            let realm = try Realm()
            self.results = realm.objects(DetailedPhotoResults.self).sorted(byKeyPath: "currentTime", ascending: false)
        } catch {
            print(error)
        }
    }
    
    private func pareTableAndRealm() {
        guard let realm = try? Realm() else { return }

        self.results = realm.objects(DetailedPhotoResults.self).sorted(byKeyPath: "currentTime", ascending: false)

        token = results?.observe { [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.tableView else { return }
            
            guard let self = self else { return }

            switch changes {
            case .initial(_):
                self.loadData()
            case let .update(_, deletions, insertions, modifications):
                tableView.beginUpdates()

                tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }), with: .automatic)

                tableView.endUpdates()
            case .error(let error):
                print(error)
            }
        }
    }


    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = results?.count else { return 0 }
        return count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as FavoriteTableViewCell
        
        guard let results = self.results else { return UITableViewCell() }
        guard let name = results[indexPath.row].user?.name else { return UITableViewCell() }
        guard let url = results[indexPath.row].urls?.thumb else { return UITableViewCell() }
        
        cell.nameLabel.text = name
        
        if let url = URL(string: url) {
            AF.download(url, method: .get).responseData(queue: .global()) { response in
                guard let data = response.value else { return }
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    cell.photoImageView.image = image
                }
            }
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        guard let data = results?[indexPath.row] else { return }
        RealmService.deleteData(data)
    }

    // MARK: - Table view Delegate

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        guard let data = self.results else { return }
        detailVC.photoID = data[indexPath.row].id
        detailVC.detailView.likeControl.isLiked = data[indexPath.row].isLiked
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
