//
//  AuthenticationViewController.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 12/12/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit
enum authenticationDataType {
    case header
    case loginOptions
    case email
    case password
    case loginButon
    
}
class AuthenticationViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var email : String = ""
    var password : String = ""
    var buttonIsActive : Bool = false
    var tableViewcellTypes: [[authenticationDataType]] {
        let types: [[authenticationDataType]] = [[.header,.loginOptions,.email,.password,.loginButon]]
        
        return types
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        // Do any additional setup after loading the view.
    }
    
    func setupTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: LoginOptionsTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: LoginOptionsTableViewCell.reuseIdentifier())
        tableView.register(UINib(nibName: RewardsLoginTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: RewardsLoginTableViewCell.reuseIdentifier())
        tableView.register(UINib(nibName: textFieldTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: textFieldTableViewCell.reuseIdentifier())
        tableView.register(UINib(nibName: HeaderForAuthenticationTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: HeaderForAuthenticationTableViewCell.reuseIdentifier())
        //        tableView.register(UINib(nibName: "HeaderForTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderCellIdentifier")
    }
}


extension AuthenticationViewController : UITableViewDataSource , UITableViewDelegate, UITextFieldDelegate{
    func textFieldShouldReturn(_: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    func numberOfSections(in _: UITableView) -> Int {
        return tableViewcellTypes.count
    }
    
    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewcellTypes[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = tableViewcellTypes[indexPath.section][indexPath.row]
        
        switch type {
            
        case .header:
            let cell = tableView.dequeueReusableCell(withIdentifier: HeaderForAuthenticationTableViewCell.reuseIdentifier()) as! HeaderForAuthenticationTableViewCell
            
            return cell
        case .loginOptions:
            let cell = tableView.dequeueReusableCell(withIdentifier: LoginOptionsTableViewCell.reuseIdentifier()) as! LoginOptionsTableViewCell
            
            return cell
            
        case .email:
            let cell = tableView.dequeueReusableCell(withIdentifier: textFieldTableViewCell.reuseIdentifier()) as! textFieldTableViewCell
            cell.configure(placeHoldertext: "Email", textFieldType: textFieldDataType.email)
            cell.textField.delegate = self
            cell.delegate = self
            return cell
        case .password:
            let cell = tableView.dequeueReusableCell(withIdentifier: textFieldTableViewCell.reuseIdentifier()) as! textFieldTableViewCell
            cell.configure(placeHoldertext: "Password", textFieldType: textFieldDataType.password)
            cell.textField.delegate = self
            cell.delegate = self
            return cell
            
        case .loginButon:
            let cell = tableView.dequeueReusableCell(withIdentifier: RewardsLoginTableViewCell.reuseIdentifier()) as! RewardsLoginTableViewCell
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type = tableViewcellTypes[indexPath.section][indexPath.row]
               switch type {
               case .header:
                   return
               case .loginOptions:
                   return
               case .email:
                   return
               case .password:
                   return
               case .loginButon:
                tableView.deselectRow(at: indexPath, animated: true)
               if email.count > 0 && password.count > 0 {
                 print("trying to login")
               }
                   
               }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let type = tableViewcellTypes[indexPath.section][indexPath.row]
        switch type {
            
            
        case .email:
            return 60
        case .password:
            return 60
        case .loginButon:
            return 90
        default:
            return UITableView.automaticDimension
        }
    }
    
    
}

extension AuthenticationViewController : textFieldCellDelegate{
    
    
    func didEditTextField(text: String, type: textFieldDataType) {
        
        switch type {
        case .email:
            email = text
            
        case .password:
            password = text
        default:
            return
        }
        
    }
    
    
    
}
