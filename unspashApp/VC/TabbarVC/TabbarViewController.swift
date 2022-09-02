//
//  TabbarViewController.swift
//  unspashApp
//
//  Created by Sergey Simashov on 02.09.2022.
//

import UIKit

class TabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.backgroundColor = .blue
        
        let mainVC = MainViewController()
        let favoriteVC = FavoriteViewController()
        
        viewControllers = [createNavigationController(rootViewController: mainVC, title: "`Find", image: UIImage(systemName: "photo.on.rectangle.angled")!),
        createNavigationController(rootViewController: favoriteVC, title: "Favorite", image: UIImage(systemName: "heart")!)]
    }
    

    private func createNavigationController(rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navigationVC = UINavigationController (rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        
        return navigationVC
    }
}
