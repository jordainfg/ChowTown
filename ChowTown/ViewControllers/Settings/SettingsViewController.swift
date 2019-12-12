//
//  SettingsViewController.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 12/12/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit

enum SettingOptionDataType {
    case appearance

}
class SettingsViewController: UIViewController {


    @IBOutlet weak var tableView: UITableView!
    var tableViewcellTypes: [[SettingOptionDataType]] {
        let types: [[SettingOptionDataType]] = [[.appearance,.appearance],[.appearance,.appearance]]
        
            return types
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
setupTableView()
        // Do any additional setup after loading the view.
    }
 
    
    func setupTableView() {
      
      tableView.register(UINib(nibName: SettingOptionTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: SettingOptionTableViewCell.reuseIdentifier())
     tableView.register(UINib(nibName: HeaderForTableViewSection.nibName(), bundle: nil), forCellReuseIdentifier: HeaderForTableViewSection.reuseIdentifier())
    //        tableView.register(UINib(nibName: "HeaderForTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderCellIdentifier")
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
    
        case .appearance:
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingOptionTableViewCell.reuseIdentifier()) as! SettingOptionTableViewCell
                return cell
       
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        let cornerRadius = 5
        var corners: UIRectCorner = []

        if indexPath.row == 0
        {
            corners.update(with: .topLeft)
            corners.update(with: .topRight)
        }

        if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1
        {
            corners.update(with: .bottomLeft)
            corners.update(with: .bottomRight)
        }

        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: cell.bounds,
                                      byRoundingCorners: corners,
                                      cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).cgPath
        cell.layer.mask = maskLayer
    }
    
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch section {
        case 0:
            let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderForTableViewSectionID") as! HeaderForTableViewSection
            headerCell.sectionName.text = "Your info"
            headerCell.sectionName.textColor = UIColor.systemIndigo
            return headerCell.contentView
        case 1:
            let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderForTableViewSectionID") as! HeaderForTableViewSection
            headerCell.sectionName.text = "Date and time"
             headerCell.sectionName.textColor = UIColor.systemIndigo
            return headerCell.contentView
        case 2:
            let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderForTableViewSectionID") as! HeaderForTableViewSection
            headerCell.sectionName.text = "Amount of people"
            headerCell.sectionName.textColor = UIColor.systemIndigo
            return headerCell.contentView
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 60
        case 1:
            return 30
        case 2:
            return 40
        default:
            return 0
        }
        
    }
 
    
    
}
