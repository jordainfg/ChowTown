//
//  UILabel+extension.swift
//  VisitorsApp
//
//  Created by Jordain Gijsbertha on 5/22/19.
//  Copyright © 2019 Jordain  Gijsbertha. All rights reserved.
//

import Foundation
import UIKit

public extension UILabel {
    func addImageToLabel(imageName: String, labelText: String) {
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named: imageName)
        // Set bound to reposition
        let imageOffsetY: CGFloat = -3.0
        imageAttachment.bounds = CGRect(x: -1.5, y: imageOffsetY, width: imageAttachment.image!.size.width / 1.7, height: imageAttachment.image!.size.height / 1.7)
        // Create string with attachment
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        // Initialize mutable string
        let completeText = NSMutableAttributedString(string: "")
        // Add image to mutable string
        completeText.append(attachmentString)
        // Add your text to mutable string
        let textAfterIcon = NSMutableAttributedString(string: labelText)
        completeText.append(textAfterIcon)

        textAlignment = .center
        attributedText = completeText
    }
}
