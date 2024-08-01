//
//  UIView+Extension.swift
//  IncomingCallExperience
//
//  Created by Space Wizard on 8/1/24.
//

import Foundation
import UIKit

extension UIView {
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        // Create a path with rounded corners
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        
        // Create a shape layer and set its path
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        
        // Apply the mask to the view
        layer.mask = mask
    }
}
