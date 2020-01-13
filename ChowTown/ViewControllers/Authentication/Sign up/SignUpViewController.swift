//
//  SignUpViewController.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 20/12/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit
import UIKit
import Firebase
enum signUpDataType {
    case header
    case email
    case password
    case createButon
    
}



class SignUpViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var delegate : AuthenticationDelegate?
    
    var email : String = ""
    var password : String = ""
    var buttonIsActive : Bool = false
    var tableViewcellTypes: [[signUpDataType]] {
        let types: [[signUpDataType]] = [[.header,.email,.password,.createButon]]
        
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
        tableView.register(UINib(nibName: ButtonTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: ButtonTableViewCell.reuseIdentifier())
        tableView.register(UINib(nibName: textFieldTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: textFieldTableViewCell.reuseIdentifier())
        tableView.register(UINib(nibName: HeaderForAuthenticationTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: HeaderForAuthenticationTableViewCell.reuseIdentifier())
        //        tableView.register(UINib(nibName: "HeaderForTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderCellIdentifier")
    }
    @IBAction func closeButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}


extension SignUpViewController : UITableViewDataSource , UITableViewDelegate, UITextFieldDelegate{
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
            cell.headerText.text = "Sign up and unlock Berry's full potential."
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
            
        case .createButon:
            let cell = tableView.dequeueReusableCell(withIdentifier: ButtonTableViewCell.reuseIdentifier()) as! ButtonTableViewCell
            cell.name.setTitle("Create", for: .normal)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type = tableViewcellTypes[indexPath.section][indexPath.row]
        switch type {
        case .header:
            return
            
        case .email:
            return
        case .password:
            return
        case .createButon:
            tableView.deselectRow(at: indexPath, animated: true)
            if email.count > 0 && password.count > 0 {
                FirebaseService.shared.createUser(withEmail: email, password: password) { (result : Result<User, CoreError>) in
                    switch result {
                    case .success(_):
                        let alert = UIAlertController(title: "Success", message: "You can now sign in.", preferredStyle: UIAlertController.Style.alert)
                        self.present(alert, animated: true)
                        alert.addAction(UIAlertAction(title: "Okay",
                                                      style: UIAlertAction.Style.default,
                                                      handler: {(alert: UIAlertAction!) in
                                                        self.dismiss(animated: true, completion: nil)
                        }))
                    case .failure(_):
                        let alert = UIAlertController(title: "Oops", message: "Looks like currently you can't sign up, please try again later", preferredStyle: UIAlertController.Style.alert)
                        self.present(alert, animated: true)
                        alert.addAction(UIAlertAction(title: "Okay",
                                                      style: UIAlertAction.Style.default,
                                                      handler: {(alert: UIAlertAction!) in
                                                        self.dismiss(animated: true, completion: nil)
                                                        
                        }))
                        
                    }
                }
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
        case .createButon:
            return 90
        default:
            return UITableView.automaticDimension
        }
    }
    
    
}

extension SignUpViewController : textFieldCellDelegate{
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
