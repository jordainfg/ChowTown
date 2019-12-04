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
    @IBOutlet weak var alergenName: UILabel!
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
        case 1:
            iCon.image = #imageLiteral(resourceName: "icFish")
            alergenName.text = "Fish"
        case 2:
            iCon.image = #imageLiteral(resourceName: "iCSelfish")
            alergenName.text = "Selfish"
        case 3:
            iCon.image = #imageLiteral(resourceName: "icEggs")
            alergenName.text = "Eggs"
        case 4:
            iCon.image = #imageLiteral(resourceName: "icMilk")
            alergenName.text = "Milk"
        case 5:
            iCon.image = #imageLiteral(resourceName: "icPeanut")
            alergenName.text = "Peanut"
        case 6:
            iCon.image = #imageLiteral(resourceName: "icWheat")
            alergenName.text = "Gluten"
        case 7:
            iCon.image = #imageLiteral(resourceName: "icNut")
            alergenName.text = "Nuts"
        case 8:
            iCon.image = #imageLiteral(resourceName: "icSoy")
            alergenName.text = "Soy"
        case 9:
            iCon.image = #imageLiteral(resourceName: "icSesame")
            alergenName.text = "Sesame"
            
        case 20:
            iCon.image = #imageLiteral(resourceName: "icHalal")
            alergenName.text = "Halal"
            
        case 21:
            iCon.image = #imageLiteral(resourceName: "icVegeteriaan")
            alergenName.text = "Vega"
        case 22:
            iCon.image = #imageLiteral(resourceName: "icVegan")
            alergenName.text = "Vegan"
         case 23:
            iCon.image = #imageLiteral(resourceName: "icCalories")
            alergenName.text = "200"
            
        default:
            iCon.image = #imageLiteral(resourceName: "icMilk")
            alergenName.text = "Milk"
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
