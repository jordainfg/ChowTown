//
//  SubMenuMealsAndDrinksViewController.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 20/11/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit

class SubMenuMealsAndDrinksViewController: UIViewController {
  
    
      @IBOutlet weak var tableView: UITableView!
    let viewModel = ViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
         self.navigationController?.navigationBar.shadowImage = nil
          self.navigationController?.navigationBar.isTranslucent = true
          self.navigationController?.view.backgroundColor = UIColor.white
    }
    
    func setupTableView() {
        tableView.register(UINib(nibName: SubMenuMealsAndDrinksTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: SubMenuMealsAndDrinksTableViewCell.reuseIdentifier())
        tableView.register(UINib(nibName: SubMenuMealsAndDrinksHeaderTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: SubMenuMealsAndDrinksHeaderTableViewCell.reuseIdentifier())
        //        tableView.register(UINib(nibName: MeetingInfoDatePickerTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: MeetingInfoDatePickerTableViewCell.reuseIdentifier())
        //        tableView.register(UINib(nibName: "HeaderForTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderCellIdentifier")
    }
    
    // MARK: - Segue methods
//      func callSegueFromCell(segueIdentifier: String, index : Int) {
//          selectedSpecial = index
//              self.performSegue(withIdentifier: segueIdentifier, sender: nil )
//        }
//      override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
//             switch segue.identifier {
//             case "toMeal":
//                 let secondVC = segue.destination as! SpecialsDetailViewController
//                 secondVC.specialHeroID = selectedSpecial
//                 //        case "":
//                 //
//                 //        case "":
//                 //
//                 //
//                 //        case "":
//
//             default:
//                 return
//             }
//         }
    
    
}

extension SubMenuMealsAndDrinksViewController : UITableViewDataSource , UITableViewDelegate{
    
    func numberOfSections(in _: UITableView) -> Int {
        return viewModel.SubMenuMealsAndDrinksTableViewcellTypes.count
    }
    
    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.SubMenuMealsAndDrinksTableViewcellTypes[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = viewModel.SubMenuMealsAndDrinksTableViewcellTypes[indexPath.section][indexPath.row]
        
        switch type {
            
            
        case .header:
            let cell = tableView.dequeueReusableCell(withIdentifier: SubMenuMealsAndDrinksHeaderTableViewCell.reuseIdentifier()) as! SubMenuMealsAndDrinksHeaderTableViewCell
             cell.selectionStyle = .none
             cell.isUserInteractionEnabled = false
            return cell
        case .meal:
            let cell = tableView.dequeueReusableCell(withIdentifier: SubMenuMealsAndDrinksTableViewCell.reuseIdentifier()) as! SubMenuMealsAndDrinksTableViewCell
            cell.selectionStyle = .none
            return cell
        case .drink:
            let cell = tableView.dequeueReusableCell(withIdentifier: SubMenuMealsAndDrinksTableViewCell.reuseIdentifier()) as! SubMenuMealsAndDrinksTableViewCell
            return cell
            
        }
    }
    
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "toMeal", sender: nil)
        
    }
    // set the height of the row based on the chosen cell
    func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let type = viewModel.SubMenuMealsAndDrinksTableViewcellTypes[indexPath.section][indexPath.row]
        switch type {
    
        case .header:
        return 400
        case .meal:
             return 90
        case .drink:
             return 40
          }
    }

    
    
}
