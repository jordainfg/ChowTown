//
//  ReservationsViewController.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 04/12/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit

enum reservationsDataType {
    case reservationType
  
    
    
}
class ReservationsViewController: UIViewController , MyCustomCellDelegator {
    var tableViewcellTypes: [[reservationsDataType]] {
        let types: [[reservationsDataType]] = [[.reservationType]]
        
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
          
           self.navigationController?.navigationBar.tintColor = UIColor.black
        
           
       }
    
   override var preferredStatusBarStyle: UIStatusBarStyle {
       return .darkContent
   }
    
    func setupTableView() {
        tableView.register(UINib(nibName: textFieldTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: textFieldTableViewCell.reuseIdentifier())
        tableView.register(UINib(nibName: ReservationTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: ReservationTableViewCell.reuseIdentifier())
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    // MARK: - Segue methods
       func callSegueFromCell(segueIdentifier: String, index : Int, selected : Any) {
         
           self.performSegue(withIdentifier: segueIdentifier, sender: nil )
       }
       
       override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
           switch segue.identifier {
        //
           default:
               return
           }
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
            
        case .reservationType:
            let cell = tableView.dequeueReusableCell(withIdentifier: ReservationTableViewCell.reuseIdentifier()) as! ReservationTableViewCell
        cell.delegate = self
            return cell
       
            
        }
    }
    func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      
               return 500
          
           
       }
    
  
    
    
}
