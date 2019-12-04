//
//  LoginTextField.swift
//  AdminVisitorsRegistration
//
//  Created by Jordain Gijsbertha on 7/25/19.
//  Copyright © 2019 Jordain  Gijsbertha. All rights reserved.
//

import Foundation
import SkyFloatingLabelTextField
import UIKit

class LoginTextField: SkyFloatingLabelTextField {
    private let leftPadding = CGFloat(13)
    open override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        let rect = CGRect(
            x: leftPadding,
            y: titleHeight(),
            width: bounds.size.width,
            height: bounds.size.height - titleHeight() - selectedLineHeight
        )
        return rect
    }

    override func titleLabelRectForBounds(_ bounds: CGRect, editing: Bool) -> CGRect {
        if editing {
            return CGRect(x: leftPadding, y: 7, width: bounds.size.width, height: titleHeight())
        }
        return CGRect(x: leftPadding, y: titleHeight(), width: bounds.size.width, height: titleHeight())
    }
}
