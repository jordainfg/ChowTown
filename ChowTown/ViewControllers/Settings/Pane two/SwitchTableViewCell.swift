//
//  SwitchTableViewCell.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 12/12/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit
protocol appearanceSwitchDelegator {
    func AppearanceOptions(isDisplayed : Bool)
}
class SwitchTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    
    var delegate : appearanceSwitchDelegator?
    var switchIsActive : Bool = true
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
      return "SwitchTableViewCellID"
      }
             
      // Nib name
      class func nibName() -> String {
      return "SwitchTableViewCell"
      }
    
    @IBAction func switchAction(_ sender: Any) {
        switchIsActive = !switchIsActive
        
        if switchIsActive{
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .unspecified
            }
            delegate?.AppearanceOptions(isDisplayed: false)
        } else {
            delegate?.AppearanceOptions(isDisplayed: true)
            UIApplication.shared.windows.forEach { window in
                          window.overrideUserInterfaceStyle = .light
                      }
        }
        
    }
}
