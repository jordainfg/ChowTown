//
//  SettingsButtonTableViewCell.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 12/12/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit

class SettingsButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    var buttonType : buttonType?
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
      return "SettingsButtonTableViewCellID"
      }
             
      // Nib name
      class func nibName() -> String {
      return "SettingsButtonTableViewCell"
      }
    
    func configure(name: String, type : buttonType){
        if type == .deadly{
            self.name.text = name
            self.name.font = UIFont(name:"Nunito-ExtraBold",size:15)
            self.name.textColor = UIColor.systemPink
            buttonType = type
        } else{
            self.name.text = name
            self.name.textColor = UIColor.systemIndigo
            self.name.font = UIFont(name:"Nunito-SemiBold",size:14)
            buttonType = type
        }
       
    }
    
}
