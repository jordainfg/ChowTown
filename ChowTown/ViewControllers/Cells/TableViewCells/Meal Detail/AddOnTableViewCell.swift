//
//  AddOnTableViewCell.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 12/11/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit

class AddOnTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    // Reuser identifier
           class func reuseIdentifier() -> String {
               return "AddOnTableViewCellID"
           }
           
           // Nib name
           class func nibName() -> String {
               return "AddOnTableViewCell"
           }
    
}
