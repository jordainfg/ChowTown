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
    var menu : Menu? = nil
    var selectedMeal : Meal?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel.getMealsForMenu(selectedMenu: menu!){
            self.tableView.reloadData()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = nil
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.white
    }
    
    func setupTableView() {
        tableView.register(UINib(nibName: SubMenuMealsAndDrinksTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: SubMenuMealsAndDrinksTableViewCell.reuseIdentifier())
        tableView.register(UINib(nibName: SubMenuMealsAndDrinksFilteringTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: SubMenuMealsAndDrinksFilteringTableViewCell.reuseIdentifier())
    }
    
    // MARK: - Segue methods
    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        switch segue.identifier {
        case "toMeal":
            let secondVC = segue.destination as! SpecialsDetailViewController
            secondVC.isPopOver = false
            secondVC.meal = selectedMeal
        default:
            return
        }
    }
    
    
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
            let cell = tableView.dequeueReusableCell(withIdentifier: SubMenuMealsAndDrinksFilteringTableViewCell.reuseIdentifier()) as! SubMenuMealsAndDrinksFilteringTableViewCell
            cell.selectionStyle = .none
          //  cell.isUserInteractionEnabled = false
            cell.delegate = self
            return cell
            
        case  let .meal(meal):
            let cell = tableView.dequeueReusableCell(withIdentifier: SubMenuMealsAndDrinksTableViewCell.reuseIdentifier()) as! SubMenuMealsAndDrinksTableViewCell
            cell.selectionStyle = .none
            let httpsReference =  viewModel.storage.reference(forURL: meal.imageRef)
            cell.configure(meal: meal, httpReference : httpsReference)
            
            
            return cell
            
        case .drink:
            let cell = tableView.dequeueReusableCell(withIdentifier: SubMenuMealsAndDrinksTableViewCell.reuseIdentifier()) as! SubMenuMealsAndDrinksTableViewCell
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type = viewModel.SubMenuMealsAndDrinksTableViewcellTypes[indexPath.section][indexPath.row]
        switch type {
        case .header:
          tableView.deselectRow(at: indexPath, animated: true)
        case let .meal(meal):
            selectedMeal = meal
            tableView.deselectRow(at: indexPath, animated: true)
            if selectedMeal != nil{
                tableView.deselectRow(at: indexPath, animated: true)
                performSegue(withIdentifier: "toMeal", sender: nil)
            }
        case .drink:
             tableView.deselectRow(at: indexPath, animated: true)
     
        }
        
        
    }
    // set the height of the row based on the chosen cell
    func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let type = viewModel.SubMenuMealsAndDrinksTableViewcellTypes[indexPath.section][indexPath.row]
        switch type {
        case .header:
            return 70
        case .meal:
            return 80
        case .drink:
            return 40
        }
    }
    
    
    
}


extension SubMenuMealsAndDrinksViewController : filteringDelegate{
    func didSelectFilterOptions() {
//        let indexPath = IndexPath(row: 0, section:  0)
//
//        tableView.reloadRows(at: [indexPath], with: .fade)
    }
    
    
}
