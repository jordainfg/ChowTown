//
//  ViewModel.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 12/11/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import Foundation

enum ChoiceMenuTableViewDataType {
    case Choice(Choice)
    case Header(String)
    //case Drinks
}

enum mealDetailTableViewDataType {
    case header
    case nutritionInfo
    case aboutIconSet(String)
    case alergenIconSet(String)
    case addOns(AddOn)
    
    
}


public class ViewModel{
    
  
    // ChoiceMenuViewController
    var choiceMenu : [Choice] = [Choice(title: "Lunch", detail: "bla"), Choice(title: "Brunch", detail: "bla"), Choice(title: "Dinner", detail: "bla")]
    
    
    var choiceMenuTableViewCellTypes: [[ChoiceMenuTableViewDataType]] {
        
        let choices = choiceMenu.map { ChoiceMenuTableViewDataType.Choice($0) }
        
        let types: [[ChoiceMenuTableViewDataType]] = [[.Header("")],choices]
        
        return types
    }
    
    //Meal Detial
    var addons : [AddOn] = [AddOn(name: "Advocado", price: 12 , iconNumber: 0), AddOn(name: "Advocado", price: 12, iconNumber: 0),AddOn(name: "Advocado", price: 12, iconNumber: 0)]
           
    var mealDetailTableViewcellTypes: [[mealDetailTableViewDataType]] {
       
        let AddOns = addons.map { mealDetailTableViewDataType.addOns($0) }
          
         let types: [[mealDetailTableViewDataType]] = [[.header,.aboutIconSet("About"),.alergenIconSet("Alergens"),.nutritionInfo],AddOns]
         
         return types
     }
    
    
    
    
}
