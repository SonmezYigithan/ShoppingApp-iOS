//
//  HomeVM.swift
//  ShoppingApp
//
//  Created by Yiğithan Sönmez on 13.02.2024.
//

import Foundation

protocol HomeVMProtocol: AnyObject {
    var view: HomeVC? { get set }
    var products: [Product] { get }
    
    func fetchBestSellingProducts()
    func didSelectProduct(at index: Int)
}

class HomeVM {
    weak var view: HomeVC?
    var products = [Product]()
}

extension HomeVM: HomeVMProtocol {
    func fetchBestSellingProducts() {
        StoreAPIManager.shared.fetchAllProducts { [weak self] result in
            switch(result){
            case .success(let products):
                self?.products.append(contentsOf: products)
                self?.view?.reloadTableView()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func didSelectProduct(at index: Int) {
        let vc = ProductDetailsVC()
        vc.configure(with: products[index])
        view?.navigateToProductDetails(vc: vc)
    }
}
