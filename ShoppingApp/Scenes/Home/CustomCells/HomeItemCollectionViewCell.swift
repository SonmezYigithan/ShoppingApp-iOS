//
//  HomeItemCollectionViewCell.swift
//  ShoppingApp
//
//  Created by Yiğithan Sönmez on 13.02.2024.
//

import UIKit

class HomeItemCollectionViewCell: UICollectionViewCell {
    static let identifier = "HomeItemCollectionViewCell"
    
    let productImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .blue
        return image
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.text = "Apple"
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "$4.99"
        return label
    }()
    
    let addToCartButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 6
        button.configuration = .tinted()
        button.configuration?.baseBackgroundColor = .systemGreen
        button.configuration?.title = "+"
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func prepareView() {
        layer.cornerRadius = 17
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        
        addSubview(productImage)
        addSubview(nameLabel)
        addSubview(priceLabel)
        addSubview(addToCartButton)
        
        applyConstraints()
    }
    
    private func applyConstraints() {
        productImage.snp.makeConstraints { make in
            make.leading.top.equalTo(self).offset(10)
            make.trailing.equalTo(-10)
            make.height.equalTo(125)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(self).offset(20)
            make.trailing.equalTo(self).offset(-20)
            make.top.equalTo(productImage.snp.bottom).offset(10)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading).offset(20)
            make.trailing.equalTo(addToCartButton.snp.leading)
            make.bottom.equalTo(self.snp.bottom).offset(-20)
        }
        
        addToCartButton.snp.makeConstraints { make in
            make.leading.equalTo(priceLabel.snp.trailing)
            make.trailing.equalTo(self.snp.trailing).offset(-20)
            make.bottom.equalTo(self.snp.bottom).offset(-20)
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
    }
}
