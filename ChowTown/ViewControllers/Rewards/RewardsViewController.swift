//
//  RewardsViewController.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 10/12/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit



class RewardsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    var headerView: UIView!
    var kTableHeaderHeight:CGFloat = 200.0
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
        
        tableView.register(UINib(nibName: RewardCardTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: RewardCardTableViewCell.reuseIdentifier())
        tableView.register(UINib(nibName: RewardsHeaderTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: RewardsHeaderTableViewCell.reuseIdentifier())
        tableView.register(UINib(nibName: RewardPointsTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: RewardPointsTableViewCell.reuseIdentifier())
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        //            tableView.register(UINib(nibName: MeetingInfoDatePickerTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: MeetingInfoDatePickerTableViewCell.reuseIdentifier())
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
        case .rewardPoints:
            let cell = tableView.dequeueReusableCell(withIdentifier: RewardPointsTableViewCell.reuseIdentifier()) as! RewardPointsTableViewCell
            return cell
            
        case .rewardCard:
            let cell = tableView.dequeueReusableCell(withIdentifier: RewardCardTableViewCell.reuseIdentifier()) as! RewardCardTableViewCell
            return cell
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateHeaderView()
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}
