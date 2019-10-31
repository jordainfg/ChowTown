////
////  UITextFIield+extension.swift
////  VisitorsApp
////
////  Created by Jordain Gijsbertha on 7/23/19.
////  Copyright © 2019 Jordain  Gijsbertha. All rights reserved.
////
//
//import Foundation
//import SkyFloatingLabelTextField
//import UIKit
//
//public extension UITextField {
//    func setLeftPaddingPoints(_ amount: CGFloat) {
//        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: frame.size.height))
//        leftView = paddingView
//        leftViewMode = .always
//    }
//
//    func setRightPaddingPoints(_ amount: CGFloat) {
//        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: frame.size.height))
//        rightView = paddingView
//        rightViewMode = .always
//    }
//}
//
//@IBDesignable
//class GradientView: UIView {
//    @IBInspectable var startColor: UIColor = .black { didSet { updateColors() } }
//    @IBInspectable var endColor: UIColor = .white { didSet { updateColors() } }
//    @IBInspectable var startLocation: Double = 0.05 { didSet { updateLocations() } }
//    @IBInspectable var endLocation: Double = 0.95 { didSet { updateLocations() } }
//    @IBInspectable var horizontalMode: Bool = false { didSet { updatePoints() } }
//    @IBInspectable var diagonalMode: Bool = false { didSet { updatePoints() } }
//
//    public override class var layerClass: AnyClass { return CAGradientLayer.self }
//
//    var gradientLayer: CAGradientLayer { return layer as! CAGradientLayer }
//
//    func updatePoints() {
//        if horizontalMode {
//            gradientLayer.startPoint = diagonalMode ? CGPoint(x: 1, y: 0) : CGPoint(x: 0, y: 0.5)
//            gradientLayer.endPoint = diagonalMode ? CGPoint(x: 0, y: 1) : CGPoint(x: 1, y: 0.5)
//        } else {
//            gradientLayer.startPoint = diagonalMode ? CGPoint(x: 0, y: 0) : CGPoint(x: 0.5, y: 0)
//            gradientLayer.endPoint = diagonalMode ? CGPoint(x: 1, y: 1) : CGPoint(x: 0.5, y: 1)
//        }
//    }
//
//    func updateLocations() {
//        gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
//    }
//
//    func updateColors() {
//        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
//    }
//
//    public override func layoutSubviews() {
//        super.layoutSubviews()
//        updatePoints()
//        updateLocations()
//        updateColors()
//    }
//}
