//
//  SpecialsDetailViewController.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 31/10/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit
import Hero



class SpecialsDetailViewController: UIViewController {
  
    let viewModel = ViewModel()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    var headerView: UIView!
    var specialHeroID = 0
    var kTableHeaderHeight:CGFloat = 300.0
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.hero.id = "specialHeroID\(specialHeroID)"
        //imageView.roundCornerss([.bottomLeft, .bottomRight], radius: 18)
        setUpView()
        setupTableView()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    func setUpView(){
        
        tableView.rowHeight = UITableView.automaticDimension
        
        headerView = tableView.tableHeaderView
        tableView.tableHeaderView = nil
        tableView.addSubview(headerView)
        tableView.contentInset = UIEdgeInsets(top: kTableHeaderHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -kTableHeaderHeight)
        updateHeaderView()
        
        let button = UIButton(frame: CGRect(x: 20, y: 55, width: 35, height: 35))
        button.setBackgroundImage(UIImage(systemName: "arrow.left.circle.fill"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(button)
    }
    func setupTableView() {
        tableView.register(UINib(nibName: MealHeaderTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: MealHeaderTableViewCell.reuseIdentifier())
        tableView.register(UINib(nibName: NutritionInformationTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: NutritionInformationTableViewCell.reuseIdentifier())
        tableView.register(UINib(nibName: IconsTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: IconsTableViewCell.reuseIdentifier())
               tableView.register(UINib(nibName: AddOnTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: AddOnTableViewCell.reuseIdentifier())
    }
    
    func updateHeaderView() {
        
        var headerRect = CGRect(x: 0, y: -kTableHeaderHeight, width: tableView.bounds.width, height: kTableHeaderHeight)
        if tableView.contentOffset.y < -kTableHeaderHeight {
            headerRect.origin.y = tableView.contentOffset.y
            headerRect.size.height = -tableView.contentOffset.y
        }
        
        headerView.frame = headerRect
    }
    
    
    @objc func buttonAction(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            hero.dismissViewController()
            
        case .changed:
            let translation = sender.translation(in: nil)
            let progress = translation.y / 2 / view.bounds.height
            Hero.shared.update(progress)
            //                   let currentPos = CGPoint(x:translation.x + imageView.center.x , y: translation.y + imageView.center.y)
        //                   Hero.shared.apply(modifiers: [.position(currentPos)], to: imageView)
        default:
            Hero.shared.finish()
        }
    }
    
    
    
    @IBAction func pressed(_ sender: UIPanGestureRecognizer) {
        
        switch sender.state {
        case .began:
            hero.dismissViewController()
            
        case .changed:
            let translation = sender.translation(in: nil)
            let progress = translation.y / 2 / view.bounds.height
            Hero.shared.update(progress)
            //                let currentPos = CGPoint(x:translation.x + imageView.center.x , y: translation.y + imageView.center.y)
        //                Hero.shared.apply(modifiers: [.position(currentPos)], to: imageView)
        default:
            Hero.shared.finish()
        }
    }
}

extension SpecialsDetailViewController : UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let type = viewModel.mealDetailTableViewcellTypes[indexPath.section][indexPath.row]
        
        switch type {
            
            
        case .header:
            let cell = tableView.dequeueReusableCell(withIdentifier: MealHeaderTableViewCell.reuseIdentifier()) as! MealHeaderTableViewCell
            
            cell.specialName.hero.id =  "specialNameHeroID\(specialHeroID)"
            cell.specialSubTitle.hero.id = "specialDetailHeroID\(specialHeroID)"
            cell.indentationLevel = 2;
            return cell
            
        case .nutritionInfo:
            let cell = tableView.dequeueReusableCell(withIdentifier: NutritionInformationTableViewCell.reuseIdentifier()) as! NutritionInformationTableViewCell
            
            return cell
        case let .aboutIconSet(name):
        let cell = tableView.dequeueReusableCell(withIdentifier: IconsTableViewCell.reuseIdentifier()) as! IconsTableViewCell
        cell.iconSetName.text = name
        cell.iCons = [23,20,21,22]
        return cell
            
        case let .alergenIconSet(name):
             let cell = tableView.dequeueReusableCell(withIdentifier: IconsTableViewCell.reuseIdentifier()) as! IconsTableViewCell
                   cell.iconSetName.text = name
                   cell.iCons = [1,2,3,4,5,6,7,8,9]
                   return cell
        case .addOns(_):
            let cell = tableView.dequeueReusableCell(withIdentifier: AddOnTableViewCell.reuseIdentifier()) as! AddOnTableViewCell
                       
               
                       return cell
        }
        
    }
    
    
    func numberOfSections(in _: UITableView) -> Int {
        return viewModel.mealDetailTableViewcellTypes.count
    }
    
    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.mealDetailTableViewcellTypes[section].count
    }
    
    //    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //        let type = types[indexPath.section][indexPath.row]
    //
    //        switch type {
    ////
    //
    //        case .header:
    //            return
    //        @unknown default:
    //            <#code#>
    //        }
    //    }
    // set the height of the row based on the chosen cell
    
    func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       let type = viewModel.mealDetailTableViewcellTypes[indexPath.section][indexPath.row]
        
        switch type {
            
            
        case .header:
            
            return 100
            
        case .nutritionInfo:
          
            
            return 220
        case .alergenIconSet:
          return  100
        case .aboutIconSet(_):
            return 100
        case .addOns(_):
           return 40
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateHeaderView()
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 1:
            return "Additions"
        default:
            break
        }
        return ""
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    //    
    //    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //      //  let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCellIdentifier") as! HeaderForTableViewCell
    //        switch section {
    //       
    //        default:
    //            
    //        }
    //    }
    
    //    func tableView(_: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    ////        switch section {
    //////        case 0:
    //////            return 44
    //////        case 1:
    //////            return 1
    //////        default:
    //////            return 0
    ////        }
    //    }
    
    
    
    
    
    
}
