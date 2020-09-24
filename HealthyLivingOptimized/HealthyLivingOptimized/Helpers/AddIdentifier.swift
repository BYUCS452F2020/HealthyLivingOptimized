//
//  AddIdentifier.swift
//  TODO
//
//  Created by Robinson Paz Jesus on 1/30/20.
//  Copyright © 2020 Robinson Paz Jesus. All rights reserved.
//

import Foundation

protocol AddIdentifier: class {
    static var identifier: String { get }
}

extension AddIdentifier {
    static var identifier: String { return String(describing: self) }
}
