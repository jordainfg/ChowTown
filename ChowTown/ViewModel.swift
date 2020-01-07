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
    case MenuHeader(String)
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
    case favorite(Restaurant)
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
    
    // MARK: - Firebase
    
    let db = Firestore.firestore()
    let storage = Storage.storage()
    
    var restaurants : [Restaurant] = []
    var menus : [Menu] = []
    var meals : [Meal] = []
    var filterdMeals : [Meal] = []
    var Popularmeals : [Meal] = []
    
    var isLoggedIn : Bool = true
    
    var selectedRestaurant : Restaurant?
    var selectedMeal : Meal?
    
    var rewards : [Reward] = []
    var rewardPoints : UserRewardPoints?
    // MARK: - Views
    // ChoiceMenuViewController
    
    var choiceMenuTableViewCellTypes: [[ChoiceMenuTableViewDataType]] {
        
        // let specialmeals = meals.filter {$0.isPopular == true}.map { ChoiceMenuTableViewDataType.MenuSpecials([$0]) }
        //  let specials = meals.filter {$0.isPopular == true}
        let types: [[ChoiceMenuTableViewDataType]] = [[.MenuHeader("")],[.MenuSpecials(Popularmeals)],[.MenuFood(menus.filter {$0.isMeal == false})] ,[.MenuDrinks(menus.filter {$0.isMeal == false})]]
        
        return types
    }
    
    //Meal Detail
    var addons : [AddOn] = [AddOn(name: "Advocado", price: 12 , iconNumber: 0), AddOn(name: "Advocado", price: 12, iconNumber: 0),AddOn(name: "Advocado", price: 12, iconNumber: 0)]
    
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
    
    // Search & Favorites
    var favoritesIsShowing = false
    var searchTableViewcellTypes: [[SearchTableViewDataType]] {
        
        //let favorites = []
        // let favoritesDataTypes = favorites.map { SearchTableViewDataType.favorite($0) }
        let restaurantDataTypes = restaurants.map { SearchTableViewDataType.restaurant($0) }
        var types: [[SearchTableViewDataType]] = [[],restaurantDataTypes]
        
        if favoritesIsShowing {
            types.append(restaurantDataTypes)
        }
        
        return types
    }
    
    
    //Rewards

    var rewardsTableViewcellTypes: [[RewardsTableViewDataType]] {
        let rewardsTypes = rewards.map { RewardsTableViewDataType.reward($0) }
        var types: [[RewardsTableViewDataType]] = [[.header],rewardsTypes]
        if FirebaseService.shared.authState == .isLoggedIn && !rewards.isEmpty {
            types = [[.header],rewardsTypes]
        }
        else if FirebaseService.shared.authState == .isLoggedOut  {
            types = [[.login]]
        } else {
           types = [[]]
        }
        return types
    }
    
    
    
    // SubMenuMealsAndDrinks
    
    var SubMenuMealsAndDrinksTableViewcellTypes: [[SubMenuMealsAndDrinksTableViewDataType]] {
        let mealsForMenu =  filterdMeals.map { SubMenuMealsAndDrinksTableViewDataType.meal($0) }
        let types: [[SubMenuMealsAndDrinksTableViewDataType]] = [[.header],mealsForMenu]
        
        return types
    }
    
    // REWARDS
    
    
    
    
    
    
    
}



