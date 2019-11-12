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


public class ViewModel{
    
  
    // ChoiceMenuViewController
    var choiceMenu : [Choice] = [Choice(title: "Lunch", detail: "bla"), Choice(title: "Brunch", detail: "bla"), Choice(title: "Dinner", detail: "bla")]
    
    var choiceMenuTableViewCellTypes: [[ChoiceMenuTableViewDataType]] {
        
        let choices = choiceMenu.map { ChoiceMenuTableViewDataType.Choice($0) }
        
        let types: [[ChoiceMenuTableViewDataType]] = [[.Header("")],choices]
        
        return types
    }
    
    
    
    
}
