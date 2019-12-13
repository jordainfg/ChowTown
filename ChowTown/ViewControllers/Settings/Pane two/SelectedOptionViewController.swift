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
    
    //Profile headerID : 1
    case profile
    case LoginButton(String,buttonType)
    case LogOutbutton(String,buttonType)
    
    //headerID : 2
    case autoDarkModeSwitch(String)
    case lightModeButton(String,buttonType)
    case darkModeButton(String,buttonType)
    
    
    
}
class SelectedOptionViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var selectedSettings : SettingOptionDataType?
    
    var tableViewcellTypes: [[SettingDataType]] = [[.profile],[.LogOutbutton("Edit", .normal),.LogOutbutton("Log out", .deadly)]]
    
    var header:[Int:String] = [1:"", 2:"", 3:""]
    
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
                let types: [[SettingDataType]] = [[.profile],[.LogOutbutton("Edit", .normal),.LogOutbutton("Log out", .deadly)]]
                tableViewcellTypes = types
            } else {
                tableViewcellTypes = [[.LoginButton("Log in", .deadly)]]
            }
            
        case let .appearance(name):
            header[1] = "Light & dark mode".uppercased()
            header[2] = "The selected appearance will be used. System appearance is ignored"
            let types: [[SettingDataType]] = [[],[.autoDarkModeSwitch("Automaticly")]]
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
        case let .autoDarkModeSwitch(name):
            let cell = tableView.dequeueReusableCell(withIdentifier: SwitchTableViewCell.reuseIdentifier()) as! SwitchTableViewCell
            cell.name.text = name
            cell.delegate = self
            return cell
        case let .LogOutbutton(name, type):
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingsButtonTableViewCell.reuseIdentifier()) as! SettingsButtonTableViewCell
            cell.configure(name: name, type: type)
            return cell
        case let .LoginButton(name, type):
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingsButtonTableViewCell.reuseIdentifier()) as! SettingsButtonTableViewCell
            cell.configure(name: name, type: type)
            return cell
            
        case let .lightModeButton(name, type):
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingsButtonTableViewCell.reuseIdentifier()) as! SettingsButtonTableViewCell
            cell.configure(name: name, type: type)
            cell.accessoryType = .checkmark
            return cell
        case let .darkModeButton(name, type):
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
        case .autoDarkModeSwitch:
            tableView.deselectRow(at: indexPath, animated: true)
        case .LogOutbutton:
            print("selected")
        case .LoginButton:
            performSegue(withIdentifier: "presentAuthentication", sender: nil)
        case .lightModeButton(_):
            if let cell = tableView.cellForRow(at: indexPath) {
                resetChecks()
                // tableView.deselectRow(at: indexPath, animated: true)
                cell.accessoryType = .checkmark
                cell.selectionStyle = .none
            }
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .light
            }
        case .darkModeButton(_):
            if let cell = tableView.cellForRow(at: indexPath) {
                resetChecks()
                cell.accessoryType = .checkmark
                cell.selectionStyle = .none
            }
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .dark
            }
            
            return
        }
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        self.tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerCell = tableView.dequeueReusableCell(withIdentifier: "SettingHeaderTableViewCellID") as! SettingHeaderTableViewCell
            headerCell.sectionName.text = header[section]
            headerCell.sectionName.textColor = UIColor.systemGray
            return headerCell.contentView
            
       
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 10
        default:
        return 40
        }
    }
    
    func resetChecks() {
        for i in 0..<tableView.numberOfSections {
            for j in 0..<tableView.numberOfRows(inSection: i) {
                if let cell = tableView.cellForRow(at: IndexPath(row: j, section: i)) {
                    cell.accessoryType = .none
                }
            }
        }
    }
    
    
}

extension SelectedOptionViewController : AuthenticationDelegate{
    func didAuthenticateSuccessfully(isTrue: Bool) {
        if isTrue{
            let types: [[SettingDataType]] = [[.profile],[.LogOutbutton("Edit", .normal),.LogOutbutton("Log out", .deadly)]]
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

extension SelectedOptionViewController : appearanceSwitchDelegator{
   
    
    func AppearanceOptions(isDisplayed: Bool) {
        if isDisplayed{
            let types: [[SettingDataType]] = [[],[.autoDarkModeSwitch("Automaticly")], [.lightModeButton("Always Light", .normal),.darkModeButton("Always Dark", .normal)]]
              tableViewcellTypes = types
              UIView.transition(with: self.tableView,
                                           duration: 0.5,
                                           options: .transitionCrossDissolve,
                                           animations: { self.tableView.reloadData() })
        }
        else {
            let types: [[SettingDataType]] = [[],[.autoDarkModeSwitch("Automaticly")]]
                     tableViewcellTypes = types
                     UIView.transition(with: self.tableView,
                                                  duration: 0.5,
                                                  options: .transitionCrossDissolve,
                                                  animations: { self.tableView.reloadData() })
        }
  
    }
    
    
}
