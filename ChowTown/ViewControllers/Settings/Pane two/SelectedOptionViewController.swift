//
//  SelectedOptionViewController.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 12/12/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit

enum buttonType{
    case deadly
    case normal
}
enum SettingDataType {
    case profile
    case Switch
    case button(String,buttonType)
    case LoginButton(String,buttonType)
}
class SelectedOptionViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var selectedSettings : SettingOptionDataType?
    
    var tableViewcellTypes: [[SettingDataType]] = [[.profile],[.button("Edit", .normal),.button("Log out", .deadly)]]
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSettingsForView(selectedSettings: selectedSettings!)
        setupTableView()
       
    }
   
    func configureSettingsForView(selectedSettings : SettingOptionDataType){
        switch selectedSettings{
        case let .profile(name):
            self.title = name
            if FirebaseService.shared.authState == .isLoggedIn{
                let types: [[SettingDataType]] = [[.profile],[.button("Edit", .normal),.button("Log out", .deadly)]]
                tableViewcellTypes = types
            } else {
                tableViewcellTypes = [[.LoginButton("Log in", .deadly)]]
            }
           
        case let .appearance(name):
            let types: [[SettingDataType]] = [[.Switch]]
            tableViewcellTypes = types
            self.title = name
     
        }
    }
    
    
    func setupTableView() {
        tableView.register(UINib(nibName: UserProfileTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: UserProfileTableViewCell.reuseIdentifier())
        tableView.register(UINib(nibName: SettingOptionTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: SettingOptionTableViewCell.reuseIdentifier())
        tableView.register(UINib(nibName: SettingHeaderTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: SettingHeaderTableViewCell.reuseIdentifier())
        tableView.register(UINib(nibName: SwitchTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: SwitchTableViewCell.reuseIdentifier())
        tableView.register(UINib(nibName: SettingsButtonTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: SettingsButtonTableViewCell.reuseIdentifier())
        //        tableView.register(UINib(nibName: "HeaderForTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderCellIdentifier")
    }
    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
                switch segue.identifier {
                case "presentAuthentication":
                    let secondVC = segue.destination as! AuthenticationViewController
                    secondVC.delegate = self
                default:
                    return
                }
            }
}













extension SelectedOptionViewController : UITableViewDataSource , UITableViewDelegate , UITextFieldDelegate{
    
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
            
        case .profile:
            let cell = tableView.dequeueReusableCell(withIdentifier: UserProfileTableViewCell.reuseIdentifier()) as! UserProfileTableViewCell
//            cell.name.text = "Profile"
//            cell.iCon.image = UIImage(systemName: "person.crop.circle.fill")
//            cell.iCon.backgroundColor = UIColor.systemRed
            return cell
        case .Switch:
            let cell = tableView.dequeueReusableCell(withIdentifier: SwitchTableViewCell.reuseIdentifier()) as! SwitchTableViewCell
            return cell
        case let .button(name, type):
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingsButtonTableViewCell.reuseIdentifier()) as! SettingsButtonTableViewCell
            cell.configure(name: name, type: type)
            return cell
        case let .LoginButton(name, type):
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingsButtonTableViewCell.reuseIdentifier()) as! SettingsButtonTableViewCell
            cell.configure(name: name, type: type)
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          let type = tableViewcellTypes[indexPath.section][indexPath.row]
              
              switch type {
                  
              case .profile:
                 tableView.deselectRow(at: indexPath, animated: true)
              case .Switch:
                tableView.deselectRow(at: indexPath, animated: true)
              case .button:
                print("selected")
              case .LoginButton:
                performSegue(withIdentifier: "presentAuthentication", sender: nil)
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        switch section {
        case 1:
            let headerCell = tableView.dequeueReusableCell(withIdentifier: "SettingHeaderTableViewCellID") as! SettingHeaderTableViewCell
            headerCell.sectionName.text = "profile settings".uppercased()
            headerCell.sectionName.textColor = UIColor.systemGray
            return headerCell.contentView

        case 3:
            let headerCell = tableView.dequeueReusableCell(withIdentifier: "SettingHeaderTableViewCellID") as! SettingHeaderTableViewCell
            headerCell.sectionName.text = "Amount of people".uppercased()
            headerCell.sectionName.textColor = UIColor.systemGray
            return headerCell.contentView
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 1:
            return 50
        
        case 3:
            return 0
        default:
            return 0
        }
        
    }
    
    
    
}

extension SelectedOptionViewController : AuthenticationDelegate{
    func didAuthenticateSuccessfully(isTrue: Bool) {
        if isTrue{
            let types: [[SettingDataType]] = [[.profile],[.button("Edit", .normal),.button("Log out", .deadly)]]
            tableViewcellTypes = types
            UIView.transition(with: self.tableView,
            duration: 0.5,
            options: .transitionCrossDissolve,
            animations: { self.tableView.reloadData() })
        } else{
            tableViewcellTypes = [[.LoginButton("Log in", .deadly)]]
            UIView.transition(with: self.tableView,
             duration: 0.5,
             options: .transitionCrossDissolve,
             animations: { self.tableView.reloadData() })
        }
    }
    
    
}
