//
//  ChoiceMenuHeaderTableViewCell.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 11/11/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit

class SubMenuMealsAndDrinksHeaderTableViewCell: UITableViewCell {

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
               return "SubMenuMealsAndDrinksHeaderTableViewCellID"
           }
           
           // Nib name
           class func nibName() -> String {
               return "SubMenuMealsAndDrinksHeaderTableViewCell"
           }
    
}
