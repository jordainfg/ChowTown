//
//  showMenuButtonTableViewCell.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 08/01/2020.
//  Copyright © 2020 Jordain Gijsbertha. All rights reserved.
//

import UIKit

class showMenuButtonTableViewCell: UITableViewCell {

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
        return "showMenuButtonTableViewCellID"
    }
    
    // Nib name
    class func nibName() -> String {
        return "showMenuButtonTableViewCell"
    }
    
    
}
