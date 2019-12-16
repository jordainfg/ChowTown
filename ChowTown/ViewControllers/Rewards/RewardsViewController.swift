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
    @IBOutlet weak var imageView: UIImageView!
    var headerView: UIView!
    var kTableHeaderHeight:CGFloat = 170
    let viewModel = ViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
    }
    
    func setupTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        headerView = tableView.tableHeaderView
        tableView.tableHeaderView = nil
        tableView.addSubview(headerView)
        tableView.contentInset = UIEdgeInsets(top: kTableHeaderHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -kTableHeaderHeight)
        
        
        updateHeaderView()
        
        tableView.register(UINib(nibName: HeaderForTableViewSection.nibName(), bundle: nil), forCellReuseIdentifier: HeaderForTableViewSection.reuseIdentifier())
        tableView.register(UINib(nibName: RewardsHeaderTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: RewardsHeaderTableViewCell.reuseIdentifier())
        tableView.register(UINib(nibName: RewardPrizeTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: RewardPrizeTableViewCell.reuseIdentifier())
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        tableView.register(UINib(nibName: RewardsLoginTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: RewardsLoginTableViewCell.reuseIdentifier())
        //            tableView.register(UINib(nibName: "HeaderForTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderCellIdentifier")
       
    }
    func updateHeaderView() {
        
        var headerRect = CGRect(x: 0, y: -kTableHeaderHeight, width: tableView.bounds.width, height: kTableHeaderHeight)
        if tableView.contentOffset.y < -kTableHeaderHeight {
            headerRect.origin.y = tableView.contentOffset.y
            headerRect.size.height = -tableView.contentOffset.y
        }
        
        headerView.frame = headerRect
    }
    
    @IBAction func testButtonPressed(_ sender: Any) {
       
        
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
            return cell
        case .reward(_):
            let cell = tableView.dequeueReusableCell(withIdentifier: RewardPrizeTableViewCell.reuseIdentifier()) as! RewardPrizeTableViewCell
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
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateHeaderView()
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
            headerCell.sectionName.textColor = UIColor.black
            headerCell.sectionName.font.withSize(18)
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
            return 0
        }
        
    }
    
}
