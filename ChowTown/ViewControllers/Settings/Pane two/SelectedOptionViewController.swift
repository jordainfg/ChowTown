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
    
    //SelectedOption 1
    case profile
    case LoginButton(String,buttonType)
    case LogOutbutton(String,buttonType)
    
    //SelectedOption 2
    case autoDarkModeSwitch(String)
    case lightModeButton(String,buttonType)
    case darkModeButton(String,buttonType)
    
    //SelectedOption 3
    case versionNumber(String, String)
    case refrencetextBox(String)
    
}
class SelectedOptionViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var selectedSettings : SettingOptionDataType?
    
    var tableViewcellTypes: [[SettingDataType]] = [[],[.profile],[.LogOutbutton("Log out", .deadly)]]
    
    var header:[Int:String] = [1:"", 2:"", 3:""]
    
    var delegate : AuthenticationDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSettingsForView(selectedSettings: selectedSettings!) // TODO - Remove force unwrapping
        setupTableView()
        
    }
    
    func configureSettingsForView(selectedSettings : SettingOptionDataType){
        switch selectedSettings{
        case let .profile(name):
            self.title = name
            if FirebaseService.shared.authState == .isLoggedIn{
                header[1] = "Profile info".uppercased()
                header[2] = "Options".uppercased()
                let types: [[SettingDataType]] = [[],[.profile],[.LogOutbutton("Log out", .deadly)]]
                tableViewcellTypes = types
            } else {
                header[1] = "Options".uppercased()
                tableViewcellTypes = [[],[.LoginButton("Log in", .deadly)]]
            }
            
        case let .appearance(name):
            header[1] = "Light & dark mode".uppercased()
            header[2] = "The selected appearance will be used. System appearance will be ignored"
            AppearanceOptions(isDisplayed: !UserDefaults.standard.bool(forKey: "AutoModeIsOn"))
            self.title = name
            
        case .review(_):
            return
        case .contact(_):
            return
        case let .aboutApp(name):
            header[1] = "Berry".uppercased()
            header[2] = "References"
            let types: [[SettingDataType]] = [[],[.versionNumber("Version","1.0.0")],[.refrencetextBox("Icons provided by https://icons8.com, illustrations provided by https://www.freepik.com")]]
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
        tableView.register(UINib(nibName: SettingsTextBoxTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: SettingsTextBoxTableViewCell.reuseIdentifier())
        tableView.register(UINib(nibName: SettingsInfoTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: SettingsInfoTableViewCell.reuseIdentifier())
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
            cell.accessoryType = UserDefaults.standard.bool(forKey: "lightModeIsOn") ? .checkmark : .none
            return cell
        case let .darkModeButton(name, type):
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingsButtonTableViewCell.reuseIdentifier()) as! SettingsButtonTableViewCell
            cell.configure(name: name, type: type)
            cell.accessoryType = UserDefaults.standard.bool(forKey: "lightModeIsOn") ? .none : .checkmark
            return cell
        case let .refrencetextBox(text):
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTextBoxTableViewCell.reuseIdentifier()) as! SettingsTextBoxTableViewCell
            cell.configure(text: text)
            return cell
        case let .versionNumber(leadingText, trailingText):
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingsInfoTableViewCell.reuseIdentifier()) as! SettingsInfoTableViewCell
            cell.configure(leadingText: leadingText, trailingText: trailingText)
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
            FirebaseService.shared.clearAllSessionData()
            configureSettingsForView(selectedSettings: selectedSettings!)
            delegate?.didLogout()
            tableView.reloadData()
        case .LoginButton:
            performSegue(withIdentifier: "presentAuthentication", sender: nil)
        case .lightModeButton(_):
            UserDefaults.standard.set(true, forKey: "lightModeIsOn")
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
            UserDefaults.standard.set(false, forKey: "lightModeIsOn")
            if let cell = tableView.cellForRow(at: indexPath) {
                resetChecks()
                cell.accessoryType = .checkmark
                cell.selectionStyle = .none
            }
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .dark
            }
            
            return
        case .refrencetextBox(_):
            tableView.deselectRow(at: indexPath, animated: true)
        case .versionNumber(_, _):
            tableView.deselectRow(at: indexPath, animated: true)
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
            return 5
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
    func didCreateSuccessfully(isTrue: Bool) {
        
    }
    
    func didLogout() {
        
    }
    
    func didAuthenticateSuccessfully(isTrue: Bool) {
        if isTrue{
            header[1] = "Profile info".uppercased()
            header[2] = "Options".uppercased()
            let types: [[SettingDataType]] = [[],[.profile],[.LogOutbutton("Log out", .deadly)]]
            tableViewcellTypes = types
            UIView.transition(with: self.tableView,
                              duration: 0.5,
                              options: .transitionCrossDissolve,
                              animations: { self.tableView.reloadData() })
        } else{

            header[1] = "Options".uppercased()
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
            let types: [[SettingDataType]] = [[],[.autoDarkModeSwitch("Automatically")], [.lightModeButton("Always Light", .normal),.darkModeButton("Always Dark", .normal)]]
                    tableViewcellTypes = types
                    UIView.transition(with: self.tableView,
                                      duration: 0.5,
                                      options: .transitionCrossDissolve,
                                      animations: { self.tableView.reloadData() })
        }
        else {
        let types: [[SettingDataType]] = [[],[.autoDarkModeSwitch("Automatically")]]
                   tableViewcellTypes = types
                   UIView.transition(with: self.tableView,
                                     duration: 0.5,
                                     options: .transitionCrossDissolve,
                                     animations: { self.tableView.reloadData() })
                   
        }
        
    }
    
    
}


