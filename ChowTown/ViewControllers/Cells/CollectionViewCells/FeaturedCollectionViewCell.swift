//
//  FeaturedCollectionViewCell.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 11/11/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit

class FeaturedCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    // Reuser identifier
           class func reuseIdentifier() -> String {
               return "FeaturedCollectionViewCellID"
           }
           
           // Nib name
           class func nibName() -> String {
               return "FeaturedCollectionViewCell"
           }
}
