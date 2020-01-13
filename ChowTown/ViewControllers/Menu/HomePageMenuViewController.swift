//
//  ChoiceMenuViewController.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 11/11/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit
import NotificationBannerSwift
import SPAlert
import Firebase

class HomePageMenuViewController: UIViewController,MyCustomCellDelegator {
    
    // MARK: - Variables
    var viewModel = ViewModel()
    var selectedSpecial = 0
    var selectedMenu : Menu?
    var subScriptionPan = 0 
    
    let banner = NotificationBanner(customView: reloadView(frame: .zero))
    var isFavorite = true
    
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - ViewDidLoad, Apear, Desapear
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  viewModel.favoriteRestaurant()
       // viewModel.addMenu()
        setupTableView()
        banner.bannerHeight = 120
        getMenusAndSpecials()
        setupView()
       // print("TT\(viewModel.selectedRestaurant )" )
        
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
        if let _ = viewModel.favoriteRestaurants.first(where: {$0.restID == viewModel.selectedRestaurant?.restID}) {
               isFavorite = true
               
              
            } else {
               isFavorite = false
               //item could not be found
            }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.setValue(false, forKey: "hidesShadow")
    }
    
    
    func notificationButtonPressed(rest : Restaurant) {
        var text = ["add","to"]
         
        if isFavorite{
           
            text = ["remove","from"]
          
        } else if !isFavorite{
            text  = ["add","to"]
           //item could not be found
        }

        // 1
        let optionMenu = UIAlertController(title: "Notification preferences", message: "Would you like \(text[0]) this restaurant \(text[1]) your favorites?", preferredStyle: .actionSheet)
        
        // 2 Add to favorites
        let addRestaurantToFavoritesAction = UIAlertAction(title: "Yes", style: .default, handler: {(alert: UIAlertAction!) in
            self.viewModel.favoriteRestaurant(rest: rest, notificationsAreEnabeld: true) { result in
                switch result{
                case .success:
                    Messaging.messaging().subscribe(toTopic: rest.messagingTopic) { error in
                      print("Subscribed \(rest.messagingTopic)")
                    }
                    let alertView = SPAlertView(title: "\(rest.name) was added to your favorites", message: nil, preset: SPAlertPreset.star)
                    alertView.duration = 3
                    alertView.present()
                    alertView.haptic = .success
                    self.isFavorite = true
                    self.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
                case .failure:
                    let alertView = SPAlertView(title: "Try again later", message: nil, preset: SPAlertPreset.exclamation)
                                       alertView.duration = 3
                    alertView.haptic = .success
                                       alertView.present()
                    //SPAlert.present(title: "Try again later", preset: .exclamation)
                }
            }

            self.dismiss(animated: true, completion: nil)
        })
        
        
        // MARK: - remove from favorites
               let removeRestaurantFromFavoritesAction = UIAlertAction(title: "Yes", style: .default, handler: {(alert: UIAlertAction!) in
                   self.viewModel.deleteFavoriteRestaurant(rest: rest) { result in
                       switch result{
                       case .success:
                        Messaging.messaging().unsubscribe(fromTopic: rest.messagingTopic) { error in
                             print("UnSubscribed \(rest.messagingTopic)")
                           }
                           let alertView = SPAlertView(title: "\(rest.name) was removed from you favorites", message: nil, preset: SPAlertPreset.done)
                           alertView.duration = 3
                           alertView.present()
                           alertView.haptic = .success
                        self.isFavorite = false
                        self.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
                       case .failure:
                           let alertView = SPAlertView(title: "Try again later", message: nil, preset: SPAlertPreset.exclamation)
                                              alertView.duration = 3
                           alertView.haptic = .success
                                              alertView.present()
                           //SPAlert.present(title: "Try again later", preset: .exclamation)
                       }
                   }

                   self.dismiss(animated: true, completion: nil)
               })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {(alert: UIAlertAction!) in
            optionMenu.dismiss(animated: true, completion: nil)
        })
        // 4
        cancelAction.setValue(UIColor.red, forKey: "titleTextColor")
        
        
         if isFavorite{
             optionMenu.addAction(removeRestaurantFromFavoritesAction)
            }
            
         else {
            optionMenu.addAction(addRestaurantToFavoritesAction)
           //item could not be found
        }
       
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
            viewModel.selectedMenu = selectedMenu
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
            
        case let .MenuHeader(rest):
            let cell = tableView.dequeueReusableCell(withIdentifier: SubMenuHeaderTableViewCell.reuseIdentifier()) as! SubMenuHeaderTableViewCell
             let storageRefrence = viewModel.storage.reference(forURL: rest.logoURL )
             cell.headerimageView.sd_setImage(with: storageRefrence)
            cell.name.text = rest.name
            cell.address.text = rest.address
            cell.selectionStyle = .none
            if rest.subscriptionPlan < 3 || FirebaseService.shared.authState == .isLoggedOut  {
              cell.notificationButton.isHidden = true
            } else if rest.subscriptionPlan == 3 && FirebaseService.shared.authState == .isLoggedIn{
                 if isFavorite{
                     cell.notificationButton.isHidden = false
                     cell.notificationButton.image = UIImage(systemName: "star.fill")
                            
                 } else  {
                    cell.notificationButton.isHidden = false
                    cell.notificationButton.image = UIImage(systemName: "star")
                           
            }
              
              
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type = viewModel.choiceMenuTableViewCellTypes[indexPath.section][indexPath.row]
               switch type {
               case let .MenuHeader(restaurant):
                notificationButtonPressed(rest: restaurant)
               tableView.deselectRow(at: indexPath, animated: true)
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
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
            case 0:
            let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderForTableViewSectionID") as! HeaderForTableViewSection
            headerCell.sectionName.text = "About"
            return headerCell.contentView
            
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
        
        return 40
    }
    
    
}
