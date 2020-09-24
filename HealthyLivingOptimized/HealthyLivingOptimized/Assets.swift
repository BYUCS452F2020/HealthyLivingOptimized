//
//  Assets.swift
//  TODO
//
//  Created by Robinson Paz Jesus on 7/13/20.
//  Copyright © 2020 Robinson Paz Jesus. All rights reserved.
//

import UIKit

struct Assets {
    struct Image {
        
        static let logo = UIImage(named: "logo")
        static let background = UIImage(named: "background")
        
        
        /// System Default
        static let bookmark = UIImage(systemName: "bookmark")?.withRenderingMode(.alwaysTemplate)
        static let bookmarkFill = UIImage(systemName: "bookmark.fill")?.withRenderingMode(.alwaysTemplate)
        static let settings = UIImage(systemName: "slider.horizontal.3")?.withRenderingMode(.alwaysTemplate)
        static let arrowShare = UIImage(systemName: "arrowshape.turn.up.right")?.withRenderingMode(.alwaysTemplate)
        static let arrowShareFill = UIImage(systemName: "arrowshape.turn.up.right.fill")?.withRenderingMode(.alwaysTemplate)
        static let document = UIImage(systemName: "doc.plaintext")?.withRenderingMode(.alwaysTemplate)
        static let play = UIImage(systemName: "play.fill")?.withRenderingMode(.alwaysTemplate)
        static let plus = UIImage(systemName: "plus.circle.fill")?.withRenderingMode(.alwaysTemplate)
        static let rightChevron = UIImage(systemName: "chevron.right")?.withRenderingMode(.alwaysTemplate)
        static let close = UIImage(systemName: "xmark.circle.fill")?.withRenderingMode(.alwaysTemplate)
        static let calendar = UIImage(systemName: "calendar")?.withRenderingMode(.alwaysTemplate)
        static let camera = UIImage(systemName: "camera")?.withRenderingMode(.alwaysTemplate)
        static let recordVideo = UIImage(systemName: "video.badge.plus")?.withRenderingMode(.alwaysTemplate)

        
        /// Tab bar items
        static let house = UIImage(systemName: "house")?.withRenderingMode(.alwaysTemplate)
        static let search = UIImage(systemName: "magnifyingglass")?.withRenderingMode(.alwaysTemplate)
        static let people = UIImage(systemName: "person.3")?.withRenderingMode(.alwaysTemplate)
        static let person = UIImage(systemName: "person")?.withRenderingMode(.alwaysTemplate)
        static let houseFill = UIImage(systemName: "house.fill")?.withRenderingMode(.alwaysTemplate)
        static let searchFill = UIImage(systemName: "plus.magnifyingglass")?.withRenderingMode(.alwaysTemplate)
        static let peopleFill = UIImage(systemName: "person.3.fill")?.withRenderingMode(.alwaysTemplate)
        static let personFill = UIImage(systemName: "person.fill")?.withRenderingMode(.alwaysTemplate)
        
        
        /// Settings
        static let friends = UIImage(systemName: "person.2")
        static let star = UIImage(systemName: "star")
        static let envelopeOpen = UIImage(systemName: "envelope.open")
        static let eyeglasses = UIImage(systemName: "eyeglasses")
        static let signature = UIImage(systemName: "signature")
        static let docPlaintext = UIImage(systemName: "doc.plaintext")
        static let escape = UIImage(systemName: "escape")
        
        
    }
    
    struct Color {
        static let primary = UIColor(netHex: 0xFD634D)
        static let secondary = UIColor(netHex: 0xF89F00)
        
        // Grays
        static let pages = getDynamicColor(dark: .black, light: .white)
        static let cellWhite = getDynamicColor(dark: UIColor(netHex: 0x1D1D21), light: .white)
        static let slider = getDynamicColor(dark: UIColor(netHex: 0x1D1D21), light: UIColor(netHex: 0xF0F0F0))
    
        /// Light: Soft soft gray, dark: black
        static let softSoftGray = getDynamicColor(dark: .black, light: UIColor(netHex: 0xF0F0F0))
        static let tabBarGray = UIColor(netHex: 0xD2D2D2)
        static let softGray = UIColor(netHex: 0x838383)
        
        /// Light: .label. Dark: .white
        static let activeCell = getDynamicColor(dark: .white, light: .label)
        static let unactiveCell = getDynamicColor(dark: .darkText, light: softGray)
        
        static let lines = getDynamicColor(dark: UIColor(netHex: 0x838383).withAlphaComponent(0.3), light: softSoftGray)
        
        // Text
        static let darkText = UIColor(netHex: 0x0C0C0C)
        
        static let tabIconsTint = getDynamicColor(dark: primary, light: UIColor(netHex: 0x0C0C0C))
        static let buttonTint = getDynamicColor(dark: .white, light: UIColor(netHex: 0x0C0C0C))
        
        // Custom colors
        static let heartRed = UIColor(netHex: 0xC30606)
        static let greenGo = UIColor(netHex: 0x00D024)
        static let charcoal = UIColor(netHex: 0x302F36)
        static let warning = UIColor(netHex: 0xFF6600)
        
        
        /// Setting colors
        static let friendColor = UIColor(netHex: 0x189ED9)
        static let rateColor = UIColor(netHex: 0xFFC400)
        static let feedbackColor = UIColor(netHex: 0xEB5D12)
        static let websiteColor = UIColor(netHex: 0xC758BB)
        static let termsColor = UIColor(netHex: 0x0B8B15)
        static let privacyColor = UIColor(netHex: 0x0E84FA)
        static let logoutColor = UIColor(netHex: 0x9E0C0C)
        
        
        static func getDynamicColor(dark: UIColor, light: UIColor) -> UIColor {
            if #available(iOS 13, *) {
                return UIColor.init { (trait) -> UIColor in
                    return trait.userInterfaceStyle == .dark ? dark : light
                }
            }
            else { return light }
        }
    }
    
    struct Font {
        
        static func with(weight: UIFont.Weight, size: CGFloat) -> UIFont {
            return UIFont.systemFont(ofSize: size, weight: weight)
        }
    }
}



extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}
