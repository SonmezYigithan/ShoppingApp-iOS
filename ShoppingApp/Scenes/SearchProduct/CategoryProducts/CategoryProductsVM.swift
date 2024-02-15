//
//  CategoryProductsVM.swift
//  ShoppingApp
//
//  Created by Yiğithan Sönmez on 15.02.2024.
//

import Foundation

protocol CategoryProductsVMProtocol {
    var view: CategoryProductsVC? { get set }
    var products: [Product] { get }
    
    func fetchAllProductsInCategory(category: String)
}

class CategoryProductsVM {
    weak var view: CategoryProductsVC?
    var products = [Product]()
}

extension CategoryProductsVM: CategoryProductsVMProtocol {
    func fetchAllProductsInCategory(category: String) {
        StoreAPIManager.shared.fetchAllProductsInCategory(categoryName: category) { [weak self] result in
            switch result {
            case .success(let products):
                self?.products = products
                self?.view?.reloadCollectionView()
            case .failure(let error):
                print(error)
            }
        }
    }
}


