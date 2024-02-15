//
//  ProductNetworkManager.swift
//  ShoppingApp
//
//  Created by Yiğithan Sönmez on 14.02.2024.
//

import Foundation

class StoreAPIManager {
    static let shared = StoreAPIManager()
    
    // DOCUMENTATION
    // https://fakestoreapi.com/docs
    
    func fetchAllProducts(limit: Int = 0, completion: @escaping (Result<[Product],Error>)->()){
        let url = APIHelper.baseURL + "products" + limitQuery(limit)
        
        NetworkManager.shared.request([Product].self, url: url, method: .get) { result in
            switch result {
            case.success(let product):
                completion(.success(product))
            case.failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchAllCategories(completion: @escaping (Result<[String],Error>)->()){
        let url = APIHelper.baseURL + "products/categories"
        
        // unfortunately fakeStoreApi doesn't provide any images for categories. and just gives names
        NetworkManager.shared.request([String].self, url: url, method: .get) { result in
            switch result {
            case.success(let category):
                completion(.success(category))
            case.failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchAllProductsInCategory(categoryName: String, completion: @escaping (Result<[Product],Error>)->()) {
        // https://fakestoreapi.com/products/category/jewelery
        let url = APIHelper.baseURL + "products/category/" + categoryName
        
        NetworkManager.shared.request([Product].self, url: url, method: .get) { result in
            switch result {
            case.success(let products):
                completion(.success(products))
            case.failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func limitQuery(_ limit: Int) -> String {
        limit > 0 ? "?limit=\(limit)" : ""
    }
}
