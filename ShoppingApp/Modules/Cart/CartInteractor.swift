//
//  CartInteractor.swift
//  ShoppingApp
//
//  Created by Yiğithan Sönmez on 29.02.2024.
//

import Foundation

class CartInteractor {
    weak var delegate: CartInteractorDelegate?
    private let service: StoreServiceDelegate
    
    var productEntities = [ProductEntity]()
    
    init(service: StoreServiceDelegate) {
        self.service = service
    }
    
    func fetchProductsInCart() {
        if let products = CoreDataManager.shared.getProductsInCart() {
            self.productEntities = products
            delegate?.handleOutput(.showProducts(products))
        }
    }
}

extension CartInteractor: CartInteractorProtocol {
    func load() {
        fetchProductsInCart()
    }
    
    func checkout() {
        CoreDataManager.shared.deleteAllProducts()
        productEntities.removeAll()
        delegate?.handleOutput(.showCheckoutSuccess)
    }
    
    func increaseAmount(at index: Int) {
        let amount = Int(productEntities[index].amount)
        CoreDataManager.shared.increaseProductAmount(product: productEntities[index])
        delegate?.handleOutput(.updateAmount((index, amount + 1)))
    }
    
    func decreaseAmount(at index: Int) {
        let amount = Int(productEntities[index].amount)
        if amount > 1 {
            CoreDataManager.shared.decreaseProductAmount(product: productEntities[index])
            delegate?.handleOutput(.updateAmount((index, amount - 1)))
        }
    }
    
    func deleteProduct(at index: Int) {
        CoreDataManager.shared.deleteProductFromCart(product: productEntities[index])
        productEntities.remove(at: index)
    }
}
