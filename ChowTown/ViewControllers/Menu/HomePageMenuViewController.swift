//
//  ChoiceMenuViewController.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 11/11/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit


class HomePageMenuViewController: UIViewController,MyCustomCellDelegator {
    
    // MARK: - Variables
    let viewModel = ViewModel()
    var selectedSpecial = 0
    var selectedMenu : Menu?
    
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - ViewDidLoad, Apear, Desapear
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupTableView()
         //viewModel.addRestaurant()
//        viewModel.getMealsForMenu()  {
//            self.tableView.reloadData()
//        }
        if UserDefaults.standard.string(forKey: "selectedRestaurant") != nil{
            viewModel.getMenus(forRestaurant: UserDefaults.standard.string(forKey: "selectedRestaurant")!) {
                self.tableView.reloadData()
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = nil
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.white
        
    }
    
    
    // MARK: - Setup View and TableView
    func setupTableView() {
        tableView.register(UINib(nibName: MealCollectionTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: MealCollectionTableViewCell.reuseIdentifier())
        tableView.register(UINib(nibName: MenuSpecialsTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: MenuSpecialsTableViewCell.reuseIdentifier())
        tableView.register(UINib(nibName: HeaderForTableViewSection.nibName(), bundle: nil), forCellReuseIdentifier: HeaderForTableViewSection.reuseIdentifier())
        tableView.register(UINib(nibName: SubMenuTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: SubMenuTableViewCell.reuseIdentifier())
        tableView.register(UINib(nibName: SubMenuHeaderTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: SubMenuHeaderTableViewCell.reuseIdentifier())
        tableView.showsHorizontalScrollIndicator = false
    }
    
    // MARK: - Segue methods
    func callSegueFromCell(segueIdentifier: String, index : Int, selected : Any) {
        selectedSpecial = index
        selectedMenu = selected as? Menu
        self.performSegue(withIdentifier: segueIdentifier, sender: nil )
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        switch segue.identifier {
        case "toMeal":
            let secondVC = segue.destination as! SpecialsDetailViewController
            secondVC.specialHeroID = selectedSpecial
            secondVC.meal = viewModel.meals[selectedSpecial]
            secondVC.isPopOver = true
        case "toSubMenuMealsAndDrinks":
            let secondVC = segue.destination as! SubMenuMealsAndDrinksViewController
            secondVC.menu = selectedMenu
        default:
            return
        }
    }
    
}
extension HomePageMenuViewController : UITableViewDataSource , UITableViewDelegate{
    
    func numberOfSections(in _: UITableView) -> Int {
        return viewModel.choiceMenuTableViewCellTypes.count
    }
    
    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.choiceMenuTableViewCellTypes[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = viewModel.choiceMenuTableViewCellTypes[indexPath.section][indexPath.row]
        switch type {
            
        case let .MenuSpecials(meals):
            let cell = tableView.dequeueReusableCell(withIdentifier: MenuSpecialsTableViewCell.reuseIdentifier()) as! MenuSpecialsTableViewCell
            cell.delegate = self
            cell.meals = meals
            cell.collectionView.reloadData()
            return cell
            
        case let .MenuFood(foodMenus):
            let cell = tableView.dequeueReusableCell(withIdentifier: SubMenuTableViewCell.reuseIdentifier()) as! SubMenuTableViewCell
            cell.setMenus(menus: foodMenus)
            cell.tint = UIColor.white
            cell.delegate = self
            return cell
            
        case let .MenuDrinks(drinkMenu):
            let cell = tableView.dequeueReusableCell(withIdentifier: SubMenuTableViewCell.reuseIdentifier()) as! SubMenuTableViewCell
            cell.setMenus(menus: drinkMenu)
            cell.tint = UIColor.white
            cell.delegate = self
            return cell
            
        case .MenuHeader(_):
            let cell = tableView.dequeueReusableCell(withIdentifier: SubMenuHeaderTableViewCell.reuseIdentifier()) as! SubMenuHeaderTableViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "toMenu", sender: nil)
        
    }
    
    // set the height of the row based on the chosen cell
    func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let type = viewModel.choiceMenuTableViewCellTypes[indexPath.section][indexPath.row]
        switch type {
        case .MenuFood:
            return 180
        case .MenuSpecials:
            return 330
        case .MenuDrinks(_):
            return 180
        case .MenuHeader(_):
            return 90
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 1:
            let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderForTableViewSectionID") as! HeaderForTableViewSection
            headerCell.sectionName.text = "Popular Eatries"
            return headerCell.contentView
        case 2:
            let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderForTableViewSectionID") as! HeaderForTableViewSection
            headerCell.sectionName.text = "Menus"
            return headerCell.contentView
        case 3:
            let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderForTableViewSectionID") as! HeaderForTableViewSection
            headerCell.sectionName.text = "Drinks"
            return headerCell.contentView
        default:
            let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderForTableViewSectionID") as! HeaderForTableViewSection
            headerCell.sectionName.text = ""
            return headerCell.contentView
        }
    }
    
    func tableView(_: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 40
    }
    
    
}
