//
//  SpecialsHeaderTableViewCell.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 31/10/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit

class SpecialsHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var specialName: UILabel!
    @IBOutlet weak var specialSubTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var some: UIImageView!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    // Reuser identifier
         class func reuseIdentifier() -> String {
             return "SpecialsHeaderTableViewCellID"
         }
         
         // Nib name
         class func nibName() -> String {
             return "SpecialsHeaderTableViewCell"
         }
}
