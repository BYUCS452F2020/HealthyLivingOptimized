//
//  UITextField+Ext.swift
//  HealthyLivingOptimized
//
//  Created by Robinson Paz Jesus on 8/4/20.
//  Copyright © 2020 Unagi Lab. All rights reserved.
//

import UIKit

extension UITextField {
    func themed(placeholder: String) {
        attributedPlaceholder = NSAttributedString(string: placeholder,
                                                   attributes: [.foregroundColor: UIColor.white.withAlphaComponent(0.5)])
    }
}
