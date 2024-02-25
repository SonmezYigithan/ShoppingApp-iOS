//
//  CategoryDetailsPresenter.swift
//  ShoppingApp
//
//  Created by Yiğithan Sönmez on 23.02.2024.
//

import Foundation

class CategoryDetailsPresenter {
    private unowned let view: CategoryDetailsVC
    private var interactor: CategoryDetailsInteractorProtocol
    private let router: CategoryDetailsRouterProtocol
    var category: Category
    
    init(view: CategoryDetailsVC, interactor: CategoryDetailsInteractorProtocol, router: CategoryDetailsRouterProtocol, category: Category) {
        self.view = view
        self.category = category
        self.interactor = interactor
        self.router = router
        self.interactor.delegate = self
    }
}

extension CategoryDetailsPresenter: CategoryDetailsPresenterProtocol {
    func load() {
        interactor.load()
    }
    
    func selectProductItem(at index: Int) {
        interactor.selectProductItem(at: index)
    }
}

extension CategoryDetailsPresenter: CategoryDetailsInteractorDelegate {
    func handleOutput(_ output: CategoryDetailsInteractorOutput) {
        switch output {
        case .setLoading(let isLoading):
            view.handleOutput(.setLoading(isLoading))
        case .showCategoryProducts(let products):
            let productPresenter = products.map { ProductPresenter(productName: $0.title,
                                                                   productImageURL: $0.image,
                                                                   productPrice: String($0.price))}
            view.handleOutput(.showCategoryProducts(productPresenter))
        case .showProductDetails(let product):
            router.navigate(to: .productDetail(product))
        }
    }
}
