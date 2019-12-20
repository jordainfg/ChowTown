//
//  RestaurantIViewController.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 25/11/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit

enum RestaurantDataType {
    case header(String,String)
    case address(String)
    case emailAddress(String)
    case hours(String)
    case phone(String)
    case website(String)
    case social
    
}

class RestaurantViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    var viewModel = ViewModel()
    var restaurant : Restaurant?
    
    var tableViewcellTypes: [[RestaurantDataType]] {
        let types: [[RestaurantDataType]] = [[.header(restaurant?.name ?? "No info",restaurant?.about ?? "No info"),.address(restaurant?.address ?? "No info"),.hours(restaurant?.hours ?? "No info"),.phone(restaurant?.phone ?? "No info"),.emailAddress(restaurant?.emailAddress ?? "No info"),.website(restaurant?.websiteURL ?? "No info")]]
        
        return types
    }
    
    var headerHeight : CGFloat?
    var headerView: UIView!
    var kTableHeaderHeight:CGFloat = UIScreen.main.bounds.height / 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setupTableView()
    }
    
    func setUpView(){
        tableView.rowHeight = UITableView.automaticDimension
        headerView = tableView.tableHeaderView
        tableView.tableHeaderView = nil
        tableView.addSubview(headerView)
        tableView.contentInset = UIEdgeInsets(top: kTableHeaderHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -kTableHeaderHeight)
        updateHeaderView()
         
        // Dismiss view button
        let button = UIButton(frame: CGRect(x: 20, y: 55, width: 30, height: 30))
        button.setBackgroundImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.tintColor = UIColor.white
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(button)
        
        //add header image
        let httpsReference =   viewModel.storage.reference(forURL: restaurant?.imageRefrence ?? "gs://chow-town-bc783.appspot.com/Meals/43690812_260822031257663_7880763896869087864_n.jpg")
         imageView.sd_setImage(with: httpsReference)
    }
    func updateHeaderView() {
        
        var headerRect = CGRect(x: 0, y: -kTableHeaderHeight, width: tableView.bounds.width, height: kTableHeaderHeight)
        if tableView.contentOffset.y < -kTableHeaderHeight {
            headerRect.origin.y = tableView.contentOffset.y
            headerRect.size.height = -tableView.contentOffset.y
        }
        
        headerView.frame = headerRect
    }
    
    func setupTableView() {
        
        tableView.register(UINib(nibName: RestaurantAboutTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: RestaurantAboutTableViewCell.reuseIdentifier())
        tableView.register(UINib(nibName: iconWithLabelTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: iconWithLabelTableViewCell.reuseIdentifier())
        self.tableView.tableFooterView = UIView()
    }
    @objc func buttonAction(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Segues
    
    @IBAction func menuButtonPressed(_ sender: Any) {
        if restaurant != nil {
            UserDefaults.standard.set(restaurant?.restID, forKey: "selectedRestaurant")
            viewModel.selectedRestaurant = restaurant
            performSegue(withIdentifier: "toMenu", sender: nil)
        }
        
        
    }
   
    // passing data to tab bar viewcontroller and then to navigation controller and then to the final view controller
    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
          if let barVC = segue.destination as? UITabBarController {
              barVC.viewControllers?.forEach {
                  if let vc = $0 as? UINavigationController {
                    if let vcc = vc.viewControllers[0] as? HomePageMenuViewController {
                        vcc.viewModel = self.viewModel
                    }
                      
                  }
              }
          }
    }
    
   
    
    
}
extension RestaurantViewController : UITableViewDataSource , UITableViewDelegate{
    
    func numberOfSections(in _: UITableView) -> Int {
        return tableViewcellTypes.count
    }
    
    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewcellTypes[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = tableViewcellTypes[indexPath.section][indexPath.row]
        
        switch type {
        case let .header(name, about):
            let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantAboutTableViewCell.reuseIdentifier()) as! RestaurantAboutTableViewCell
            cell.name.text = name
            cell.about.text = about
            headerHeight = cell.stackView.bounds.height
            return cell
        case let .address(address):
            let cell = tableView.dequeueReusableCell(withIdentifier: iconWithLabelTableViewCell.reuseIdentifier()) as! iconWithLabelTableViewCell
            cell.label.text = address
            cell.icon.image = UIImage(systemName: "location.fill")
            return cell
        case let .emailAddress(emailAddress):
            let cell = tableView.dequeueReusableCell(withIdentifier: iconWithLabelTableViewCell.reuseIdentifier()) as! iconWithLabelTableViewCell
            cell.label.text = emailAddress
            cell.icon.image = UIImage(systemName: "link")
            return cell
        case let .hours(hours):
            let cell = tableView.dequeueReusableCell(withIdentifier: iconWithLabelTableViewCell.reuseIdentifier()) as! iconWithLabelTableViewCell
            cell.label.text = hours
            cell.icon.image = UIImage(systemName: "clock.fill")
            return cell
        case let .phone(phone):
            let cell = tableView.dequeueReusableCell(withIdentifier: iconWithLabelTableViewCell.reuseIdentifier()) as! iconWithLabelTableViewCell
            cell.label.text = phone
            cell.icon.image = UIImage(systemName: "phone.fill")
            return cell
        case let .website(website):
            let cell = tableView.dequeueReusableCell(withIdentifier: iconWithLabelTableViewCell.reuseIdentifier()) as! iconWithLabelTableViewCell
            cell.label.text = website
            cell.icon.image = UIImage(systemName: "link.circle.fill")
            return cell
        case .social:
            let cell = tableView.dequeueReusableCell(withIdentifier: iconWithLabelTableViewCell.reuseIdentifier()) as! iconWithLabelTableViewCell
            
            cell.icon.image = UIImage(systemName: "link")
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type = tableViewcellTypes[indexPath.section][indexPath.row]
        switch type {
            
        case .header:
            tableView.deselectRow(at: indexPath, animated: true)
        case .address:
            tableView.deselectRow(at: indexPath, animated: true)
        case .emailAddress:
            tableView.deselectRow(at: indexPath, animated: true)
        case .hours:
            tableView.deselectRow(at: indexPath, animated: true)
        case .phone:
            tableView.deselectRow(at: indexPath, animated: true)
        case .website:
            tableView.deselectRow(at: indexPath, animated: true)
        case .social:
            tableView.deselectRow(at: indexPath, animated: true)
            
        }
    }
    // set the height of the row based on the chosen cell
    func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let type = tableViewcellTypes[indexPath.section][indexPath.row]
        let heightForIcons = CGFloat(55)
        switch type {
            
        case .header:
            return headerHeight ?? 60
        case .address:
            return heightForIcons
        case .emailAddress:
            return heightForIcons
        case .hours:
            return heightForIcons
        case .phone:
            return heightForIcons
        case .website:
            return heightForIcons
        case .social:
            return heightForIcons
            
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateHeaderView()
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    //
    
    
    
}
