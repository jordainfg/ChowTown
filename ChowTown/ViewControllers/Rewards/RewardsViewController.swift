//
//  RewardsViewController.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 18/11/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit

class RewardsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let viewModel = ViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
       
        // Do any additional setup after loading the view.
    }
    func setupTableView() {
        tableView.register(UINib(nibName: RewardsHeaderTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: RewardsHeaderTableViewCell.reuseIdentifier())
        setUpNavBar()
        tableView.layer.cornerRadius = 30 //set corner radius here
      
        
          //  tableView.layer.backgroundColor = UIColor.clear
        //        tableView.register(UINib(nibName: MeetingInfoDatePickerTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: MeetingInfoDatePickerTableViewCell.reuseIdentifier())
        //        tableView.register(UINib(nibName: "HeaderForTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderCellIdentifier")
    }
    
    func setUpNavBar(){
        if #available(iOS 13.0, *) {
                    let navBarAppearance = UINavigationBarAppearance()
                    navBarAppearance.configureWithOpaqueBackground()
                    navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
                    navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
                   navBarAppearance.backgroundColor = UIColor.systemIndigo
                   navBarAppearance.shadowImage = UIImage()
                   navBarAppearance.shadowColor = UIColor.clear

                    self.navigationController?.navigationBar.standardAppearance = navBarAppearance
                    self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
                  
                }
    }
  
    
}
extension RewardsViewController : UITableViewDataSource , UITableViewDelegate{
    
    func numberOfSections(in _: UITableView) -> Int {
        return viewModel.rewardsTableViewcellTypes.count
    }
    
    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rewardsTableViewcellTypes[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = viewModel.rewardsTableViewcellTypes[indexPath.section][indexPath.row]
        
        switch type {
            
        case .header:
            let cell = tableView.dequeueReusableCell(withIdentifier: RewardsHeaderTableViewCell.reuseIdentifier()) as! RewardsHeaderTableViewCell
            return cell
        case .reward:
            let cell = tableView.dequeueReusableCell(withIdentifier: RewardsHeaderTableViewCell.reuseIdentifier()) as! RewardsHeaderTableViewCell
           return cell
   
        }
    }
    // set the height of the row based on the chosen cell
    func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let type = viewModel.rewardsTableViewcellTypes[indexPath.section][indexPath.row]
        switch type {
            
        case .header:
            return 250
        case .reward:
            return 200
        @unknown default:
            return 0
        }
    }
    
    //    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //      //  let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCellIdentifier") as! HeaderForTableViewCell
    //        switch section {
    //
    //        default:
    //
    //        }
    //    }
    //
    //    func tableView(_: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    //        switch section {
    ////        case 0:
    ////            return 44
    ////        case 1:
    ////            return 1
    ////        default:
    ////            return 0
    //        }
    //    }
    
    
    
}
extension UIViewController {
func configureNavigationBar(largeTitleColor: UIColor, backgoundColor: UIColor, tintColor: UIColor, title: String, preferredLargeTitle: Bool) {
    if #available(iOS 13.0, *) {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: largeTitleColor]
        navBarAppearance.titleTextAttributes = [.foregroundColor: largeTitleColor]
        navBarAppearance.backgroundColor = backgoundColor

        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.compactAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        navigationController?.navigationBar.prefersLargeTitles = preferredLargeTitle
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = tintColor
        navigationItem.title = title

    } else {
        // Fallback on earlier versions
        navigationController?.navigationBar.barTintColor = backgoundColor
        navigationController?.navigationBar.tintColor = tintColor
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.title = title
    }
}}
