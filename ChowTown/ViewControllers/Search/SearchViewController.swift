//
//  SearchViewController.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 15/11/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import UIKit

protocol searchViewControllerCellDelegator {
    func prepareForSequeFromFavCollectionViewCell(segueIdentifier : String, restaurant : FavoriteRestaurant )
    
}

class SearchViewController: UIViewController ,searchViewControllerCellDelegator {
    
    var refreshControl: UIRefreshControl!
    
    var viewModel = ViewModel()
    
    var filterdRestaurants : [Restaurant] = []
    
    var selectedRestaurant : Restaurant?
    
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavBar()
        setUpTableView()
       // getFavoriteRestaurantsAndRestaurants()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getFavoriteRestaurantsAndRestaurants()
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }
    
    func setUpNavBar(){

        self.extendedLayoutIncludesOpaqueBars = true // fixed the black bar button
        self.searchController.obscuresBackgroundDuringPresentation = false
        //self.searchController.searchBar.placeholder = ""
        self.searchController.searchBar.delegate = self
        self.definesPresentationContext = true
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func getFavoriteRestaurantsAndRestaurants(){
        tableView.LoadingIndicator(isVisable: true)
        viewModel.getRestaurants { result in
            switch result {
            case .success:
                if FirebaseService.shared.authState == .isLoggedIn {
                    self.viewModel.getFavoriteRestaurants{ result in
                        switch result {
                        case .success:
                            self.viewModel.filterdRestaurants = self.viewModel.restaurants
                            self.viewModel.filterdFavoriteRestaurants = self.viewModel.favoriteRestaurants
                            UIView.transition(with: self.tableView,
                                              duration: 0.5,
                                              options: .transitionCrossDissolve,
                                              animations: { self.tableView.reloadData() })
                            self.refreshControl.endRefreshing()
                            self.tableView.LoadingIndicator(isVisable: false)
                        case .failure:
                            self.viewModel.filterdRestaurants = self.viewModel.restaurants
                            self.viewModel.filterdFavoriteRestaurants = self.viewModel.favoriteRestaurants
                            UIView.transition(with: self.tableView,
                                              duration: 0.5,
                                              options: .transitionCrossDissolve,
                                              animations: { self.tableView.reloadData() })
                            self.refreshControl.endRefreshing()
                            self.tableView.LoadingIndicator(isVisable: false)
                            
                        }
                    }
                } else {
                    self.viewModel.filterdRestaurants = self.viewModel.restaurants
                    self.viewModel.filterdFavoriteRestaurants = self.viewModel.favoriteRestaurants
                    self.viewModel.favoriteRestaurants.removeAll()
                    UIView.transition(with: self.tableView,
                                      duration: 0.5,
                                      options: .transitionCrossDissolve,
                                      animations: { self.tableView.reloadData() })
                    self.refreshControl.endRefreshing()
                    self.tableView.LoadingIndicator(isVisable: false)
                }
                
            case .failure:
                self.refreshControl.endRefreshing()
                self.tableView.LoadingIndicator(isVisable: false)
                
            }
            
            self.tableView.LoadingIndicator(isVisable: false)
        }
        
    }
    
    func setUpTableView(){
        refreshControl = UIRefreshControl()
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refreshControlAction), for: .valueChanged)
        tableView.LoadingIndicator(isVisable: true)
        self.tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: FavoriteEstablishmentTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: FavoriteEstablishmentTableViewCell.reuseIdentifier())
        tableView.register(UINib(nibName: EstablishmentTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: EstablishmentTableViewCell.reuseIdentifier())
        tableView.register(UINib(nibName: HeaderForTableViewSection.nibName(), bundle: nil), forCellReuseIdentifier: HeaderForTableViewSection.reuseIdentifier())
        
    }
    @objc func refreshControlAction(refreshControl _: UIRefreshControl) {
        self.refreshControl.beginRefreshing()
        getFavoriteRestaurantsAndRestaurants()
    }
    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        switch segue.identifier {
        case "toRestaurant":
            let secondVC = segue.destination as! RestaurantViewController
            secondVC.restaurant = selectedRestaurant
            viewModel.selectedRestaurant = selectedRestaurant
            secondVC.viewModel = self.viewModel
        default:
            return
        }
        
    }
    func prepareForSequeFromFavCollectionViewCell(segueIdentifier: String, restaurant: FavoriteRestaurant) {
        selectedRestaurant = viewModel.restaurants.first(where: {$0.restID == restaurant.restID})
        performSegue(withIdentifier: segueIdentifier, sender: nil)
    }
    
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
extension SearchViewController : UITableViewDataSource , UITableViewDelegate{
    
    func numberOfSections(in _: UITableView) -> Int {
        
        return viewModel.searchTableViewcellTypes.count
    }
    
    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
            
