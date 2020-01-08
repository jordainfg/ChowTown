//
//  ChoiceMenuViewController.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 11/11/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit
import NotificationBannerSwift

class HomePageMenuViewController: UIViewController,MyCustomCellDelegator , BannerColorsProtocol{
    func color(for style: BannerStyle) -> UIColor {
        return UIColor.red
    }
    
    
    // MARK: - Variables
    var viewModel = ViewModel()
    var selectedSpecial = 0
    var selectedMenu : Menu?
    let banner = NotificationBanner(customView: reloadView(frame: .zero))
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - ViewDidLoad, Apear, Desapear
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  viewModel.favoriteRestaurant()
        setupTableView()
        banner.bannerHeight = 120
        getMenusAndSpecials()
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
        self.navigationController?.navigationBar.backgroundColor = nil
         self.navigationController?.navigationBar.shadowImage = nil
        
        self.banner.onTap = {
                                // Do something regarding the banner
            self.getMenusAndSpecials()
                            }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //sets nav bar to default appearance
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = nil
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = nil
        navigationController?.navigationBar.barTintColor = nil
        self.navigationController?.navigationBar.setValue(false, forKey: "hidesShadow")
    }
    
    
    @IBAction func changeLocationButtonPressed(_ sender: Any) {
        // 1
        let optionMenu = UIAlertController(title: nil, message: "Would you change the menu?", preferredStyle: .actionSheet)
        
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
        // passing data to tab bar viewcontroller and then to navigation controller and then to the final view controller
       
        
    }
    
    func getMenusAndSpecials() {
           if UserDefaults.standard.string(forKey: "selectedRestaurant") != nil{
               viewModel.getMenus(forRestaurant: UserDefaults.standard.string(forKey: "selectedRestaurant")!) {
                self.viewModel.getPopularMeals{ (result) in
                       switch result {
                       case .success:
                           UIView.transition(with: self.tableView,
                                             duration: 0.5,
                                             options: .transitionCrossDissolve,
                                             animations: { self.tableView.reloadData() })
                       case .failure:
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                            //  self.refreshControl.endRefreshing()
                              self.banner.show()
                        })
                        
                       }
                       
                   }
               }
               
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
            let storageRefrence = viewModel.storage.reference(forURL: viewModel.selectedRestaurant!.logoURL )
            cell.logoImageView.sd_setImage(with: storageRefrence, placeholderImage: UIImage(named: "placeHolder"))
                  
//             imageView.sd_setImage(with: httpsReference)
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
            headerCell.sectionName.text = "Popular"
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
        if section == 0 { return 20 } 
        return 40
    }
    
    
}
