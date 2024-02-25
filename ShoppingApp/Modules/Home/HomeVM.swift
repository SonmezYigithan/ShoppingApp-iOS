//
//  HomeVM.swift
//  ShoppingApp
//
//  Created by Yiğithan Sönmez on 13.02.2024.
//

import Foundation

protocol HomeVMProtocol: AnyObject {
    var view: HomeVC? { get set }
    var bestSelling: [Product] { get }
    var specialOffers: [Product] { get }
    
    func viewDidLoad()
    func didSelectProduct(at index: Int)
}

class HomeVM {
    weak var view: HomeVC?
    var bestSelling = [Product]()
    var specialOffers = [Product]()
    
    private func fetchBestSellingProducts() {
        StoreService.shared.fetchBestSelling(limit: 5) { [weak self] result in
            switch(result){
            case .success(let products):
                self?.bestSelling.append(contentsOf: products)
                self?.view?.reloadTableView()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fetchSpecialOffers() {
        StoreService.shared.fetchSpecialOffers(limit: 5) { [weak self] result in
            switch(result){
            case .success(let products):
                self?.specialOffers.append(contentsOf: products)
                self?.view?.reloadTableView()
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension HomeVM: HomeVMProtocol {
    func viewDidLoad() {
        fetchBestSellingProducts()
        fetchSpecialOffers()
    }
    
    func didSelectProduct(at index: Int) {
        let vc = ProductDetailsVC()
        vc.configure(with: bestSelling[index])
        view?.navigateToProductDetails(vc: vc)
    }
}
