// Reuser identifier
//  ChoiceMenuTableViewCell.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 11/11/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit

class ChoiceMenuTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    class func reuseIdentifier() -> String {
           return "ChoiceMenuTableViewCellID"
    }
       
       // Nib name
       class func nibName() -> String {
           return "ChoiceMenuTableViewCell"
       }//

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
