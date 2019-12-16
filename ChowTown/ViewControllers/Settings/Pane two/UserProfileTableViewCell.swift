//
//  UserProfileTableViewCell.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 12/12/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit

class UserProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var email: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if FirebaseService.shared.authState == .isLoggedIn{
            userName.text = FirebaseService.shared.authenticationState?.name
             email.text = FirebaseService.shared.authenticationState?.email
        } else{
           userName.text = "Error"
            email.text = "Please log out"
        }
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
