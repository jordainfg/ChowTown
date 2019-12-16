//
//  SpecialsDetailViewController.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 31/10/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit
import Hero
import FirebaseUI


class SpecialsDetailViewController: UIViewController {
    
    var viewModel = ViewModel()
    var meal : Meal?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    var headerView: UIView!
    var specialHeroID = 0
    var kTableHeaderHeight:CGFloat = 300.0
    let placeholderImage = UIImage(named: "")
    var httpsReference :  StorageReference?
    var isPopOver = false
    override func viewDidLoad() {
        super.viewDidLoad()
       // imageView.hero.id = "specialHeroID\(specialHeroID)"
        
        //needs optimizing
        httpsReference =   viewModel.storage.reference(forURL: meal!.imageRef)
        imageView.sd_setImage(with: httpsReference!, placeholderImage: placeholderImage)
        //
        setUpView()
        setupTableView()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func setUpView(){
        
        tableView.rowHeight = UITableView.automaticDimension
        
        headerView = tableView.tableHeaderView
        tableView.tableHeaderView = nil
        tableView.addSubview(headerView)
        tableView.contentInset = UIEdgeInsets(top: kTableHeaderHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -kTableHeaderHeight)
        updateHeaderView()
        
        //  for ios 13
        
        
        
//        if isPopOver{
//            let button = UIButton(frame: CGRect(x: 20, y: 55, width: 35, height: 35))
//            button.setBackgroundImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
//            button.tintColor = .white
//            button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
//            button.hero.id = "specialHeroID\(specialHeroID)"
//            self.view.addSubview(button)
//        }
        
    }
    func setupTableView() {
        tableView.register(UINib(nibName: MealHeaderTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: MealHeaderTableViewCell.reuseIdentifier())
        tableView.register(UINib(nibName: NutritionInformationTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: NutritionInformationTableViewCell.reuseIdentifier())
        tableView.register(UINib(nibName: IconsTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: IconsTableViewCell.reuseIdentifier())
        tableView.register(UINib(nibName: AddOnTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: AddOnTableViewCell.reuseIdentifier())
        tableView.register(UINib(nibName: HeaderForSectionTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: HeaderForSectionTableViewCell.reuseIdentifier())
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
            
        
            
        case .nutritionInfo:
            let cell = tableView.dequeueReusableCell(withIdentifier: NutritionInformationTableViewCell.reuseIdentifier()) as! NutritionInformationTableViewCell
            
            return cell
        case let .aboutIconSet(name):
            let cell = tableView.dequeueReusableCell(withIdentifier: IconsTableViewCell.reuseIdentifier()) as! IconsTableViewCell
            
            cell.iCons = meal?.about as! [Int]
            return cell
            
        case let .alergenIconSet(name):
            let cell = tableView.dequeueReusableCell(withIdentifier: IconsTableViewCell.reuseIdentifier()) as! IconsTableViewCell
            
            cell.iCons = meal?.allergens as! [Int]
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
        case .nutritionInfo:
            return 100
        case .alergenIconSet:
            return  70
        case .aboutIconSet(_):
            return 70
        case .addOns(_):
            return 40
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateHeaderView()
    }
    
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderForSectionTableViewCellID") as! HeaderForSectionTableViewCell
        switch section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: MealHeaderTableViewCell.reuseIdentifier()) as! MealHeaderTableViewCell
                      cell.specialHeaderView.hero.id = "specialHeaderViewHeroID\(specialHeroID)"
                      cell.specialName.hero.id =  "specialNameHeroID\(specialHeroID)"
                      cell.specialSubTitle.hero.id = "specialDetailHeroID\(specialHeroID)"
                      cell.configure(meal: meal!)
                      cell.indentationLevel = 2;
                      return cell
        case 1:
            headerCell.label.text = "NUTRITION INFORMATION"
            return headerCell
        case 2:
            headerCell.label.text = "About"
            return headerCell
        case 3:
            headerCell.label.text = "Alergens"
            return headerCell
        case 4:
            headerCell.label.text = "Addons"
            return headerCell
        default:
            
             return headerCell
            
        }
    }
    
//    func tableView(_: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        switch section {
//        case 0:
//            return 130
//        case 1:
//            return 40
//        default:
//            return 40
//        }
//    }
    
    
    
    
    
    
}
