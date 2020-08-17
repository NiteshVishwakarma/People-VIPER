//
//  UIView+Ext.swift
//  People
//
//  Created by Nitesh Vishwakarma on 15/08/20.
//  Copyright © 2020 Nitesh Vishwakarma. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    /// Helps to corner radius specific corners of the view.
    /// - Parameters:
    ///   - corners: Array of corner.
    ///   - radius: Size for the radius.
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        DispatchQueue.main.async { [weak self] in
            let path = UIBezierPath(roundedRect: self?.bounds ?? CGRect(), byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self?.layer.mask = mask
        }
    }
    
}
