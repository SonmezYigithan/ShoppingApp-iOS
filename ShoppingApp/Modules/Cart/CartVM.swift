////
////  CartVM.swift
////  ShoppingApp
////
////  Created by Yiğithan Sönmez on 17.02.2024.
////
//
//import Foundation
//
//protocol CartVMProtocol: AnyObject {
//    var view: CartVCProtocol? { get set }
//    
//    func viewWillAppear()
//    func getProductCountInCart() -> Int
//    func getProduct(at index: Int) -> ProductEntity
//    func increaseAmount(of product: ProductEntity)
//    func decreaseAmount(of product: ProductEntity)
//    func deleteProduct(at index: Int)
//    func checkout()
//}
//
//class CartVM {
//    weak var view: CartVCProtocol?
//    var products = [ProductEntity]()
//    
//    func fetchProductsInCart() {
//        if let products = CoreDataManager.shared.getProductsInCart() {
//            self.products = products
//            view?.reloadTableView()
//        }
//    }
//}
//
//extension CartVM: CartVMProtocol {
//    func viewWillAppear() {
//        fetchProductsInCart()
//    }
//    
//    func getProductCountInCart() -> Int {
//        return products.count
//    }
//    
//    func getProduct(at index: Int) -> ProductEntity {
//        return products[index]
//    }
//    
//    func increaseAmount(of product: ProductEntity) {
//        CoreDataManager.shared.increaseProductAmount(product: product)
//        view?.reloadTableView()
//    }
//    
//    func decreaseAmount(of product: ProductEntity) {
//        if product.amount > 1 {
//            CoreDataManager.shared.decreaseProductAmount(product: product)
//        }
//        view?.reloadTableView()
//    }
//    
//    func deleteProduct(at index: Int) {
//        CoreDataManager.shared.deleteProductFromCart(product: products[index])
//        products.remove(at: index)
//    }
//    
//    func checkout() {
//        CoreDataManager.shared.deleteAllProducts()
//        products.removeAll()
//        view?.reloadTableView()
//    }
//}
