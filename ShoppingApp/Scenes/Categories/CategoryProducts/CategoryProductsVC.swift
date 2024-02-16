//
//  CategoryProductsVC.swift
//  ShoppingApp
//
//  Created by Yiğithan Sönmez on 15.02.2024.
//

import UIKit

protocol CategoryProductsVCProtocol: AnyObject {
    func reloadCollectionView()
    func navigateToProductDetails(vc: ProductDetailsVC)
}

final class CategoryProductsVC: UIViewController {
    // MARK: - TypeAlias
    
    typealias Cell = HomeItemCollectionViewCell
    
    // MARK: - Properties
    
    lazy var viewModel: CategoryProductsVMProtocol = CategoryProductsVM()
    
    let productCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = .init(top: 0, left: 15, bottom: 0, right: 15)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(Cell.self, forCellWithReuseIdentifier: Cell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        prepareView()
    }
    
    func configure(with categoryName: String) {
        title = categoryName
        viewModel.fetchAllProductsInCategory(category: categoryName)
    }
    
    private func prepareView() {
        view.addSubview(productCollectionView)
        
        productCollectionView.dataSource = self
        productCollectionView.delegate = self
        
        applyConstraints()
    }
    
    // MARK: - Constraints
    
    private func applyConstraints() {
        productCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - UICollectionViewDelegate

extension CategoryProductsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.identifier, for: indexPath) as? Cell else {
            return UICollectionViewCell()
        }
        cell.configure(with: viewModel.products[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/2 - 20 , height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectProduct(at: indexPath.item)
    }
}

extension CategoryProductsVC: CategoryProductsVCProtocol {
    func reloadCollectionView() {
        productCollectionView.reloadData()
    }
    
    func navigateToProductDetails(vc: ProductDetailsVC) {
        navigationController?.pushViewController(vc, animated: true)
    }
}
