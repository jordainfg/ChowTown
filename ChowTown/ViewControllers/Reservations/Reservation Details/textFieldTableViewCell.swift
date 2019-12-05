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

//import SkyFloatingLabelTextField
import CocoaTextField
import UIKit

class textFieldTableViewCell: UITableViewCell {
    @IBOutlet var textField: CocoaTextField!
    //weak var delegate: textFieldCellDelegate?
    var textFieldType : textFieldDataType?
    var textFieldFontSize : Int = 14
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        applyStyle(to: textField)
        textFieldType = .name
        if traitCollection.userInterfaceStyle == .light {
            applyStyle(to: textField)
        } else {
            applyDarkStyle(to: textField)
        }
        //   textField.titleFont = UIFont(name: "Overpass-SemiBold", size: 13)!
        
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
           // Trait collection has already changed
        if traitCollection.userInterfaceStyle == .light {
                   applyStyle(to: textField)
               } else {
                   applyDarkStyle(to: textField)
               }
       }

       
    
    private func applyStyle(to v: CocoaTextField) {
        v.keyboardType = .default
        v.autocapitalizationType = .none
        v.tintColor = UIColor(red: 94/255, green: 186/255, blue: 187/255, alpha: 1)
        v.textColor = UIColor(red: 74/255, green: 74/255, blue: 74/255, alpha: 1)
        v.inactiveHintColor = UIColor(red: 209/255, green: 211/255, blue: 212/255, alpha: 1)
        v.activeHintColor = UIColor(red: 94/255, green: 186/255, blue: 187/255, alpha: 1)
        v.focusedBackgroundColor = UIColor(red: 236/255, green: 239/255, blue: 239/255, alpha: 1)
        v.defaultBackgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        v.borderColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1)
        v.errorColor = UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 0.7)
        
        //
    }
    
    
    private func applyDarkStyle(to v: CocoaTextField) {
        v.keyboardType = .default
        v.autocapitalizationType = .none
        v.tintColor = UIColor(named: "DarkModeOrange")
        v.textColor = UIColor.white
        v.inactiveHintColor = UIColor(red: 209/255, green: 211/255, blue: 212/255, alpha: 1)
        v.activeHintColor = UIColor(named: "DarkModeOrange")!
        v.focusedBackgroundColor = UIColor.hexStringToUIColor(hex: "#212121")
        v.defaultBackgroundColor = UIColor.black
        v.borderColor = UIColor.white
        v.errorColor = UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 0.7)
        
        //
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
            self.textFieldType = textFieldDataType.name
        case .email:
            setUpUI(text: "Email", placeHoldertext: placeHoldertext)
            self.textFieldType = textFieldDataType.name
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
            
        }
    }
    
    func setUpUI(text: String, placeHoldertext : String){
        //textField.text = text ?? nil
        textField.placeholder = placeHoldertext
        textField.font = UIFont(name: "Overpass-Bold", size: CGFloat(textFieldFontSize))
        self.textField.isUserInteractionEnabled = true
    }
    
    class func cellHeight() -> CGFloat {
        return 85
    }
    
    
    @IBAction func textFielDidEndEditing(_ sender: CocoaTextField) {
        
        switch textFieldType! {
        case .name:
            checkIfEmpty()
            guard textField.text?.isEmpty == false else {
                
                return
            }
        case .phone:
            checkIfEmpty()
            guard textField.text?.isEmpty == false else {
                
                return
            }
        case .email:
            checkIfEmpty()
            guard textField.text?.isEmpty == false else {
                
                return
            }
            if let text = textField.text {
                if textField != nil {
                    if text.isEmpty {
                        // The error message will only disappear when we reset it to nil or empty string
                        
                    } else if text.isValidEmail() {
                        
                    } else if !text.isValidEmail() {
                        
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
        
        
        // textField.borderColor = UIColor(red: 237.0 / 255.0, green: 237.0 / 255.0, blue: 242.0 / 255.0, alpha: 1.0)
        
    }
    
    @IBAction func textFieldDidBeginEditing(_ sender: CocoaTextField) {
        
    }
    
    @IBAction func textFieldEditingChanged(_ sender: CocoaTextField) {
        
        //        switch textFieldType! {
        //        case .name:
        //
        //            //checkIfEmpty()
        //            //    .delegate?.didEditTextField(text: sender.text!, type: .nameField(nil))
        //        case .email:
        //                checkIfEmpty()
        //             // delegate?.didEditTextField(text: sender.text!, type: .emptyField(nil))
        //        case .phone:
        //            //checkIfEmpty()
        //            //delegate?.didEditTextField(text: sender.text!, type: .numberField(nil))
        //        case .allergens:
        //            //checkIfEmpty()
        //          //  delegate?.didEditTextField(text: sender.text!, type: .discriptionField(nil))
        //        case .other:
        //            return
        //
        //
        //        }
    }
    
    func checkIfEmpty(){
        if let text = textField.text {
            if textField != nil {
                if text.isEmpty {
                    textField.setError(errorString: "Please fill")
                } else{
                    
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
