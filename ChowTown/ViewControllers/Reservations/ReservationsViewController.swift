//
//  ReservationsViewController.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 04/12/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit

enum reservationsDataType {
    case textField
    case datePicker
    
    
}
class ReservationsViewController: UIViewController {
    var tableViewcellTypes: [[reservationsDataType]] {
        let types: [[reservationsDataType]] = [[.textField]]
        
        return types
    }
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView() {
        tableView.register(UINib(nibName: textFieldTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: textFieldTableViewCell.reuseIdentifier())
        tableView.register(UINib(nibName: ReservationTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: ReservationTableViewCell.reuseIdentifier())
        tableView.rowHeight = UITableView.automaticDimension
    }
    
}


extension ReservationsViewController : UITableViewDataSource , UITableViewDelegate , UITextFieldDelegate{
    
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
            
        case .textField:
            let cell = tableView.dequeueReusableCell(withIdentifier: ReservationTableViewCell.reuseIdentifier()) as! ReservationTableViewCell
        
            return cell
        case .datePicker:
            let cell = tableView.dequeueReusableCell(withIdentifier: ReservationTableViewCell.reuseIdentifier()) as! textFieldTableViewCell
            
            return cell
            
        }
    }
    func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      
               return 500
          
           
       }
    
  
    
    
}
