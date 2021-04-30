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

        let userRouter = UserRouter.start()
        let usersVC = userRouter.entry
        usersVC!.title = "Users"
        usersVC!.navigationItem.largeTitleDisplayMode = .never
        let nav1 = UINavigationController(rootViewController: usersVC!)
        nav1.tabBarItem = UITabBarItem(title: "Users", image: UIImage(systemName: "person"), tag: 1)
        nav1.navigationBar.prefersLargeTitles = false
        setViewControllers([nav1], animated: false)

    }
    
}
