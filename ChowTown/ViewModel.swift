//
//  ViewModel.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 12/11/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import Foundation
import Firebase

enum ChoiceMenuTableViewDataType {
    case MenuHeader(Restaurant)
    case MenuSpecials([Meal])
    case MenuFood([Menu])
    case MenuDrinks([Menu])
    //case Drinks
}

enum mealDetailTableViewDataType {
    case nutritionInfo
    case aboutIconSet(String)
    case alergenIconSet(String)
    case addOns(String)
}

enum SearchTableViewDataType {
    case favorite(FavoriteRestaurant)
    case restaurant(Restaurant)
}

enum RewardsTableViewDataType {
    
    case header
    case reward(Reward)
    case login
}

enum SubMenuMealsAndDrinksTableViewDataType {
    case header
    case meal(Meal)
    case drink
}



public class ViewModel{
    
    // MARK: - Variables
    
    let db = Firestore.firestore()
    let storage = Storage.storage()
    
    var restaurants : [Restaurant] = []
    var filterdRestaurants : [Restaurant] = []
    var favoriteRestaurants : [FavoriteRestaurant] = []
    var filterdFavoriteRestaurants : [FavoriteRestaurant] = []
    var selectedRestaurant : Restaurant?
    
    var menus : [Menu] = []
    var meals : [Meal] = []
    var filterdMeals : [Meal] = []
    var Popularmeals : [Meal] = []
    

    var selectedMeal : Meal?
    var selectedMenu : Menu?
    
    var rewards : [Reward] = []
    var rewardPoints : UserRewardPoints?
    
    
    
    // MARK: -  Search & Favorites
    
    var favoritesIsShowing = false
    var searchTableViewcellTypes: [[SearchTableViewDataType]] {
        
        //let favorites = []
         let favoritesDataTypes = favoriteRestaurants.map { SearchTableViewDataType.favorite($0) }
        let restaurantDataTypes = filterdRestaurants.map { SearchTableViewDataType.restaurant($0) }
        var types: [[SearchTableViewDataType]] = [[]]
        
        if !favoriteRestaurants.isEmpty {
            types = [favoritesDataTypes,restaurantDataTypes]
        } else{
            types = [[],restaurantDataTypes]
        }
        
        return types
    }
    
    // MARK: - ChoiceMenuViewController
    var choiceMenuTableViewCellTypes: [[ChoiceMenuTableViewDataType]] {
        
        // let specialmeals = meals.filter {$0.isPopular == true}.map { ChoiceMenuTableViewDataType.MenuSpecials([$0]) }
        //  let specials = meals.filter {$0.isPopular == true}
        
        var types: [[ChoiceMenuTableViewDataType]] = [[]]
        if let rest = selectedRestaurant{
            if selectedRestaurant?.subscriptionPlan == 0 {
               types = [[]]
            } else {
               types = [[.MenuHeader(rest)],[.MenuSpecials(Popularmeals)],[.MenuFood(menus.filter {$0.isMeal == true})] ,[.MenuDrinks(menus.filter {$0.isMeal == false})]]
            }
        }
        return types
    }
    
 // MARK: - SubMenuMealsAndDrinks
    var SubMenuMealsAndDrinksTableViewcellTypes: [[SubMenuMealsAndDrinksTableViewDataType]] {
        let mealsForMenu =  filterdMeals.map { SubMenuMealsAndDrinksTableViewDataType.meal($0) }
        var types: [[SubMenuMealsAndDrinksTableViewDataType]] = [[.header],mealsForMenu]
        if let menu = selectedMenu {
             if menu.isMeal{
                 types =  [[.header],mealsForMenu]
             } else{
                 types =  [mealsForMenu]
             }
         }
        return types
    }

    
    // MARK: About Meal
    var mealDetailTableViewcellTypes: [[mealDetailTableViewDataType]] {
        
        if let additions = selectedMeal?.additions{
            let AddOns = additions.map { mealDetailTableViewDataType.addOns($0) }
            let types: [[mealDetailTableViewDataType]] = [[],[.nutritionInfo],[.aboutIconSet("About")],[.alergenIconSet("Alergens")],AddOns]
            return types
        } else{
            let types: [[mealDetailTableViewDataType]] = [[],[.nutritionInfo],[.aboutIconSet("About")],[.alergenIconSet("Alergens")]]
            
            return types
        }
        
        
    }
    

    // MARK: Rewards
    var rewardsTableViewcellTypes: [[RewardsTableViewDataType]] {
        let rewardsTypes = rewards.map { RewardsTableViewDataType.reward($0) }
        var types: [[RewardsTableViewDataType]] = [[]]
        if let plan = selectedRestaurant?.subscriptionPlan {
        if FirebaseService.shared.authState == .isLoggedIn && plan > 1 {
            types = [[.header],rewardsTypes]
        }
        else if FirebaseService.shared.authState == .isLoggedIn && plan == 0 {
        types = [[]]
        }
        else if FirebaseService.shared.authState == .isLoggedOut && plan > 1  {
        types = [[.login]]
        }
        }
    return types
}








}



