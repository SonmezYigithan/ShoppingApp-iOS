//
//  TabBarVC.swift
//  ShoppingApp
//
//  Created by Yiğithan Sönmez on 13.02.2024.
//

import UIKit

class TabBarVC: UITabBarController {
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        
        let homeVC = UINavigationController(rootViewController: HomeVC())
        let CategoriesVC = UINavigationController(rootViewController: CategoriesBuilder.make())
        let CartVC = UINavigationController(rootViewController: CartVC())
        
        homeVC.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        homeVC.tabBarItem.image = UIImage(systemName: "house")
        CategoriesVC.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        CartVC.tabBarItem.selectedImage = UIImage(systemName: "cart.fill")
        CartVC.tabBarItem.image = UIImage(systemName: "cart")
        
        homeVC.title = "Home"
        CategoriesVC.title = "Categories"
        CartVC.title = "Cart"
        
        tabBar.tintColor = .label
        
        setViewControllers([homeVC, CategoriesVC, CartVC], animated: true)
    }
}
