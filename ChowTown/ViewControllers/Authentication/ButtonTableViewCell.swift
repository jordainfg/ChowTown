//
//  ButtonTableViewCell.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 20/12/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit

class ButtonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var name: DesignableButton!
    
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
        return "ButtonTableViewCellID"
    }
    
    // Nib name
    class func nibName() -> String {
        return "ButtonTableViewCell"
    }
    
}
