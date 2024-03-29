//
//  ProductDetailsInteractor.swift
//  ShoppingApp
//
//  Created by Yiğithan Sönmez on 25.02.2024.
//

import Foundation

class ProductDetailsInteractor {
    weak var delegate: ProductDetailsInteractorDelegate?
    private let service: StoreServiceDelegate
    private var product: Product
    
    init(service: StoreServiceDelegate, product: Product) {
        self.service = service
        self.product = product
    }
}

extension ProductDetailsInteractor: ProductDetailsInteractorProtocol {
    func load() {
        delegate?.handleOutput(.showProductDetails(product))
    }
    
    func addToCart() {
        CoreDataManager.shared.saveProductToCart(product: product, amount: 1)
        delegate?.handleOutput(.showAddToCartSuccess)
    }
}
