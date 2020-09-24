//
//  UIImageView+Ext.swift
//  HealthyLivingOptimized
//
//  Created by Robinson Paz Jesus on 8/7/20.
//  Copyright © 2020 Unagi Lab. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func set(with link: String?, placeholder: UIImage?) {
        image = placeholder
        guard let stringLink = link else { return }
        if let url = URL(string: stringLink) {
            kf.setImage(with: url)
        }
    }
}
