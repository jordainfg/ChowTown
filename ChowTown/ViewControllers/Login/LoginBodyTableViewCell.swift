//
//  LoginBodyTableViewCell.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 13/11/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit

protocol MyCustomCellDelegator {
    func callSegueFromCell(myData : String)
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
        
        var mydata = "Anydata you want to send to the next controller"
                  if(self.delegate != nil){ //Just to be safe.
                    self.delegate.callSegueFromCell(myData: "")
                  }
    }
    
   @IBAction func textFieldShouldReturn(_ sender: Any) {
    
    }
    
    
}
