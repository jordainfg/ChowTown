//
//  LeftAlignedIconButton.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 12/12/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import Foundation
import UIKit
@IBDesignable
class LeftAlignedIconButton: UIButton {
   override func layoutSubviews() {
        super.layoutSubviews()
        contentHorizontalAlignment = .left
    let availableSpace = bounds.inset(by: contentEdgeInsets)
        let availableWidth = availableSpace.width - imageEdgeInsets.right - (imageView?.frame.width ?? 0) - (titleLabel?.frame.width ?? 0)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: availableWidth / 2, bottom: 0, right: 0)
    }
}
