//
//  CartVC.swift
//  ShoppingApp
//
//  Created by Yiğithan Sönmez on 13.02.2024.
//

import UIKit

protocol CartVCProtocol: AnyObject {
    func reloadTableView()
}

class CartVC: UIViewController {
    // MARK: - TypeAlias
    
    typealias Cell = CartTableViewCell
    
    // MARK: - Properties
    
    lazy var viewModel: CartVMProtocol = CartVM()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(Cell.self, forCellReuseIdentifier: Cell.identifier)
        return tableView
    }()
    
    let checkoutButton: UIButton = {
        let button = UIButton()
        button.configuration = .plain()
        button.backgroundColor = .systemGreen
        button.tintColor = .white
        button.layer.cornerRadius = 20
        button.configuration?.title = "Checkout"
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        prepareView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
    
    // MARK: - LifeCycle
    
    private func prepareView() {
        title = "My Cart"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        view.addSubview(checkoutButton)
        
        checkoutButton.addTarget(self, action: #selector(checkoutButtonClicked), for: .touchUpInside)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        applyConstraints()
    }
    
    @objc private func checkoutButtonClicked() {
        viewModel.checkout()
    }
    
    // MARK: - Constraints
    
    private func applyConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        
        checkoutButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(15)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-15)
            make.height.equalTo(60)
        }
    }
}

extension CartVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getProductCountInCart()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.identifier, for: indexPath) as? Cell else {
            return UITableViewCell()
        }
        cell.configure(with: viewModel.getProduct(at: indexPath.row), viewModel: viewModel)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, success) in
            self.viewModel.deleteProduct(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        let swipeActions = UISwipeActionsConfiguration(actions: [delete])
        return swipeActions
    }
}

extension CartVC: CartVCProtocol {
    func reloadTableView() {
        tableView.reloadData()
    }
}
