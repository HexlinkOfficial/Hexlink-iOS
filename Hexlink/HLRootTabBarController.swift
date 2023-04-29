//
//  HLRootTabBarController.swift
//  Hexlink
//
//  Created by Yang Xi on 4/25/23.
//

import UIKit

class HLRootTabBarController : UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = UIColor.red
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.red
        tabBar.standardAppearance = appearance
        tabBar.tintColor = .label
        tabBar.isTranslucent = false
        setupVCs()
    }
        
    private func setupVCs() {
        viewControllers = [
            createNavController(for: HLHomeViewController(), title: NSLocalizedString("Home", comment: ""), image: UIImage(systemName: "lock")!),
            createNavController(for: HLInternalSettingViewController(), title: NSLocalizedString("Setting", comment: ""), image: UIImage(systemName: "gearshape")!)
        ]
    }
    
    private func createNavController(for rootViewController: UIViewController,
                                     title: String,
                                     image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        
//        navController.navigationBar.prefersLargeTitles = true
//        rootViewController.navigationItem.title = title
        return navController
    }
}
