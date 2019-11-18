//
//  ChoiceMenuViewController.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 11/11/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit


class ChoiceMenuViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = ViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        // Do any additional setup after loading the view.
    }
    
    func setupTableView() {
        tableView.register(UINib(nibName: MealCollectionTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: MealCollectionTableViewCell.reuseIdentifier())
        tableView.register(UINib(nibName: ChoiceMenuHeaderTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: ChoiceMenuHeaderTableViewCell.reuseIdentifier())
        tableView.register(UINib(nibName: MenuSpecialsTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: MenuSpecialsTableViewCell.reuseIdentifier())
        tableView.register(UINib(nibName: HeaderForTableViewSection.nibName(), bundle: nil), forCellReuseIdentifier: HeaderForTableViewSection.reuseIdentifier())
        tableView.register(UINib(nibName: SubMenuTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: SubMenuTableViewCell.reuseIdentifier())
        tableView.showsHorizontalScrollIndicator = false
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
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
            
        case let .MenuFood(subMenu):
            let cell = tableView.dequeueReusableCell(withIdentifier: SubMenuTableViewCell.reuseIdentifier()) as! SubMenuTableViewCell
            //            cell.choiceName.text = choice.title
            //            cell.choiceDetail.text = choice.detail
            return cell
         
        case let .MenuDrinks(subMenu):
            let cell = tableView.dequeueReusableCell(withIdentifier: SubMenuTableViewCell.reuseIdentifier()) as! SubMenuTableViewCell
                       //            cell.choiceName.text = choice.title
                       //            cell.choiceDetail.text = choice.detail
          return cell
                    
        case .MenuSpecials:
            let cell = tableView.dequeueReusableCell(withIdentifier: MenuSpecialsTableViewCell.reuseIdentifier()) as! MenuSpecialsTableViewCell
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
            return 200
            
        case .MenuSpecials:
            return 300
        case .MenuDrinks(_):
            return 200
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch section {
        case 0:
            let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderForTableViewSectionID") as! HeaderForTableViewSection
            headerCell.sectionName.text = "Menu"
            return headerCell.contentView
        case 1:
            let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderForTableViewSectionID") as! HeaderForTableViewSection
            headerCell.sectionName.text = "Popular Eatries"
            return headerCell.contentView
        case 2:
                   let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderForTableViewSectionID") as! HeaderForTableViewSection
                   headerCell.sectionName.text = "Drinks"
                   return headerCell.contentView
        default:
            return nil
        }
    }
    
    func tableView(_: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 40
    }
    
    
    
    
    
    
}
