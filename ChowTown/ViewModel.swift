//
//  ViewModel.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 12/11/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import Foundation

enum ChoiceMenuTableViewDataType {
    case MenuHeader(String)
    case MenuSpecials(String)
    case MenuFood([Menu])
    case MenuDrinks([Menu])
    //case Drinks
}

enum mealDetailTableViewDataType {
    case header
    case nutritionInfo
    case aboutIconSet(String)
    case alergenIconSet(String)
    case addOns(AddOn)
    
    
}

enum SearchTableViewDataType {
    case favorite(Establishment)
    case establishment(Establishment)
}

enum RewardsTableViewDataType {
    case header
    case reward
}

public class ViewModel{
    
  
    // ChoiceMenuViewController
    var choiceMenu : [Menu] = [Menu(title: "Lunch", detail: "bla")]
    
    var choiceMenuTableViewCellTypes: [[ChoiceMenuTableViewDataType]] {
  
        
        let types: [[ChoiceMenuTableViewDataType]] = [[.MenuSpecials("")],[.MenuFood([])] ,[.MenuDrinks([])]]
        
        return types
    }
    
    //Meal Detial
    var addons : [AddOn] = [AddOn(name: "Advocado", price: 12 , iconNumber: 0), AddOn(name: "Advocado", price: 12, iconNumber: 0),AddOn(name: "Advocado", price: 12, iconNumber: 0)]
           
    var mealDetailTableViewcellTypes: [[mealDetailTableViewDataType]] {
       
        let AddOns = addons.map { mealDetailTableViewDataType.addOns($0) }
          
         let types: [[mealDetailTableViewDataType]] = [[.header,.aboutIconSet("About"),.alergenIconSet("Alergens"),.nutritionInfo],AddOns]
         
         return types
     }
    
    // Search & Favorites
    var favoritesIsShowing = false
    var establishments : [Establishment] = [Establishment(name: "bpo", address: "ss", hours: "ss", phone: 0638482214, imageRefrence: ""),Establishment(name: "d", address: "ss", hours: "ss", phone: 0638482214, imageRefrence: ""),Establishment(name: "d", address: "ss", hours: "ss", phone: 0638482214, imageRefrence: ""),Establishment(name: "rrv", address: "ss", hours: "ss", phone: 0638482214, imageRefrence: "")]
    var searchTableViewcellTypes: [[SearchTableViewDataType]] {
        
        let favorites = [Establishment(name: "bpo", address: "ss", hours: "ss", phone: 0638482214, imageRefrence: "")]
        let favoritesDataTypes = favorites.map { SearchTableViewDataType.favorite($0) }
        let establishmentsDataTypes = establishments.map { SearchTableViewDataType.establishment($0) }
        var types: [[SearchTableViewDataType]] = [favoritesDataTypes,establishmentsDataTypes]
        
        if favoritesIsShowing {
            types.append(establishmentsDataTypes)
        }
            
           return types
        }
    
    
    //Rewards
    
    var rewardsTableViewcellTypes: [[RewardsTableViewDataType]] {
         
        
            
           let types: [[RewardsTableViewDataType]] = [[.header]]
           
           return types
       }
}
