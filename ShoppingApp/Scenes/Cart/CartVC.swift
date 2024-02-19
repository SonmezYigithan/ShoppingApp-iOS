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
        
        tableView.delegate = self
        tableView.dataSource = self
        
        applyConstraints()
    }
    
    // MARK: - Constraints
    
    private func applyConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view)
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
