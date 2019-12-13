//
//  SettingsTextBoxTableViewCell.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 13/12/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit

class SettingsTextBoxTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
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
      return "SettingsTextBoxTableViewCellID"
      }
             
      // Nib name
      class func nibName() -> String {
      return "SettingsTextBoxTableViewCell"
      }
    
    func configure(text: String){
        label.text = text
    }
    
}
