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
    var tableViewcellTypes: [[RestaurantDataType]] {
        let types: [[RestaurantDataType]] = [[.header("Anne&MAX", "Sandwiches - Panini - Biologishe Koffie & Thee - Salades - Speltmuesli. Anne&Max de freshfood&coffeecafe. Elke dag ontbijt, koffie, lunch, high tea en borrel. Gratis WiFi. Van ontbijt tot borrel. Vers & Gezonde producten."),.address("Kerkplein 4, 2513 AZ Den Haag"),.hours("11:00-13:00"),.phone("0638482215"),.emailAddress("email@email"),.website("Gijsbertha.com"),]]
        
        return types
    }
    
    var headerHeight : CGFloat?
    var headerView: UIView!
    var kTableHeaderHeight:CGFloat = 300.0
    
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
        //        tableView.register(UINib(nibName: MeetingInfoDatePickerTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: MeetingInfoDatePickerTableViewCell.reuseIdentifier())
        //        tableView.register(UINib(nibName: "HeaderForTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderCellIdentifier")
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
    // set the height of the row based on the chosen cell
    func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let type = tableViewcellTypes[indexPath.section][indexPath.row]
        let heightForIcons = CGFloat(50)
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
