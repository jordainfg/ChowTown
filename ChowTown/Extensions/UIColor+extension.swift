//
//  UIColor+extension.swift
//  VisitorsApp
//
//  Created by Jordain Gijsbertha on 8/17/19.
//  Copyright © 2019 Jordain  Gijsbertha. All rights reserved.
//

import Foundation
import UIKit
extension UIColor {
    
    @nonobjc class var veryLightPink: UIColor {
        return UIColor(white: 233.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var reddishOrange: UIColor {
        return UIColor(red: 251.0 / 255.0, green: 98.0 / 255.0, blue: 34.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var black74: UIColor {
        return UIColor(white: 0.0, alpha: 0.74)
    }
    
    @nonobjc class var softBlue: UIColor {
        return UIColor(red: 80.0 / 255.0, green: 138.0 / 255.0, blue: 246.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var slateGrey: UIColor {
        return UIColor(red: 97.0 / 255.0, green: 97.0 / 255.0, blue: 102.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var battleshipGrey: UIColor {
        return UIColor(red: 114.0 / 255.0, green: 114.0 / 255.0, blue: 127.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var black0: UIColor {
        return UIColor(white: 0.0, alpha: 0.0)
    }
    
    @nonobjc class var yellowish: UIColor {
        return UIColor(red: 1.0, green: 244.0 / 255.0, blue: 104.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var paleGrey: UIColor {
        return UIColor(red: 237.0 / 255.0, green: 237.0 / 255.0, blue: 242.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var black: UIColor {
        return UIColor(white: 0.0, alpha: 1.0)
    }
    
    @nonobjc class var darkTwo: UIColor {
    return UIColor(red: 20.0 / 255.0, green: 22.0 / 255.0, blue: 31.0 / 255.0, alpha: 1.0)
    }
    
   
    @nonobjc class var lightPeriwinkle: UIColor {
    return UIColor(red: 217.0 / 255.0, green: 216.0 / 255.0, blue: 225.0 / 255.0, alpha: 1.0)
    }
    
   
    @nonobjc class var reddish: UIColor {
        return UIColor(red: 194.0 / 255.0, green: 71.0 / 255.0, blue: 71.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var duckEggBlue: UIColor {
    return UIColor(red: 207.0 / 255.0, green: 245.0 / 255.0, blue: 231.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var pine: UIColor {
        return UIColor(red: 40.0 / 255.0, green: 90.0 / 255.0, blue: 71.0 / 255.0, alpha: 1.0)
    }
    
     static let verylightblue = UIColor(red: 228.0 / 255.0, green: 238.0 / 255.0, blue: 251.0 / 255.0, alpha: 1.0)
    
    
    @nonobjc class var dark: UIColor {
        return UIColor(red: 41.0 / 255.0, green: 52.0 / 255.0, blue: 67.0 / 255.0, alpha: 1.0)
    }
    

        static var random: UIColor {
            return UIColor(red: .random(in: 0...1),
                           green: .random(in: 0...1),
                           blue: .random(in: 0...1),
                           alpha: 1.0)
        }
  
    

    
}
public extension UIColor{
   static  func hexStringToUIColor (hex:String) -> UIColor {
          var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

          if (cString.hasPrefix("#")) {
              cString.remove(at: cString.startIndex)
          }

          if ((cString.count) != 6) {
              return UIColor.gray
          }

          var rgbValue:UInt64 = 0
          Scanner(string: cString).scanHexInt64(&rgbValue)

          return UIColor(
              red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
              green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
              blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
              alpha: CGFloat(1.0)
          )
      }
}
