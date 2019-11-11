//
//  MenuHeaderTableViewCell.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 11/11/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit

class MenuHeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var view: DesignableView!
    @IBOutlet weak var iCon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // Reuser identifier
    class func reuseIdentifier() -> String {
        return "MenuHeaderTableViewCellID"
    }
    
    // Nib name
    class func nibName() -> String {
        return "MenuHeaderTableViewCell"
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
