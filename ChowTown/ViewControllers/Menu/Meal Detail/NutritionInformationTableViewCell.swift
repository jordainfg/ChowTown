//
//  NutritionInformationTableViewCell.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 01/11/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit

class NutritionInformationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var calories: UILabel!
    @IBOutlet weak var carbs: UILabel!
    @IBOutlet weak var protein: UILabel!
    @IBOutlet weak var fat: UILabel!
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
        return "NutritionInformationTableViewCellID"
    }
    
    // Nib name
    class func nibName() -> String {
        return "NutritionInformationTableViewCell"
    }
    
    func configure(meal : Meal){
        
    }
}
