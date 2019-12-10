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
        mealImageView.showLoadingIndicatorForImage()
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
    
    func configure(meal: Meal, httpReference : String){
        name.text = meal.name
        about.text = meal.detail
        
         setImage(httpReference: httpReference)
         
        
    }
    
    func setImage(httpReference : String)  {
    
       mealImageView.sd_setImage(with: URL(string: httpReference)) { (image, error, cache, urls) in
                   if (error != nil)  {
                       // Failed to load image
                       self.mealImageView.showLoadingIndicatorForImage()
                      // self.mealImageView.image = UIImage(named: "IMLunch")
                    
                   } else {
                       // Successful in loading image
                       self.mealImageView.hideLoadingIndicatorForImage()
                       self.mealImageView.image = image
                   }
               }
    }
    
}
