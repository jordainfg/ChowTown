//
//  RewardsViewController.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 10/12/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit
import SPStorkController
import SPLarkController

class RewardsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var redeemButton: DesignableButton!
    
    var viewModel = ViewModel()
    
    var refreshControl: UIRefreshControl!
    
    var subScriptionPlan : Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let subScriptionPlan = viewModel.selectedRestaurant?.subscriptionPlan {
            self.subScriptionPlan = subScriptionPlan
        }
        
        setupTableView()
        setUpView()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    func setupTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.register(UINib(nibName: HeaderForTableViewSection.nibName(), bundle: nil), forCellReuseIdentifier: HeaderForTableViewSection.reuseIdentifier())
        tableView.register(UINib(nibName: RewardsHeaderTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: RewardsHeaderTableViewCell.reuseIdentifier())
        tableView.register(UINib(nibName: RewardPrizeTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: RewardPrizeTableViewCell.reuseIdentifier())
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        tableView.register(UINib(nibName: RewardsLoginTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: RewardsLoginTableViewCell.reuseIdentifier())
        refreshControl = UIRefreshControl()
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refreshControlAction), for: .valueChanged)
        self.refreshControl.beginRefreshing()
    }
    func setUpView(){
        
        getRewardsData()
        navBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navBar.backgroundColor = UIColor.clear
        
        if FirebaseService.shared.authState == .isLoggedIn && subScriptionPlan > 1{
            redeemButton.alpha = 1
        }else{
            redeemButton.alpha = 0
        }
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        switch segue.identifier {
        case "presentAuthentication":
            let secondVC = segue.destination as! AuthenticationViewController
            secondVC.delegate = self
        case "toSettingsPane":
            let navController = segue.destination as! UINavigationController
            let secondVC = navController.topViewController as! SettingsViewController
            secondVC.delegate = self
        default:
            return
        }
        
        
    }
    
    
    func getRewardsData(){
        self.tableView.restore()
        
        if subScriptionPlan < 2 {
            self.tableView.setEmptyViewWithImage(title: "Oops", message: "This restaurant doesn't participate in our rewards program.", messageImage: #imageLiteral(resourceName: "appLogo"))
            self.refreshControl.endRefreshing()
            UIView.transition(with: self.tableView,
                              duration: 0.9,
                              options: .transitionCrossDissolve,
                              animations: { self.tableView.reloadData()
                                
            })
            
        } else {
            self.viewModel.getRewards {(result) in
                switch result{
                case .success:
                    UIView.transition(with: self.tableView,
                                      duration: 0.9,
                                      options: .transitionCrossDissolve,
                                      animations: { self.tableView.reloadData()
                                        
                    })
                    self.viewModel.getRewardPointsForRestaurant{ (result) in
                        switch result{
                        case .success:
                            UIView.transition(with: self.tableView,
                                              duration: 0.9,
                                              options: .transitionCrossDissolve,
                                              animations: { self.tableView.reloadData()
                                                self.redeemButton.alpha = 1
                            })
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9, execute: {
                                self.refreshControl.endRefreshing()
                            })
                        case let .failure(error):
                            UIView.transition(with: self.tableView,
                                              duration: 0.9,
                                              options: .transitionCrossDissolve,
                                              animations: { self.tableView.reloadData()
                                                
                            })
                            print("Error for getRewardPointsForRestaurant method:\(error)")
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9, execute: {
                                self.refreshControl.endRefreshing()
                            })
                        }
                        
                    }
                case let .failure(error):
                    self.tableView.reloadData()
                    self.tableView.setEmptyViewWithImage(title: "Oops", message: "Something went wrong, try again later or contact the developer in settings", messageImage: #imageLiteral(resourceName: "appLogo"))
                    print("Error for getRewards method:\(error)")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.9, execute: {
                        self.refreshControl.endRefreshing()
                    })
                }
                
            }
        }
        
    }
    
    
    @objc func refreshControlAction(refreshControl _: UIRefreshControl) {
        getRewardsData()
    }
    
    
}
extension RewardsViewController: UITableViewDataSource , UITableViewDelegate{
    
    
    func numberOfSections(in _: UITableView) -> Int {
        return viewModel.rewardsTableViewcellTypes.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rewardsTableViewcellTypes[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = viewModel.rewardsTableViewcellTypes[indexPath.section][indexPath.row]
        switch type {
        case .header:
            let cell = tableView.dequeueReusableCell(withIdentifier: RewardsHeaderTableViewCell.reuseIdentifier()) as! RewardsHeaderTableViewCell
            if let points = viewModel.rewardPoints?.rewardPoints{
                cell.points.text = points
            } else{
                cell.points.text = "0"
            }
            
            return cell
        case let .reward(reward):
            let cell = tableView.dequeueReusableCell(withIdentifier: RewardPrizeTableViewCell.reuseIdentifier()) as! RewardPrizeTableViewCell
            cell.name.text = reward.name
            cell.points.text = reward.points
            cell.isUserInteractionEnabled = false
            return cell
        case .login:
            let cell = tableView.dequeueReusableCell(withIdentifier: RewardsLoginTableViewCell.reuseIdentifier()) as! RewardsLoginTableViewCell
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type = viewModel.rewardsTableViewcellTypes[indexPath.section][indexPath.row]
        switch type {
        case .header:
            return
        case .reward(_):
            return
        case .login:
            performSegue(withIdentifier: "presentAuthentication", sender: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let type = viewModel.rewardsTableViewcellTypes[indexPath.section][indexPath.row]
        switch type {
            
        case .login:
            return UITableView.automaticDimension
        default:
            return UITableView.automaticDimension
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
            
        case 1:
            let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderForTableViewSectionID") as! HeaderForTableViewSection
            headerCell.sectionName.text = "Badges add up to Rewards"
            headerCell.sectionName.textColor = UIColor.label
            headerCell.sectionName.font.withSize(16)
            return headerCell.contentView
            
        default:
            return nil
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 1:
            return 45
        default:
            return 20
        }
        
    }
    
}


extension RewardsViewController : AuthenticationDelegate{
    func didCreateSuccessfully(isTrue: Bool) {
        
    }
    
    func didAuthenticateSuccessfully(isTrue: Bool) {
        if isTrue {
            getRewardsData()
            
        } else {
            
        }
    }
    
    func didLogout() {
        UIView.transition(with: self.tableView,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: { self.tableView.reloadData()
                            self.redeemButton.alpha = 0
        })
        
        
    }
    
    
}
