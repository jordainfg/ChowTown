//
//  SubMenuMeals&DrinksTableViewCell.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 20/11/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit

class SubMenuMealsAndDrinksTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    // Reuser identifier
           class func reuseIdentifier() -> String {
               return "SubMenuMealsAndDrinksTableViewCellID"
           }
           
           // Nib name
           class func nibName() -> String {
               return "SubMenuMealsAndDrinksTableViewCell"
           }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