        case 0:
            return self.viewModel.filterdFavoriteRestaurants.count
            
        case 1:
            
            return viewModel.filterdRestaurants.count
            
        default:
            return viewModel.filterdRestaurants.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = viewModel.searchTableViewcellTypes[indexPath.section][indexPath.row]
        
        switch type {
            
        case let .favorite(favorite):
            let cell = tableView.dequeueReusableCell(withIdentifier: EstablishmentTableViewCell.reuseIdentifier()) as! EstablishmentTableViewCell
            cell.configureFavorite(restaurant: favorite)
            let storageRefrence = viewModel.storage.reference(forURL: favorite.logoURL)
            cell.icon.sd_setImage(with: storageRefrence, placeholderImage: UIImage(named: "placeHolder"))
            return cell
            
        case let .restaurant(Restaurant):
            let cell = tableView.dequeueReusableCell(withIdentifier: EstablishmentTableViewCell.reuseIdentifier()) as! EstablishmentTableViewCell
            cell.configure(restaurant: Restaurant)
            
            return cell
            
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type = viewModel.searchTableViewcellTypes[indexPath.section][indexPath.row]
        
        switch type {
            
        case let .favorite(restaurant):
            selectedRestaurant = viewModel.restaurants.first(where: {$0.restID == restaurant.restID})
            if selectedRestaurant != nil{
                performSegue(withIdentifier: "toRestaurant", sender: nil)
                tableView.deselectRow(at: indexPath, animated: true)
            } else {
                tableView.deselectRow(at: indexPath, animated: true)
            }
            
        case let .restaurant(restaurant):
            selectedRestaurant = viewModel.restaurants.filter({ $0.restID == restaurant.restID }).first
            if selectedRestaurant != nil{
                performSegue(withIdentifier: "toRestaurant", sender: nil)
                tableView.deselectRow(at: indexPath, animated: true)
            } else {
                tableView.deselectRow(at: indexPath, animated: true)
            }
        
        }
    }
    // set the height of the row based on the chosen cell
    func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let type = viewModel.searchTableViewcellTypes[indexPath.section][indexPath.row]
        switch type {
            
        case .favorite(_):
            return 100
        case .restaurant(_):
            return 100
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch section {
        case 0:
            let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderForTableViewSectionID") as! HeaderForTableViewSection
            if viewModel.favoriteRestaurants.isEmpty{
                headerCell.sectionName.text = ""
            } else{
                headerCell.sectionName.text = "Favorites"
            }
            
            return headerCell.contentView
        case 1:
            let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderForTableViewSectionID") as! HeaderForTableViewSection
            return headerCell.contentView
            
            
        default:
            return nil
        }
    }
    
    
    
    
    
    func tableView(_: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        switch section {
        case 0 :
            if viewModel.filterdFavoriteRestaurants.isEmpty{
                return 0
            } else{
                return 40
            }
        case 1:
            return 40
            
        default:
            return 40
        }
        
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
        if searchText.isEmpty{
            self.viewModel.filterdRestaurants = self.viewModel.restaurants
            self.viewModel.filterdFavoriteRestaurants = self.viewModel.favoriteRestaurants
            UIView.transition(with: self.tableView,
                              duration: 0.5,
                              options: .transitionCrossDissolve,
                              animations: { self.tableView.reloadData() })
            
            
        } else{
            self.viewModel.filterdRestaurants = self.viewModel.restaurants
            self.viewModel.filterdFavoriteRestaurants = self.viewModel.favoriteRestaurants
            self.viewModel.filterdRestaurants = self.viewModel.filterdRestaurants.filter { $0.name.range(of: searchText) != nil}
            self.viewModel.filterdFavoriteRestaurants = self.viewModel.filterdFavoriteRestaurants.filter { $0.name.range(of: searchText) != nil}
            UIView.transition(with: self.tableView,
                              duration: 0.5,
                              options: .transitionCrossDissolve,
                              animations: { self.tableView.reloadData() })
            
            
        }
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        //Hide Cancel
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
        
//                guard let term = searchBar.text , term.trim().isEmpty == false else {
//
//                    //Notification "White spaces are not permitted"
//                    return
    }
    
    //Filter function
    //   self.filterFunction(searchText: term)
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    {
        //Hide Cancel
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.text = String()
        searchBar.resignFirstResponder()
        filterdRestaurants =  viewModel.restaurants
        self.viewModel.filterdFavoriteRestaurants = self.viewModel.favoriteRestaurants
        UIView.transition(with: self.tableView,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: { self.tableView.reloadData() })
        
        
        //Filter function
        //  self.filterFunction(searchText: searchBar.text)
    }
}









