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
    var viewModel = ViewModel()
    var selectedSpecial = 0
    var selectedMenu : Menu?
    
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - ViewDidLoad, Apear, Desapear
    override func viewDidLoad() {
        super.viewDidLoad()
      //  viewModel.favoriteRestaurant()
        setupTableView()
        //viewModel.addPopularMeal()
        //viewModel.addRestaurant()
        //        viewModel.getMealsForMenu()  {
        //            self.tableView.reloadData()
        //        }
        if UserDefaults.standard.string(forKey: "selectedRestaurant") != nil{
            viewModel.getMenus(forRestaurant: UserDefaults.standard.string(forKey: "selectedRestaurant")!) {
                UIView.transition(with: self.tableView,
                                  duration: 0.5,
                                  options: .transitionCrossDissolve,
                                  animations: { self.tableView.reloadData() })
                
                
            }
            viewModel.getPopularMeals{
                UIView.transition(with: self.tableView,
                                  duration: 0.5,
                                  options: .transitionCrossDissolve,
                                  animations: { self.tableView.reloadData() })
            }
        }
        setupView()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    
    
    
    func setupView(){
        let backButton = UIBarButtonItem()
        backButton.title = "" //in your case it will be empty or you can put the title of your choice
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        let backImage = UIImage(systemName: "chevron.left.circle.fill")
        backButton.tintColor = UIColor.label
        self.navigationController?.navigationBar.backIndicatorImage = backImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = nil
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.black
    }
    @IBAction func changeLocationButtonPressed(_ sender: Any) {
        // 1
        let optionMenu = UIAlertController(title: nil, message: "Would you like add a new menu?", preferredStyle: .actionSheet)
        
        // 2
        let action = UIAlertAction(title: "Yes", style: .default, handler: {(alert: UIAlertAction!) in
            
            self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {(alert: UIAlertAction!) in
            optionMenu.dismiss(animated: true, completion: nil)
        })
        // 4
        cancelAction.setValue(UIColor.red, forKey: "titleTextColor")
        
        optionMenu.addAction(action)
        optionMenu.addAction(cancelAction)
        
        
        // 5
        self.present(optionMenu, animated: true, completion: nil)
        
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
            secondVC.meal = viewModel.Popularmeals[selectedSpecial]
            secondVC.isPopOver = true
            secondVC.viewModel = self.viewModel
        case "toSubMenuMealsAndDrinks":
            let secondVC = segue.destination as! SubMenuMealsAndDrinksViewController
            secondVC.menu = selectedMenu
            secondVC.viewModel = self.viewModel
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
            cell.selectionStyle = .none
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
        let type = viewModel.choiceMenuTableViewCellTypes[indexPath.section][indexPath.row]
               switch type {
              
               case .MenuFood(_):
                tableView.deselectRow(at: indexPath, animated: true)
                performSegue(withIdentifier: "toMenu", sender: nil)
               case .MenuDrinks(_):
                tableView.deselectRow(at: indexPath, animated: true)
                performSegue(withIdentifier: "toMenu", sender: nil)
              default:
                return
        }
        
        
    }
    
    // set the height of the row based on the chosen cell
    func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let type = viewModel.choiceMenuTableViewCellTypes[indexPath.section][indexPath.row]
        switch type {
        case .MenuFood:
            return 150
        case .MenuSpecials:
            return 330
        case .MenuDrinks(_):
            return 150
        case .MenuHeader(_):
            return 120
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
