//
//  RewardsLoginTableViewCell.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 12/12/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit

class RewardsLoginTableViewCell: UITableViewCell {
   @IBOutlet var button: DesignableButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        button.backgroundColor = UIColor.systemIndigo
        button.isEnabled = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // Reuser identifier
      class func reuseIdentifier() -> String {
      return "RewardsLoginTableViewCellID"
      }
             
      // Nib name
      class func nibName() -> String {
      return "RewardsLoginTableViewCell"
      }
    
    
    func setState(isActive : Bool){
        if isActive{
            button.backgroundColor = UIColor.systemIndigo
            button.isEnabled = true
        } else{
            button.backgroundColor = UIColor.lightGray
             button.isEnabled = false
        }
    }
}
