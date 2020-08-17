//
//  Font.swift
//  People
//
//  Created by Nitesh Vishwakarma on 15/08/20.
//  Copyright © 2020 Nitesh Vishwakarma. All rights reserved.
//

import Foundation
import UIKit

class Font {
    
    /// Helps to maintain font states.
    enum FType {
        case regular
        case light
        case medium
        case bold
        
        var value: String {
            switch self {
            case .regular:
                return "ProductSans-Regular"
            case .light:
                return "ProductSans-Light"
            case .medium:
                return "ProductSans-Medium"
            case .bold:
                return "ProductSans-Bold"
            }
        }
    }
    
    /// Helps to provide font as required.
    /// - Parameters:
    ///   - type: Regular, Light, Medium or Bold.
    ///   - size: Size for the font.
    /// - Returns: Customized font.
    public static func set(type: FType,size: CGFloat) -> UIFont {
        return UIFont(name: type.value, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    /// Helps to set font to UILabel.
    /// - Parameters:
    ///   - labels: Provide instance of label with similar font type and size.
    ///   - type: Regular, Light, Medium or Bold.
    ///   - size: Size for the font.
    public static func set(labels: [UILabel], type: FType, size: CGFloat) {
        for i in labels {
            i.font = set(type: type, size: size)
        }
    }
    
}
