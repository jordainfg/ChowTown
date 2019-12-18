//
//  AllergensCollectionViewCell.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 12/11/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit

class iconCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var iCon: UIImageView!
    @IBOutlet weak var allergenName: UILabel!
    @IBOutlet weak var view: UIView!
    var iConNumber = 1
    var setNumber = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        updateIcons()
        // Initialization code
        
    }
    
    func updateIcons(){
        
        switch iConNumber {
            
        // Allergens
        case 1:
            iCon.image = #imageLiteral(resourceName: "icFish")
            allergenName.text = "Fish"
        case 2:
            iCon.image = #imageLiteral(resourceName: "iCSelfish")
            allergenName.text = "Shellfish"
        case 3:
            iCon.image = #imageLiteral(resourceName: "icEggs")
            allergenName.text = "Eggs"
        case 4:
            iCon.image = #imageLiteral(resourceName: "icMilk")
            allergenName.text = "Milk"
        case 5:
            iCon.image = #imageLiteral(resourceName: "icPeanut")
            allergenName.text = "Peanuts"
        case 6:
            iCon.image = #imageLiteral(resourceName: "icWheat")
            allergenName.text = "Gluten"
        case 7:
            iCon.image = #imageLiteral(resourceName: "icNut")
            allergenName.text = "Nuts"
        case 8:
            iCon.image = #imageLiteral(resourceName: "icSoy")
            allergenName.text = "Soy"
        case 9:
            iCon.image = #imageLiteral(resourceName: "icSesame")
            allergenName.text = "Sesame"
          
            
        // About Meal
        case 20:
            iCon.image = #imageLiteral(resourceName: "icHalal")
            allergenName.text = "Halal"
        case 21:
            iCon.image = #imageLiteral(resourceName: "icVegetarian")
            allergenName.text = "Vega"
        case 22:
            iCon.image = #imageLiteral(resourceName: "icVegan")
            allergenName.text = "Vegan"
        case 23:
            iCon.image = #imageLiteral(resourceName: "icCrueltyFree")
            allergenName.text = "Cruelty Free"
        case 24:
            iCon.image = #imageLiteral(resourceName: "icGMO")
            allergenName.text = "GMO Free"
        case 25:
            iCon.image = #imageLiteral(resourceName: "icNoGluten")
            allergenName.text = "Gluten Free"
            case 26:
            iCon.image = #imageLiteral(resourceName: "icOrganic")
            allergenName.text = "Organic"
            
        default:
            iCon.image = #imageLiteral(resourceName: "icMilk")
            allergenName.text = "Milk"
        }
    }
    
    
    
    
    
    
    // Reuser identifier
    class func reuseIdentifier() -> String {
        return "iconCollectionViewCellID"
    }
    
    // Nib name
    class func nibName() -> String {
        return "iconCollectionViewCell"
    }
}
