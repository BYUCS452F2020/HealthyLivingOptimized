//
//  HistoryCell.swift
//  HealthyLivingOptimized
//
//  Created by Robinson Paz Jesus on 10/19/20.
//  Copyright © 2020 Unagi Lab. All rights reserved.
//

import UIKit

class HistoryCell: UICollectionViewCell {
    
    static let identifier = "HistoryCellIdentifier"
    
    let title: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    let body: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.add(radius: 12, shadow: true)
        setupViews()
        bind()
    }
    
    func setupViews() {
        contentView.backgroundColor = .white
        
        /// main stack
        let mainStack = UIStackView(arrangedSubviews: [title, body])
        mainStack.axis = .vertical
        contentView.addSubview(mainStack)
        mainStack.fillSuperview(padding: UIEdgeInsets(top: 16, left: 32, bottom: 16, right: 32))
    }
    
    func bind() {
        
    }
    
    func configure(title: String, body: String) {
        self.title.text = title
        self.body.text = body
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
