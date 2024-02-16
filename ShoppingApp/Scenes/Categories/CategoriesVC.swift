//
//  CartVC.swift
//  ShoppingApp
//
//  Created by Yiğithan Sönmez on 13.02.2024.
//

import UIKit

protocol CategoriesVCProtocol: AnyObject {
    func reloadCollectionView()
    func navigateToCategoryProducts(with categoryProductsVC: CategoryProductsVC)
}

class CategoriesVC: UIViewController {
    // MARK: - TypeAlias
    
    typealias Cell = CategoryCollectionViewCell
    
    // MARK: - Properties
    
    private lazy var viewModel: CategoriesVMProtocol = CategoriesVM()
    
    let categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .init(top: 0, left: 15, bottom: 0, right: 15)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(Cell.self, forCellWithReuseIdentifier: Cell.identifier)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.fetchAllCategories()
        prepareView()
    }
    
    private func prepareView() {
        title = "Categories"
        
        view.addSubview(categoryCollectionView)
        
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        
        applyConstraints()
    }
    
    private func applyConstraints() {
        categoryCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension CategoriesVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.identifier, for: indexPath) as? Cell else {
            return UICollectionViewCell()
        }
        cell.configure(with: viewModel.categories[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/2 - 20, height: 220)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectCategoryItemAt(indexPath.item)
    }
}

extension CategoriesVC: CategoriesVCProtocol {
    func reloadCollectionView() {
        categoryCollectionView.reloadData()
    }
    
    func navigateToCategoryProducts(with categoryProductsVC: CategoryProductsVC) {
        navigationController?.pushViewController(categoryProductsVC, animated: true)
    }
}
