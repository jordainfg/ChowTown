//
//  SettingsViewController.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 12/12/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit
import SPStorkController
import MessageUI

enum SettingOptionDataType {
    case profile(String)
    case appearance(String)
    case review(String)
    case contact(String)
    case aboutApp(String)
    
}
class SettingsViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var selectedSetting : SettingOptionDataType?
    
    var delegate : AuthenticationDelegate?
    
    var tableViewcellTypes: [[SettingOptionDataType]] {
        let types: [[SettingOptionDataType]] = [[.profile("Profile")],[.appearance("Appearance")],[.review("Leave a review"),.contact("Contact the developer")],[.aboutApp("About the App")]]
        
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
            secondVC.delegate = self
        default:
            return
        }
    }
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
            cell.iCon.backgroundColor = UIColor.hexStringToUIColor(hex: "#D45C6F")
            return cell
        case let .appearance(name):
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingOptionTableViewCell.reuseIdentifier()) as! SettingOptionTableViewCell
            cell.name.text = name
            cell.iCon.image = UIImage(systemName: "lightbulb.fill")
            cell.iCon.backgroundColor = UIColor.hexStringToUIColor(hex: "#FECB00")
            return cell
            
        case let .review(name):
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingOptionTableViewCell.reuseIdentifier()) as! SettingOptionTableViewCell
            cell.name.text = name
            cell.iCon.image = UIImage(systemName: "suit.heart.fill")
            cell.iCon.backgroundColor = UIColor.systemPink
            return cell
        case let .contact(name):
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingOptionTableViewCell.reuseIdentifier()) as! SettingOptionTableViewCell
            cell.name.text = name
            cell.iCon.image = UIImage(systemName: "envelope.fill")
            cell.iCon.backgroundColor = UIColor.softBlue
            return cell
        case let .aboutApp(name):
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingOptionTableViewCell.reuseIdentifier()) as! SettingOptionTableViewCell
            cell.name.text = name
            cell.iCon.image = UIImage(systemName: "house.fill")
            cell.iCon.backgroundColor = UIColor.systemIndigo
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
            
            
        case .review(_):
            return
        case .contact(_):
            tableView.deselectRow(at: indexPath, animated: true)
            
            if MFMailComposeViewController.canSendMail() {
                let mail = MFMailComposeViewController()
                mail.mailComposeDelegate = self
                mail.setToRecipients(["you@yoursite.com"])
                mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)
                
                present(mail, animated: true)
            } else {
                let Alert = UIAlertController(title: "Contact the developer by email", message: "Featurexi@gmail.com", preferredStyle: UIAlertController.Style.alert)
                Alert.addAction(UIAlertAction(title: "Copy email to clipboard", style: .default) { (_: UIAlertAction) in
                UIPasteboard.general.string = "Featurexi@gmail.com"
                })
                self.present(Alert, animated: true)
            }
            
        case let .aboutApp(name):
         selectedSetting = .aboutApp(name)
            performSegue(withIdentifier: "toSecondSettingPane", sender: nil)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch section {
            
        case 1:
            let headerCell = tableView.dequeueReusableCell(withIdentifier: "SettingHeaderTableViewCellID") as! SettingHeaderTableViewCell
            headerCell.sectionName.text = "App".uppercased()
            headerCell.sectionName.textColor = UIColor.systemGray
            return headerCell.contentView
        case 2:
            let headerCell = tableView.dequeueReusableCell(withIdentifier: "SettingHeaderTableViewCellID") as! SettingHeaderTableViewCell
            headerCell.sectionName.text = "Feedback".uppercased()
            headerCell.sectionName.textColor = UIColor.systemGray
            return headerCell.contentView
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 40
        case 1:
            return 30
        case 2:
            return 40
        default:
            return 0
        }
        
    }
    
    
    
}

extension SettingsViewController : AuthenticationDelegate{
    func didCreateSuccessfully(isTrue: Bool) {
        
    }
    
    func didAuthenticateSuccessfully(isTrue: Bool) {
        
    }
    
    func didLogout() {
        delegate?.didLogout()
    }
    
    
}
