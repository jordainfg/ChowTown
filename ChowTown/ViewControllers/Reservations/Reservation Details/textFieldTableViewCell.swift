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
    case password
    case allergens
    case other
}

protocol textFieldCellDelegate: class {
    func didEditTextField(text: String, type : textFieldDataType)
  
}
//import SkyFloatingLabelTextField
import CocoaTextField
import UIKit

class textFieldTableViewCell: UITableViewCell {
    @IBOutlet var textField: CocoaTextField!
    weak var delegate: textFieldCellDelegate?
    var textFieldType : textFieldDataType?
    var textFieldFontSize : Int = 14
    var textFieldIsEmpty : Bool = true
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
        v.tintColor = UIColor(named: "BlackToOrange")
        v.textColor = UIColor.white
        v.inactiveHintColor = UIColor(red: 209/255, green: 211/255, blue: 212/255, alpha: 1)
        v.activeHintColor = UIColor(named: "BlackToOrange") ?? UIColor.black
        v.focusedBackgroundColor = UIColor.hexStringToUIColor(hex: "#212121")
        v.defaultBackgroundColor = UIColor.hexStringToUIColor(hex: "#424242")
        v.borderColor = UIColor.clear
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
            self.textFieldType = textFieldDataType.email
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
            
        case .password:
            setUpUI(text: "Password", placeHoldertext: placeHoldertext)
            self.textFieldType = textFieldType
            self.textField.isSecureTextEntry = true
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
        case .phone:
            checkIfEmpty()
         
        case .email:
            checkIfEmpty()
            
            delegate?.didEditTextField(text: sender.text!, type: .email)
            if let text = textField.text {
                if textField != nil {
                    if text.isEmpty {
                        // The error message will only disappear when we reset it to nil or empty string
                        
                    } else if text.isValidEmail() {
                        
                    } else if !text.isValidEmail() {
                        textField.setError(errorString: "Invalid email")
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
        case .password:
            checkIfEmpty()
        }
        
        
        // textField.borderColor = UIColor(red: 237.0 / 255.0, green: 237.0 / 255.0, blue: 242.0 / 255.0, alpha: 1.0)
        
    }
    
    @IBAction func textFieldDidBeginEditing(_ sender: CocoaTextField) {
        
    }
    
    @IBAction func textFieldEditingChanged(_ sender: CocoaTextField) {
                switch textFieldType! {
                case .name:
                    delegate?.didEditTextField(text: sender.text!, type: .name)
                case .email:
                    delegate?.didEditTextField(text: sender.text!, type: .email)
                case .phone:
                    delegate?.didEditTextField(text: sender.text!, type: .phone)
                case .password:
                    delegate?.didEditTextField(text: sender.text!, type: .password)
                case .allergens:
                    delegate?.didEditTextField(text: sender.text!, type: .allergens)
                case .other:
                    delegate?.didEditTextField(text: sender.text!, type: .other)
                
        }
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
