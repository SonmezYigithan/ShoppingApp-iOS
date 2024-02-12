//
//  ViewController.swift
//  ShoppingApp
//
//  Created by Yiğithan Sönmez on 12.02.2024.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .red
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
    }
    
    private func prepareView() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        
        applyConstraints()
    }
    
    private func applyConstraints() {
        tableView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

}

