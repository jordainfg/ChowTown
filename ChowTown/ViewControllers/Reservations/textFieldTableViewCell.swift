//
//  MeetingNameTableViewCell.swift
//  AdminVisitorsRegistration
//
//  Created by Jordain Gijsbertha on 6/12/19.
//  Copyright © 2019 Jordain  Gijsbertha. All rights reserved.
//

enum textFieldDataType{
    case name
    case email
    case phone
    case allergens
    case other
}

import SkyFloatingLabelTextField
import UIKit

class textFieldTableViewCell: UITableViewCell {
    @IBOutlet var textField: SkyFloatingLabelTextField!
    //weak var delegate: textFieldCellDelegate?
    var textFieldType : textFieldDataType?
    var textFieldFontSize : Int = 14
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        textField.setLeftPaddingPoints(13)
        textField.setRightPaddingPoints(13)
        textFieldType = .name
        textField.errorColor = UIColor.red
        textField.titleFont = UIFont(name: "Overpass-SemiBold", size: 13)!

    }
    
    // Reuser identifier
    class func reuseIdentifier() -> String {
        return "textFieldTableViewCellIdentifier"
    }
    
    // Nib name
    class func nibName() -> String {
        return "textFieldTableViewCell"
    }
    
    func configure(placeHoldertext : String, textFieldType: textFieldDataType){
        switch (textFieldType) {
        case .name:
            setUpUI(text: "Name", placeHoldertext: placeHoldertext)
            self.textFieldType = textFieldType
        case .email:
            setUpUI(text: "Email", placeHoldertext: placeHoldertext)
            self.textFieldType = textFieldType
            self.textField.tag = 1
        case .phone:
            setUpUI(text: "Phone", placeHoldertext: placeHoldertext)
            self.textFieldType = textFieldType
        case .allergens:
            setUpUI(text: "Alergens", placeHoldertext: placeHoldertext)
            self.textFieldType = textFieldType
            self.textField.tag = 1
        case .other:
            setUpUI(text: "other", placeHoldertext: placeHoldertext)
            self.textFieldType = textFieldType
              self.textField.tag = 2
        default:
            return
        }
    }
    
    func setUpUI(text: String, placeHoldertext : String){
        textField.selectedLineHeight = 13
        textField.placeholder = placeHoldertext
        textField.font = UIFont(name: "Overpass-Bold", size: CGFloat(textFieldFontSize))
        self.textField.isUserInteractionEnabled = true
        checkIfEmpty()
    }
    
    class func cellHeight() -> CGFloat {
        return 85
    }
    
    
    @IBAction func textFielDidEndEditing(_ sender: SkyFloatingLabelTextField) {
        
        switch textFieldType! {
        case .name:
            checkIfEmpty()
            guard textField.text?.isEmpty == false else {
                textField.errorMessage = "Please fill in"
                textField.selectedLineHeight = 0
                return
            }
        case .phone:
            checkIfEmpty()
            guard textField.text?.isEmpty == false else {
                textField.errorMessage = "Please fill in"
                textField.selectedLineHeight = 0
                return
            }
        case .email:
            checkIfEmpty()
            guard textField.text?.isEmpty == false else {
                textField.errorMessage = "Please fill in"
                textField.selectedLineHeight = 0
                return
            }
            if let text = textField.text {
                if textField != nil {
                    if text.isEmpty {
                        // The error message will only disappear when we reset it to nil or empty string
                        textField.selectedLineHeight = 13
                        textField.errorMessage = ""
                    } else if text.isValidEmail() {
                        textField.errorMessage = ""
                        textField.borderColor = UIColor.battleshipGrey
                    } else if !text.isValidEmail() {
                        textField.errorMessage = "Invalid email"
                        textField.borderColor = UIColor(red: 194.0 / 255.0, green: 71.0 / 255.0, blue: 71.0 / 255.0, alpha: 1.0) // reddish
                    }
                }
            }
           // delegate?.didEditTextField(text: sender.text!, type: .emailField(nil))
        case .allergens:
            checkIfEmpty()
//            guard textField.text?.isEmpty == false else {
//                textField.errorMessage = "Please fill in"
//                textField.selectedLineHeight = 0
//                return
//            }
        case .other:
            checkIfEmpty()
        }
        
        
        textField.borderColor = UIColor(red: 237.0 / 255.0, green: 237.0 / 255.0, blue: 242.0 / 255.0, alpha: 1.0)
        
    }
    
    @IBAction func textFieldDidBeginEditing(_ sender: SkyFloatingLabelTextField) {
        checkIfEmpty()
        self.textField.errorMessage = ""
        UIView.animate(withDuration: 0.9) {
            self.textField.alpha = 0.4
            self.textField.borderColor = UIColor.black
            self.textField.alpha = 1
        }
        
       
        
        
    }
    
    @IBAction func textFieldEditingChanged(_ sender: SkyFloatingLabelTextField) {
        self.textField.selectedLineHeight = 0
        switch textFieldType! {
        case .name:
            checkIfEmpty()
            //    .delegate?.didEditTextField(text: sender.text!, type: .nameField(nil))
        case .email:
                checkIfEmpty()
             // delegate?.didEditTextField(text: sender.text!, type: .emptyField(nil))
        case .phone:
            checkIfEmpty()
            //delegate?.didEditTextField(text: sender.text!, type: .numberField(nil))
        case .allergens:
            checkIfEmpty()
          //  delegate?.didEditTextField(text: sender.text!, type: .discriptionField(nil))
        case .other:
            return
       

        }
    }
   
    func checkIfEmpty(){
        if let text = textField.text {
            if textField != nil {
                if text.isEmpty {
                
                    textField.selectedLineHeight = 13
                } else{
                    textField.selectedLineHeight = 0
                }
            }
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

public extension UITextField {
    func setLeftPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: frame.size.height))
        leftView = paddingView
        leftViewMode = .always
    }

    func setRightPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: frame.size.height))
        rightView = paddingView
        rightViewMode = .always
    }
}
