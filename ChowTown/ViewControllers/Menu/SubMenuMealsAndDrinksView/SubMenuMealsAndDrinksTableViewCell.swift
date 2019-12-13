//
//  SubMenuMeals&DrinksTableViewCell.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 20/11/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit
import FirebaseUI

class SubMenuMealsAndDrinksTableViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var about: UILabel!
    @IBOutlet weak var mealImageView: UIImageView!
    
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
    
    func configure(meal: Meal, StorageRef : StorageReference){
        name.text = meal.name
        about.text = meal.detail
        imageView?.sd_setImage(with: StorageRef, placeholderImage: UIImage(named: "icPeanut"))
      
         
        
    }
    
  
}
