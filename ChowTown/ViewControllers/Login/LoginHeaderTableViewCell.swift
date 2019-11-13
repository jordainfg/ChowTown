//
//  LoginHeaderTableViewCell.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 13/11/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit

class LoginHeaderTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // Reuser identifier
           class func reuseIdentifier() -> String {
               return "LoginHeaderTableViewCellID"
           }
           
           // Nib name
           class func nibName() -> String {
               return "LoginHeaderTableViewCell"
           }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
