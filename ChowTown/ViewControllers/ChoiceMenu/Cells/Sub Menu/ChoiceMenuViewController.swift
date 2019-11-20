//
//  ChoiceMenuViewController.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 11/11/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit


class ChoiceMenuViewController: UIViewController,MyCustomCellDelegator {
    
    
    var selectedSpecial = 0
    
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = ViewModel()
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
//setupUI()
        // Do any additional setup after loading the view.
    }
    
    
 
    func setupTableView() {
        tableView.register(UINib(nibName: MealCollectionTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: MealCollectionTableViewCell.reuseIdentifier())
        tableView.register(UINib(nibName: ChoiceMenuHeaderTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: ChoiceMenuHeaderTableViewCell.reuseIdentifier())
        tableView.register(UINib(nibName: MenuSpecialsTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: MenuSpecialsTableViewCell.reuseIdentifier())
        tableView.register(UINib(nibName: HeaderForTableViewSection.nibName(), bundle: nil), forCellReuseIdentifier: HeaderForTableViewSection.reuseIdentifier())
        tableView.register(UINib(nibName: SubMenuTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: SubMenuTableViewCell.reuseIdentifier())
        tableView.register(UINib(nibName: SubMenuHeaderTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: SubMenuHeaderTableViewCell.reuseIdentifier())
        tableView.showsHorizontalScrollIndicator = false
    }
    
    // MARK: - Segue methods
    func callSegueFromCell(segueIdentifier: String, index : Int) {
        selectedSpecial = index
        self.performSegue(withIdentifier: segueIdentifier, sender: nil )
    }
    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        switch segue.identifier {
        case "toMeal":
            let secondVC = segue.destination as! SpecialsDetailViewController
            secondVC.specialHeroID = selectedSpecial
            //        case "":
            //
            //        case "":
            //
            //
            //        case "":
            
        default:
            return
        }
    }
    
}
extension ChoiceMenuViewController : UITableViewDataSource , UITableViewDelegate{
    
    func numberOfSections(in _: UITableView) -> Int {
        return viewModel.choiceMenuTableViewCellTypes.count
    }
    
    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.choiceMenuTableViewCellTypes[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = viewModel.choiceMenuTableViewCellTypes[indexPath.section][indexPath.row]
        
        switch type {
            
        case .MenuSpecials:
            let cell = tableView.dequeueReusableCell(withIdentifier: MenuSpecialsTableViewCell.reuseIdentifier()) as! MenuSpecialsTableViewCell
            cell.delegate = self
            
            return cell
        case let .MenuFood(foodMenus):
            let cell = tableView.dequeueReusableCell(withIdentifier: SubMenuTableViewCell.reuseIdentifier()) as! SubMenuTableViewCell
            cell.Menus = foodMenus
            cell.tint = UIColor.white
            cell.collectionView.reloadData()
            cell.delegate = self
            return cell
            
        case let .MenuDrinks(drinkMenu):
            let cell = tableView.dequeueReusableCell(withIdentifier: SubMenuTableViewCell.reuseIdentifier()) as! SubMenuTableViewCell
            cell.Menus = drinkMenu
            cell.tint = UIColor.white
            cell.collectionView.reloadData()
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
