//
//  TabBarViewController.swift
//  VIPER
//
//  Created by Ali Fayed on 30/04/2021.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let moviesRouter = MoviesViewRouter.start()
        let moviesVC = moviesRouter.entry
        let nav1 = UINavigationController(rootViewController: moviesVC!)

        nav1.title = "Movies"
        nav1.navigationItem.largeTitleDisplayMode = .always
        nav1.navigationBar.prefersLargeTitles = true
        nav1.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(systemName: "person"), tag: 1)
        setViewControllers([nav1], animated: false)

    }
    
}
