//
//  UIViewController+extension.swift
//  VisitorsApp
//
//  Created by Jordain Gijsbertha on 8/14/19.
//  Copyright © 2019 Jordain  Gijsbertha. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    override open func awakeFromNib() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
