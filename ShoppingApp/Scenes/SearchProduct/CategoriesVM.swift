//
//  SearchProductsVM.swift
//  ShoppingApp
//
//  Created by Yiğithan Sönmez on 15.02.2024.
//

import Foundation

protocol CategoriesVMProtocol: AnyObject {
    var view: CategoriesVCProtocol? { get set }
    var categories: [String] { get }
    
    func fetchAllCategories()
    func didSelectCategoryItemAt(_ index: Int)
}

class CategoriesVM {
    weak var view: CategoriesVCProtocol?
    var categories = [String]()
}

extension CategoriesVM: CategoriesVMProtocol {
    func fetchAllCategories() {
        StoreAPIManager.shared.fetchAllCategories { [weak self] result in
            switch result {
            case .success(let categories):
                print(categories)
                self?.categories = categories
                self?.view?.reloadCollectionView()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func didSelectCategoryItemAt(_ index: Int) {
        let vc = CategoryProductsVC()
        vc.configure(with: categories[index])
        view?.navigateToCategoryProducts(with: vc)
    }
}
