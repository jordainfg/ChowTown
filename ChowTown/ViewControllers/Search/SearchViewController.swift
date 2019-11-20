//
//  SearchViewController.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 15/11/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    let viewModel = ViewModel()
    
    var filterdEstablishments : [Establishment]?
    
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navBar: UINavigationBar!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterdEstablishments =  viewModel.establishments
        setUpTableView()
        self.navigationController?.view.backgroundColor = UIColor.clear
        
        navBar.setValue(true, forKey: "hidesShadow")
        // Do any additional setup after loading the view.
    }
    
    func setUpTableView(){
        tableView.register(UINib(nibName: FavoriteEstablishmentTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: FavoriteEstablishmentTableViewCell.reuseIdentifier())
        tableView.register(UINib(nibName: EstablishmentTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: EstablishmentTableViewCell.reuseIdentifier())
        tableView.register(UINib(nibName: HeaderForTableViewSection.nibName(), bundle: nil), forCellReuseIdentifier: HeaderForTableViewSection.reuseIdentifier())
        
    }
    
    
    
}
extension SearchViewController : UITableViewDataSource , UITableViewDelegate{
    
    func numberOfSections(in _: UITableView) -> Int {
        return viewModel.searchTableViewcellTypes.count
    }
    
    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
            
        case 0:
            return viewModel.searchTableViewcellTypes[section].count
            
        case 1:
            
            return filterdEstablishments!.count
            
        default:
            return filterdEstablishments!.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = viewModel.searchTableViewcellTypes[indexPath.section][indexPath.row]
        
        switch type {
            
        case .favorite(_):
            let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteEstablishmentTableViewCell.reuseIdentifier()) as! FavoriteEstablishmentTableViewCell
            cell.favorites = viewModel.establishments
            return cell
        case .establishment(_):
            let cell = tableView.dequeueReusableCell(withIdentifier: EstablishmentTableViewCell.reuseIdentifier()) as! EstablishmentTableViewCell
            
            return cell
            
        }
    }
    // set the height of the row based on the chosen cell
    func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let type = viewModel.searchTableViewcellTypes[indexPath.section][indexPath.row]
        switch type {
            
        case .favorite(_):
            return 170
        case .establishment(_):
            return 100
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch section {
        case 1:
            let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderForTableViewSectionID") as! HeaderForTableViewSection
            return headerCell.contentView
            
            
        default:
            return nil
        }
    }
    
    func tableView(_: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        switch section {
        case 1:
            
            return 40
            
            
        default:
            return 0
        }
    }
    
    func showEstablishments(_ show: Bool) {
        let indexPath = IndexPath(row: 1, section: 1)
        tableView.beginUpdates()
        if show {
            tableView.insertRows(at: [indexPath], with: .fade)
        } else {
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        tableView.endUpdates()
    }
    
}
extension SearchViewController: UISearchBarDelegate
{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar)
    {
        //Show Cancel
        searchBar.setShowsCancelButton(true, animated: true)
        searchBar.tintColor = .systemIndigo
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        //Filter function
        filterdEstablishments =  viewModel.establishments
        filterdEstablishments = filterdEstablishments?.filter {$0.name == "bpo"}
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        //Hide Cancel
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
        
        //        guard let term = searchBar.text , term.trim().isEmpty == false else {
        //
        //            //Notification "White spaces are not permitted"
        //            return
    }
    
    //Filter function
    //   self.filterFunction(searchText: term)
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    {
        //Hide Cancel
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.text = String()
        searchBar.resignFirstResponder()
        
        //Filter function
        //  self.filterFunction(searchText: searchBar.text)
    }
}









