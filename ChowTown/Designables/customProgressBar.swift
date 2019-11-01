//
//  customProgressBar.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 01/11/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit

class customProgressBar: UIProgressView {

     override func layoutSubviews() {
          super.layoutSubviews()

          let maskLayerPath = UIBezierPath(roundedRect: bounds, cornerRadius: 4.0)
          let maskLayer = CAShapeLayer()
          maskLayer.frame = self.bounds
          maskLayer.path = maskLayerPath.cgPath
          layer.mask = maskLayer
      }
}
