//
//  CartContracts.swift
//  ShoppingApp
//
//  Created by Yiğithan Sönmez on 29.02.2024.
//

// MARK: - View

protocol CartViewProtocol: AnyObject {
    func handleOutput(_ output: CartPresenterOutput)
}

// MARK: - Presenter

protocol CartPresenterProtocol: AnyObject {
    func load()
    func checkout()
    func increaseAmount(at index: Int)
    func decreaseAmount(at index: Int)
    func deleteProduct(at index: Int)
}

enum CartPresenterOutput {
    case setLoading(Bool)
    case showProducts([ProductCartPresentation])
    case showCheckoutSuccess
    case updateAmount((Int,Int))
    case showEmptyCartView
}

// MARK: - Interactor

protocol CartInteractorProtocol: AnyObject {
    var delegate: CartInteractorDelegate? { get set }
    func load()
    func checkout()
    func increaseAmount(at index: Int)
    func decreaseAmount(at index: Int)
    func deleteProduct(at index: Int)
}

protocol CartInteractorDelegate: AnyObject {
    func handleOutput(_ output: CartInteractorOutput)
}

enum CartInteractorOutput {
    case setLoading(Bool)
    case showCheckoutSuccess
    case showProducts([ProductEntity])
    /// (index, amount)
    case updateAmount((Int,Int))
    case showCartEmpty
}

// MARK: - Router
