//
//  UINavigationItem+Ext.swift
//  HealthyLivingOptimized
//
//  Created by Robinson Paz Jesus on 8/9/20.
//  Copyright © 2020 Unagi Lab. All rights reserved.
//

import UIKit

extension UINavigationItem {
    
    func setTitle(title: String, subtitle: String?) {
        
        guard let subtitle = subtitle else {
            self.title = title
            return
        }
        
        let one = UILabel()
        one.text = title
        one.font = UIFont.boldSystemFont(ofSize: 16)
        one.sizeToFit()
        
        let two = UILabel()
        two.text = subtitle
        two.font = UIFont.systemFont(ofSize: 12)
        two.textAlignment = .center
        two.sizeToFit()
        
        let stackView = UIStackView(arrangedSubviews: [one, two])
        stackView.distribution = .equalCentering
        stackView.axis = .vertical
        stackView.alignment = .center
        
        let width = max(one.frame.size.width, two.frame.size.width)
        stackView.frame = CGRect(x: 0, y: 0, width: width, height: 35)
        
        one.sizeToFit()
        two.sizeToFit()
        
        self.titleView = stackView
    }
}
