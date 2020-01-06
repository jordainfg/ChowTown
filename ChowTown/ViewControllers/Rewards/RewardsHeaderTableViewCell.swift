//
//  RewardsHeaderTableViewCell.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 11/12/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit

class RewardsHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var points: UILabel!
    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if let userName = FirebaseService.shared.authenticationState?.name{
            name.text = "HI, \(userName.uppercased())!"
        }
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

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
