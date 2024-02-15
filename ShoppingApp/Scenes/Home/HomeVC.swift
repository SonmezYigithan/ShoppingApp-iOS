//
//  ViewController.swift
//  ShoppingApp
//
//  Created by Yiğithan Sönmez on 12.02.2024.
//

import UIKit
import SnapKit

protocol HomeVCProtocol {
    func reloadTableView()
}

class HomeVC: UIViewController {
    // MARK: - TypeAlias
    
    typealias BannerCell = HomeBannerCollectionViewCell
    typealias ProductCell = HomeProductTableViewCell
    
    // MARK: - Properties
    private lazy var viewModel: HomeVMProtocol = HomeVM()
    
    let sectionNames = ["Best Selling", "Special Offer"]
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    let bannerCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = .init(top: 0, left: 15, bottom: 0, right: 15)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(BannerCell.self, forCellWithReuseIdentifier: BannerCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.register(ProductCell.self, forCellReuseIdentifier: ProductCell.identifier)
        return tableView
    }()
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.fetchBestSellingProducts()
        prepareView()
    }
    
    private func prepareView() {
        view.backgroundColor = .systemBackground
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(bannerCollectionView)
        stackView.addArrangedSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        
        applyConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.layoutIfNeeded()
        tableView.snp.updateConstraints { make in
            make.height.equalTo(tableView.contentSize.height)
        }
    }
    
    // MARK: - Constraints
    
    private func applyConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(scrollView)
            make.width.equalTo(scrollView.snp.width)
        }
        
        bannerCollectionView.snp.makeConstraints { make in
            make.height.equalTo(180)
            make.width.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.height.equalTo(0)
            make.width.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDelegate

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionNames.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionNames[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.identifier, for: indexPath) as? ProductCell else {
            return UITableViewCell()
        }
        cell.configure(with: viewModel.products)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}

// MARK: - UICollectionViewDelegate

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCell.identifier, for: indexPath) as? BannerCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 20, height: 180)
    }
}

extension HomeVC: HomeVCProtocol {
    func reloadTableView() {
        tableView.reloadData()
    }
}
