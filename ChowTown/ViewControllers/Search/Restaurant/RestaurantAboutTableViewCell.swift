//
//  RestaurantAboutTableViewCell.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 25/11/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit

class RestaurantAboutTableViewCell: UITableViewCell {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var about: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       // stackView.frame.height
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    // Reuser identifier
           class func reuseIdentifier() -> String {
               return "RestaurantAboutTableViewCellID"
           }
           
           // Nib name
           class func nibName() -> String {
               return "RestaurantAboutTableViewCell"
           }
    
}
