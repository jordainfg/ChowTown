//
//  SubMenuHeaderTableViewCell.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 19/11/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit

class SubMenuHeaderTableViewCell: UITableViewCell {

     @IBOutlet var headerimageView: UIImageView!
       @IBOutlet weak var address: UILabel!
       @IBOutlet weak var name: UILabel!
   @IBOutlet var notificationButton: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
            headerimageView.makeRounded()
    }

    // Reuser identifier
           class func reuseIdentifier() -> String {
               return "SubMenuHeaderTableViewCellID"
           }
           
           // Nib name
           class func nibName() -> String {
               return "SubMenuHeaderTableViewCell"
           }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
