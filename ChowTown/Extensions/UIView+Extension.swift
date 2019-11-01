//
//  UIView+Extension.swift
//  Club Vers
//
//  Created by Jordain Gijsbertha on 2/20/19.
//  Copyright © 2019 Jordain  Gijsbertha. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableView: UIView {}

@IBDesignable
class DesignableButton: UIButton {}

@IBDesignable
class DesignableLabel: UILabel {}

extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }

    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }

    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }

    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }

    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }

    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }

    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }

   func setGradientBackground(colorOne: UIColor, colorTwo: UIColor) {
          
          let gradientLayer = CAGradientLayer()
          gradientLayer.frame = bounds
          gradientLayer.colors = [UIColor.clear.cgColor, UIColor.white.cgColor, UIColor.white.cgColor, UIColor.clear.cgColor]
          gradientLayer.locations = [0, 0.1, 0.9, 1]
         // gradientLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
              // gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)

          layer.insertSublayer(gradientLayer, at: 0)
      }
}

extension UIAlertController {
    private struct ActivityIndicatorData {
        static var activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
    }

    func addActivityIndicator() {
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: 40, height: 40)
        ActivityIndicatorData.activityIndicator.color = UIColor.blue
        ActivityIndicatorData.activityIndicator.startAnimating()
        vc.view.addSubview(ActivityIndicatorData.activityIndicator)
        setValue(vc, forKey: "contentViewController")
    }

    func dismissActivityIndicator() {
        ActivityIndicatorData.activityIndicator.stopAnimating()
        dismiss(animated: false)
    }
}

var activityIndicatorAlert: UIAlertController?

func displayActivityIndicatorAlert() {
    activityIndicatorAlert = UIAlertController(title: NSLocalizedString("Loading", comment: ""), message: NSLocalizedString("PleaseWait", comment: "") + "...", preferredStyle: UIAlertController.Style.alert)
    activityIndicatorAlert!.addActivityIndicator()
    var topController: UIViewController = UIApplication.shared.keyWindow!.rootViewController!
    while topController.presentedViewController != nil {
        topController = topController.presentedViewController!
    }
    topController.present(activityIndicatorAlert!, animated: true, completion: nil)
}

func dismissActivityIndicatorAlert() {
    activityIndicatorAlert!.dismissActivityIndicator()
    activityIndicatorAlert = nil
}
