//
//  AddOnTableViewCell.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 12/11/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit

class AddOnTableViewCell: UITableViewCell {

    @IBOutlet weak var addName: UILabel!
    @IBOutlet weak var addPrice: UILabel!
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
               return "AddOnTableViewCellID"
           }
           
           // Nib name
           class func nibName() -> String {
               return "AddOnTableViewCell"
           }
    
    func configure(text : String){
        let fullName    = text
        let fullNameArr = fullName.components(separatedBy: ",")

        addName.text = "+ \(fullNameArr[0])"
        addPrice.text = "\(fullNameArr[1])"
        
    }
}
