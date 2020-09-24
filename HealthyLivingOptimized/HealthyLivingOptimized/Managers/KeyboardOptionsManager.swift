//
//  KeyboardOptionsManager.swift
//  HealthyLivingOptimized
//
//  Created by Robinson Paz Jesus on 8/12/20.
//  Copyright © 2020 Unagi Lab. All rights reserved.
//

import Foundation
import IQKeyboardManagerSwift

class KeyboardOptionsManager: NSObject {
    
    static func start() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 30
    }
}

