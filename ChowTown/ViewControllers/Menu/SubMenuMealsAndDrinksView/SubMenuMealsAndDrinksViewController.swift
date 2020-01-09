//
//  SubMenuMealsAndDrinksViewController.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 20/11/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit
import NotificationBannerSwift
class SubMenuMealsAndDrinksViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel = ViewModel()
    var menu : Menu? = nil
    var selectedMeal : Meal?
    let banner = NotificationBanner(customView: reloadView(frame: .zero))
    
    var filterMeals : [Meal] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.filterdMeals.removeAll()
        self.tableView.restore()
        self.title = menu?.title
        setupTableView()
        tableView.LoadingIndicator(isVisable: true)
        banner.bannerHeight = 120
        self.banner.onTap = {
            // Do something regarding the banner
            self.getMealsForMenu()
        }
        
       
        getMealsForMenu()
        
         self.navigationController?.navigationBar.setValue(false, forKey: "hidesShadow")
        
    }
    
        override func viewWillAppear(_ animated: Bool) {
           self.navigationController?.navigationBar.setValue(false, forKey: "hidesShadow")
       }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    func setupTableView() {
        let emptyView = emptyTableView(frame : .zero)
               emptyView.titleLabel.text = "Coming soon"
               emptyView.titleLabel.text = ""
               
                   self.tableView.backgroundView = emptyView
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
            secondVC.viewModel = self.viewModel
        default:
            return
        }
    }
    
    func getMealsForMenu() {
        if let unwrappedMenu = menu {
            viewModel.getMealsForMenu(selectedMenu: unwrappedMenu){(result) in
                switch result {
                case .success:
                    self.viewModel.filterdMeals = self.viewModel.meals
                    self.tableView.LoadingIndicator(isVisable: false)
                    UIView.transition(with: self.tableView,
                                      duration: 0.5,
                                      options: .transitionCrossDissolve,
                                      animations: { self.tableView.reloadData() })
                case .failure:
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                        self.banner.show()
                    })
                    
                }
                
                
                
            }
        } else {
            // TODO - Error getting menu , think about what to do in this sencerio
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
}

extension SubMenuMealsAndDrinksViewController : UITableViewDataSource , UITableViewDelegate{
    
    func numberOfSections(in _: UITableView) -> Int {
        
        
        return viewModel.SubMenuMealsAndDrinksTableViewcellTypes.count
    }
    
    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        let emptyView = emptyTableView(frame : .zero)
        emptyView.titleLabel.text = ""
        emptyView.subTitleLabel.text = ""
        if viewModel.filterdMeals.count == 0 {
            self.tableView.backgroundView = emptyView
        } else {
           self.tableView.backgroundView = nil
        }
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
            let storageReference = viewModel.storage.reference(forURL: meal.imageRef)
            cell.configure(meal: meal, StorageRef : storageReference)
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
            viewModel.selectedMeal = meal
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
    func didSelectFilterOption(optionNumber: Int) {
        
        if optionNumber == 0 {
            viewModel.filterdMeals = self.viewModel.meals
            UIView.transition(with: self.tableView,
                              duration: 0.5,
                              options: .transitionCrossDissolve,
                              animations: { self.tableView.reloadData() })
        } else {
            viewModel.filterdMeals = self.viewModel.meals
            viewModel.filterdMeals = self.viewModel.meals.filter {$0.about.contains(where: { $0 == optionNumber })  }
            UIView.transition(with: self.tableView,
                              duration: 0.5,
                              options: .transitionCrossDissolve,
                              animations: { self.tableView.reloadData() })
        }
        
    }
    
    
    
}
