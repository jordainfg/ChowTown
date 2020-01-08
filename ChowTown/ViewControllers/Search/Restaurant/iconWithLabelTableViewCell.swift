//
//  iconWithLabelTableViewCell.swift
//  
//
//  Created by Jordain Gijsbertha on 25/11/2019.
//

import UIKit

class iconWithLabelTableViewCell: UITableViewCell {

    @IBOutlet var icon: UIImageView!
    @IBOutlet var label: UILabel!
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
    return "iconWithLabelTableViewCellID"
    }
           
    // Nib name
    class func nibName() -> String {
    return "iconWithLabelTableViewCell"
    }
    
}
