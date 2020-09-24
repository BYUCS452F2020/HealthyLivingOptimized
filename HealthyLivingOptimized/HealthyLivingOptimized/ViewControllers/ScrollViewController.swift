//
//  ScrollViewController.swift
//  HealthyLivingOptimized
//
//  Created by Robinson Paz Jesus on 8/4/20.
//  Copyright © 2020 Unagi Lab. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController {
    
    // MARK: - UI Properties
    var scrollView = UIScrollView()
    let contentView = UIView()
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
    }
    
    func setupScrollView(){
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        scrollView.addSubview(contentView)
        contentView.fillSuperview()
        contentView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        contentView.backgroundColor = Assets.Color.pages
        
        let heightConstraint = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        heightConstraint.priority = .defaultLow
        heightConstraint.isActive = true
    }
}
