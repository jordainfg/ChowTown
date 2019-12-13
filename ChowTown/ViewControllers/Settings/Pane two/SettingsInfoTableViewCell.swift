//
//  SettingsInfoTableViewCell.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 13/12/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit

class SettingsInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var leadingLabel: UILabel!
    @IBOutlet weak var trailingLabel: UILabel!
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
      return "SettingsInfoTableViewCellID"
      }
             
      // Nib name
      class func nibName() -> String {
      return "SettingsInfoTableViewCell"
      }
    
    func configure(leadingText : String, trailingText : String){
        leadingLabel.text = leadingText
        trailingLabel.text = trailingText
    }
    
}
