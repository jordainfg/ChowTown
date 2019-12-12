//
//  SettingsViewController.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 12/12/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit

enum SettingOptionDataType {
    case profile(String)
    case appearance(String)
    
}
class SettingsViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var selectedSetting : SettingOptionDataType?
    
    var tableViewcellTypes: [[SettingOptionDataType]] {
        let types: [[SettingOptionDataType]] = [[.profile("Profile")],[.appearance("Appearance")]]
        
        return types
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        // Do any additional setup after loading the view.
    }
    
    
    func setupTableView() {
      
        tableView.register(UINib(nibName: SettingOptionTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: SettingOptionTableViewCell.reuseIdentifier())
        tableView.register(UINib(nibName: SettingHeaderTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: SettingHeaderTableViewCell.reuseIdentifier())
        //        tableView.register(UINib(nibName: "HeaderForTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderCellIdentifier")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
              switch segue.identifier {
              case "toSecondSettingPane":
                  let secondVC = segue.destination as! SelectedOptionViewController
                  secondVC.selectedSettings = selectedSetting
              default:
                  return
              }
          }
}

extension SettingsViewController : UITableViewDataSource , UITableViewDelegate , UITextFieldDelegate{
    
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
            
        case let .profile(name):
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingOptionTableViewCell.reuseIdentifier()) as! SettingOptionTableViewCell
            cell.name.text = name
            cell.iCon.image = UIImage(systemName: "person.crop.circle.fill")
            cell.iCon.backgroundColor = UIColor.systemRed
            return cell
        case let .appearance(name):
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingOptionTableViewCell.reuseIdentifier()) as! SettingOptionTableViewCell
            cell.name.text = name
            cell.iCon.image = UIImage(systemName: "lightbulb.fill")
            return cell
            
            
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          let type = tableViewcellTypes[indexPath.section][indexPath.row]
              
              switch type {
                  
              case let .profile(name):
                selectedSetting = .profile(name)
                performSegue(withIdentifier: "toSecondSettingPane", sender: nil)
                 tableView.deselectRow(at: indexPath, animated: true)
              case let .appearance(name):
                selectedSetting = .appearance(name)
                performSegue(withIdentifier: "toSecondSettingPane", sender: nil)
                tableView.deselectRow(at: indexPath, animated: true)
                  
                  
              }
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch section {
        case 0:
            let headerCell = tableView.dequeueReusableCell(withIdentifier: "SettingHeaderTableViewCellID") as! SettingHeaderTableViewCell
            headerCell.sectionName.text = "Your info".uppercased()
            headerCell.sectionName.textColor = UIColor.systemGray
            return headerCell.contentView
        case 1:
            let headerCell = tableView.dequeueReusableCell(withIdentifier: "SettingHeaderTableViewCellID") as! SettingHeaderTableViewCell
            headerCell.sectionName.text = "Date and time".uppercased()
            headerCell.sectionName.textColor = UIColor.systemGray
            return headerCell.contentView
        case 2:
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
        case 0:
            return 30
        case 1:
            return 30
        case 2:
            return 40
        default:
            return 0
        }
        
    }
    
    
    
}
