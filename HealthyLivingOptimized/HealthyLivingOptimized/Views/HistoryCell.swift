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
    let df = DateFormatter()
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
    
    let deleteIcon: UIImageView = {
        let image = UIImageView(image: Assets.Image.trashCan)
        image.tintColor = .black
        return image
    }()
    
    func setupViews() {
        contentView.backgroundColor = .white
        
        /// main stack
        let mainStack = UIStackView(arrangedSubviews: [title, body])
        mainStack.axis = .vertical
        contentView.addSubview(mainStack)
        mainStack.fillSuperview(padding: UIEdgeInsets(top: 16, left: 32, bottom: 16, right: 32))
        
        /// Delete
        contentView.addSubview(deleteIcon)
        deleteIcon.anchor(bottom: contentView.bottomAnchor, right: contentView.rightAnchor, bCons: 8, rCons: 12, widthCons: 30, heightCons: 30)
    }
    
    func bind() {
        
    }
    
    func configure(model: EntryHistoryModel) {
        
        df.dateFormat = "yyyy-MM-dd"
        let date = df.date(from: model.date!)
        df.dateFormat = "EEEE, MMM d"
        self.title.text = df.string(from: date!)
        
        var body = "\("🛌💤".randomElement()!) \(model.hoursOfSleep) hours of sleep.\n"
        body += "\("🥑🍗".randomElement()!) \(model.gramsOfProtein) grams of protein.\n"
        body += "\("🏋️‍♂️💪".randomElement()!) \(model.minutesOfExercise) minutes of exercise."
        self.body.text = body
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
