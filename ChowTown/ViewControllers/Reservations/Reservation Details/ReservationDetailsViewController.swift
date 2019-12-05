//
//  ReservationDetailsViewController.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 04/12/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit
enum reservationDetailDataType {
    case name
    case email
    case phone
    case date
    case amountOfPeople
    case allergens
    case other
    case button
    
    
}
class ReservationDetailsViewController: UIViewController {
    var tableViewcellTypes: [[reservationDetailDataType]] {
        let types: [[reservationDetailDataType]] = [[.name,.email,.phone,.allergens],[.date],[.amountOfPeople],[.button]]
        
        return types
    }
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
   
    override func viewWillAppear(_ animated: Bool) {
             self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            // self.navigationController?.navigationBar.shadowImage = UIImage()
             self.navigationController?.navigationBar.isTranslucent = true
            
        self.navigationController?.navigationBar.tintColor = UIColor.label
          
             
         }
    func setupTableView() {
        tableView.register(UINib(nibName: textFieldTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: textFieldTableViewCell.reuseIdentifier())
        tableView.register(UINib(nibName: DateTimePickerTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: DateTimePickerTableViewCell.reuseIdentifier())
        tableView.register(UINib(nibName: HeaderForTableViewSection.nibName(), bundle: nil), forCellReuseIdentifier: HeaderForTableViewSection.reuseIdentifier())
        tableView.register(UINib(nibName: DataPickerTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: DataPickerTableViewCell.reuseIdentifier())
        tableView.register(UINib(nibName: MakeReservationButtonTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: MakeReservationButtonTableViewCell.reuseIdentifier())
        tableView.rowHeight = UITableView.automaticDimension
    }
    
}


extension ReservationDetailsViewController : UITableViewDataSource , UITableViewDelegate , UITextFieldDelegate{
    
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
            
        case .name:
            let cell = tableView.dequeueReusableCell(withIdentifier: textFieldTableViewCell.reuseIdentifier()) as! textFieldTableViewCell
            cell.configure(placeHoldertext: "Name", textFieldType: textFieldDataType.name)
            cell.textField.delegate = self
            return cell
        case .email:
            let cell = tableView.dequeueReusableCell(withIdentifier: textFieldTableViewCell.reuseIdentifier()) as! textFieldTableViewCell
            cell.configure(placeHoldertext: "Email", textFieldType: textFieldDataType.email)
            cell.textField.delegate = self
            return cell
        case .phone:
            let cell = tableView.dequeueReusableCell(withIdentifier: textFieldTableViewCell.reuseIdentifier()) as! textFieldTableViewCell
            cell.configure(placeHoldertext: "Phone", textFieldType: textFieldDataType.phone)
            cell.textField.delegate = self
            return cell
        case .allergens:
            let cell = tableView.dequeueReusableCell(withIdentifier: textFieldTableViewCell.reuseIdentifier()) as! textFieldTableViewCell
            cell.configure(placeHoldertext: "Allergens and dietary wishes", textFieldType: textFieldDataType.name)
            cell.textField.delegate = self
            return cell
        case .other:
            let cell = tableView.dequeueReusableCell(withIdentifier: textFieldTableViewCell.reuseIdentifier()) as! textFieldTableViewCell
            cell.configure(placeHoldertext: "Name", textFieldType: textFieldDataType.name)
            cell.textField.delegate = self
            return cell
        case .date:
            let cell = tableView.dequeueReusableCell(withIdentifier: DateTimePickerTableViewCell.reuseIdentifier()) as! DateTimePickerTableViewCell
            return cell
        case .amountOfPeople:
            let cell = tableView.dequeueReusableCell(withIdentifier: DataPickerTableViewCell.reuseIdentifier()) as! DataPickerTableViewCell
            return cell
        case .button:
            let cell = tableView.dequeueReusableCell(withIdentifier: MakeReservationButtonTableViewCell.reuseIdentifier()) as! MakeReservationButtonTableViewCell
                      return cell
        }
        
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let type = tableViewcellTypes[indexPath.section][indexPath.row]
        switch type {

        case .date:
            return 140
        case .amountOfPeople:
            return 120
        case .button:
        return 50
        default:
            return 90
        }
    }
    
    
    
    
    
}
