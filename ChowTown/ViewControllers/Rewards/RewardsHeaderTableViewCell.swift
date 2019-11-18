//
//  RewardsHeaderTableViewCell.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 18/11/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit

class RewardsHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var pointsView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        pointsView.layer.cornerRadius = pointsView.frame.size.width/2
        pointsView.clipsToBounds = true

        pointsView.layer.borderColor = UIColor.white.cgColor
        pointsView.layer.borderWidth = 1.0
        // Configure the view for the selected state
    }
    
    // Reuser identifier
           class func reuseIdentifier() -> String {
               return "RewardsHeaderTableViewCellID"
           }
           
           // Nib name
           class func nibName() -> String {
               return "RewardsHeaderTableViewCell"
           }
    
}
