//
//  PointsCollectionViewCell.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 10/12/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit

class PointsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
               let screenWidth = UIScreen.main.bounds.size.width
               widthConstraint.constant = screenWidth - (2 * 20)
    }
    
    // Reuser identifier
    class func reuseIdentifier() -> String {
        return "PointsCollectionViewCellID"
    }
    
    // Nib name
    class func nibName() -> String {
        return "PointsCollectionViewCell"
    }
    
   
    
}
