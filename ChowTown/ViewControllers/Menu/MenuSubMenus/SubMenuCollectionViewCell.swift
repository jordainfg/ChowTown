//
//  SubMenuCollectionViewCell.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 18/11/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit

class SubMenuCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var subMenuName: UILabel!
    @IBOutlet var subMenuSubTitle: UILabel!
    @IBOutlet weak var cardView: DesignableView!
    @IBOutlet weak var cardImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    // Reuser identifier
           class func reuseIdentifier() -> String {
               return "SubMenuCollectionViewCellID"
           }
           
           // Nib name
           class func nibName() -> String {
               return "SubMenuCollectionViewCell"
           }

}
