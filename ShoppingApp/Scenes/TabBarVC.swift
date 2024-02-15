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
        let SearchProductVC = UINavigationController(rootViewController: CategoriesVC())
        let CartVC = UINavigationController(rootViewController: CartVC())
        
        homeVC.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        homeVC.tabBarItem.image = UIImage(systemName: "house")
        SearchProductVC.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        CartVC.tabBarItem.selectedImage = UIImage(systemName: "cart")
        CartVC.tabBarItem.image = UIImage(systemName: "cart.fill")
        
        homeVC.title = "Home"
        SearchProductVC.title = "Search Product"
        CartVC.title = "Cart"
        
        tabBar.tintColor = .label
        
        setViewControllers([homeVC, SearchProductVC, CartVC], animated: true)
    }
}
