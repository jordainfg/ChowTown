//
//  UIImageView+extension.swift
//  VisitorsApp
//
//  Created by Jordain Gijsbertha on 7/26/19.
//  Copyright © 2019 Jordain  Gijsbertha. All rights reserved.
//

import Foundation
import UIKit

public extension UIImageView {
    func setRounded() {
        layer.cornerRadius = (frame.width / 2) // instead of let radius = CGRectGetWidth(self.frame) / 2
        layer.masksToBounds = true
    }
    func roundCornerss(_ corners: UIRectCorner, radius: CGFloat) {
            let maskPath = UIBezierPath(roundedRect: bounds,
                                        byRoundingCorners: corners,
                                        cornerRadii: CGSize(width: radius, height: radius))
            let shape = CAShapeLayer()
            shape.path = maskPath.cgPath
            layer.mask = shape
        }
    
    
}
