//
//  LoginBodyTableViewCell.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 13/11/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit

protocol MyCustomCellDelegator {
    func callSegueFromCell(segueIdentifier : String, index : Int , selected : Any)
    
}

class LoginBodyTableViewCell: UITableViewCell{
    
    @IBOutlet weak var postCodeTextFIeld: UITextField!
    
    var delegate:MyCustomCellDelegator!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // Reuser identifier
    class func reuseIdentifier() -> String {
        return "LoginBodyTableViewCellID"
    }
    
    // Nib name
    class func nibName() -> String {
        return "LoginBodyTableViewCell"
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func scanButtonPressed(_ sender: Any) {
        
        
        if(self.delegate != nil){ //Just to be safe.
            self.delegate.callSegueFromCell(segueIdentifier: "toScanView", index: 0, selected: "")
        }
    }
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        
        
        if(self.delegate != nil){ //Just to be safe.
            self.delegate.callSegueFromCell(segueIdentifier: "toSearch", index: 0, selected: "")
        }
    }
    
    @IBAction func textFieldShouldReturn(_ sender: Any) {
        
    }
    
    
}
