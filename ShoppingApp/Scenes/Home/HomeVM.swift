//
//  HomeVM.swift
//  ShoppingApp
//
//  Created by Yiğithan Sönmez on 13.02.2024.
//

import Foundation

protocol HomeVMProtocol {
    var view: HomeVC? { get set }
    
}

class HomeVM {
    weak var view: HomeVC?
    
}

extension HomeVM: HomeVMProtocol {
    
}
