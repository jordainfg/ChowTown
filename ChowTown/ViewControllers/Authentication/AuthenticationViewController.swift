//
//  AuthenticationViewController.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 12/12/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit
import SPStorkController
import Firebase
enum authenticationDataType {
    case header
    case loginOptions
    case email
    case password
    case loginButon
    case footer
    
}

protocol AuthenticationDelegate {
    func didAuthenticateSuccessfully(isTrue : Bool)
    func didCreateSuccessfully(isTrue : Bool)
    func didLogout()
    
}


class AuthenticationViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var delegate : AuthenticationDelegate?
    
    var email : String = ""
    var password : String = ""
    var buttonIsActive : Bool = false
    var tableViewcellTypes: [[authenticationDataType]] {
        let types: [[authenticationDataType]] = [[.header,.loginOptions,.email,.password,.loginButon],[.footer]]
        
        return types
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
//        let controller = UIViewController()
//        self.presentAsStork(controller)
        // Do any additional setup after loading the view.
    }
    
    func setupTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: LoginOptionsTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: LoginOptionsTableViewCell.reuseIdentifier())
        tableView.register(UINib(nibName: ButtonTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: ButtonTableViewCell.reuseIdentifier())
        tableView.register(UINib(nibName: textFieldTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: textFieldTableViewCell.reuseIdentifier())
        tableView.register(UINib(nibName: HeaderForAuthenticationTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: HeaderForAuthenticationTableViewCell.reuseIdentifier())
         tableView.register(UINib(nibName: AuthenticationFooterTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: AuthenticationFooterTableViewCell.reuseIdentifier())
        //        tableView.register(UINib(nibName: "HeaderForTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderCellIdentifier")
    }
    @IBAction func closeButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
            let cell = tableView.dequeueReusableCell(withIdentifier: ButtonTableViewCell.reuseIdentifier()) as! ButtonTableViewCell
            cell.selectionStyle = .none
            return cell
        case .footer:
             let cell = tableView.dequeueReusableCell(withIdentifier: AuthenticationFooterTableViewCell.reuseIdentifier()) as! AuthenticationFooterTableViewCell
             cell.selectionStyle = .none
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
                FirebaseService.shared.loginUser(Email: "jordainf@gmail.com", password: "boombam1234") { (result : Result<User, CoreError>) in
                    switch result {
                    case .success(_):
                        self.dismiss(animated: true) {
                            self.delegate?.didAuthenticateSuccessfully(isTrue: true)
                        }
                    case .failure(_):
                        let alert = UIAlertController(title: "Invalid credentials", message: "", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
                        self.present(alert, animated: true)
                        alert.addAction(UIAlertAction(title: "Okay",
                                                      style: UIAlertAction.Style.default,
                        handler: {(alert: UIAlertAction!) in
                              self.navigationController?.popViewController(animated: true)
                            self.delegate?.didAuthenticateSuccessfully(isTrue: false)
                            
                        }))
                        
                    }
                }
               }
                   
               case .footer:
                performSegue(withIdentifier: "showSignUp", sender: nil)
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
