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
    var AutoModeIsOn : Bool = UserDefaults.standard.bool(forKey: "AutoModeIsOn") //false
    
    @IBOutlet weak var toggle: UISwitch!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        toggle.setOn(!AutoModeIsOn, animated: true)
        
        
        
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
       
        AutoModeIsOn = !AutoModeIsOn
        UserDefaults.standard.set(AutoModeIsOn, forKey: "AutoModeIsOn")
        
        if !AutoModeIsOn{
            UIApplication.shared.windows.forEach { window in
                       window.overrideUserInterfaceStyle = .unspecified
                   }
                   delegate?.AppearanceOptions(isDisplayed: false)
            
        } else if AutoModeIsOn {
                 delegate?.AppearanceOptions(isDisplayed: true)
                 UIApplication.shared.windows.forEach { window in
                    window.overrideUserInterfaceStyle = .light
        }
        }
        
        
        
    }
}
