//
//  UserProfileTableViewCell.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 12/12/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit

class UserProfileTableViewCell: UITableViewCell {

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
      return "UserProfileTableViewCellID"
      }
             
      // Nib name
      class func nibName() -> String {
      return "UserProfileTableViewCell"
      }
}
