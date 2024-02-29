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
    
    var presenter: CartPresenterProtocol?
    
    var products = [ProductCartPresentation]()
    
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
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.tintColor = .label
        spinner.style = .large
        return spinner
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.load()
    }
    
    // MARK: - LifeCycle
    
    private func prepareView() {
        title = "My Cart"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        view.addSubview(checkoutButton)
        view.addSubview(spinner)
        
        checkoutButton.addTarget(self, action: #selector(checkoutButtonClicked), for: .touchUpInside)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        applyConstraints()
    }
    
    @objc private func checkoutButtonClicked() {
        presenter?.checkout()
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
        
        spinner.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension CartVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.identifier, for: indexPath) as? Cell else {
            return UITableViewCell()
        }
        cell.configure(with: products[indexPath.row], presenter: presenter, index: indexPath.row)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, success) in
            self.presenter?.deleteProduct(at: indexPath.row)
            self.products.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        let swipeActions = UISwipeActionsConfiguration(actions: [delete])
        return swipeActions
    }
}

extension CartVC: CartViewProtocol {
    func handleOutput(_ output: CartPresenterOutput) {
        switch output {
        case .setLoading(let isLoading):
            if isLoading {
                spinner.startAnimating()
            }else {
                spinner.stopAnimating()
            }
        case .showProducts(let products):
            self.products = products
            tableView.reloadData()
        case .updateAmount((let index, let amount)):
            let indexPath = IndexPath(row: index, section: 0)
            guard let cell = tableView.cellForRow(at: indexPath) as? Cell else { return }
            cell.updateAmount(amount: amount)
        case .showCheckoutSuccess:
            let indexPaths = products.indices.map { IndexPath(row: $0, section: 0) }
            products.removeAll()
            self.tableView.deleteRows(at: indexPaths, with: .automatic)
        }
    }
}
