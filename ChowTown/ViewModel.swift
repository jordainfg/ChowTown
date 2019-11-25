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
    case header
    case nutritionInfo
    case aboutIconSet(String)
    case alergenIconSet(String)
    case addOns(AddOn)
}

enum SearchTableViewDataType {
    case favorite(Restaurant)
    case establishment(Restaurant)
}

enum RewardsTableViewDataType {
    case header
    case reward
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
    
    var meals : [Meal] = []
    
    var menus : [Menu] = []
    
    // MARK: - Views
    // ChoiceMenuViewController
   
    var choiceMenuTableViewCellTypes: [[ChoiceMenuTableViewDataType]] {
        
       // let specialmeals = meals.filter {$0.isPopular == true}.map { ChoiceMenuTableViewDataType.MenuSpecials([$0]) }
        let specials = meals.filter {$0.isPopular == true}
        let types: [[ChoiceMenuTableViewDataType]] = [[.MenuHeader("")],[.MenuSpecials(specials)],[.MenuFood(menus.filter {$0.isMeal == true})] ,[.MenuDrinks(menus.filter {$0.isMeal == false})]]
        
        return types
    }
    
    //Meal Detail
    var addons : [AddOn] = [AddOn(name: "Advocado", price: 12 , iconNumber: 0), AddOn(name: "Advocado", price: 12, iconNumber: 0),AddOn(name: "Advocado", price: 12, iconNumber: 0)]
    
    var mealDetailTableViewcellTypes: [[mealDetailTableViewDataType]] {
        
        let AddOns = addons.map { mealDetailTableViewDataType.addOns($0) }
        
        let types: [[mealDetailTableViewDataType]] = [[.header,.aboutIconSet("About"),.alergenIconSet("Alergens"),.nutritionInfo],AddOns]
        
        return types
    }
    
    // Search & Favorites
    var favoritesIsShowing = false
    var establishments : [Restaurant] = [Restaurant(restID: "", name: "NB", about: "sj,sfm", address: "", emailAddress: "", hours: "", phone: 0, color: "#FFC873", imageRefrence: "", facebookURL: "", instagramURL: "", logoURL: "", websiteURL: ""),Restaurant(restID: "ssss", name: "", about: "s,nmfs", address: "", emailAddress: "", hours: "", phone: 0, color: "#FFC972", imageRefrence: "", facebookURL: "", instagramURL: "", logoURL: "", websiteURL: ""),Restaurant(restID: "", name: "sss", about: "sfmnsf,sf", address: "", emailAddress: "", hours: "", phone: 0, color: "#FFC875",imageRefrence: "", facebookURL: "", instagramURL: "", logoURL: "", websiteURL: "")]
    var searchTableViewcellTypes: [[SearchTableViewDataType]] {
        
        let favorites = [Restaurant(restID: "", name: "", about: "", address: "", emailAddress: "", hours: "", phone: 0, color: "#FFC972", imageRefrence: "", facebookURL: "", instagramURL: "", logoURL: "", websiteURL: "")]
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
    
    
    // SubMenuMealsAndDrinks
    
    var SubMenuMealsAndDrinksTableViewcellTypes: [[SubMenuMealsAndDrinksTableViewDataType]] {
       let mealsForMenu =  meals.map { SubMenuMealsAndDrinksTableViewDataType.meal($0) }
        let types: [[SubMenuMealsAndDrinksTableViewDataType]] = [[.header],mealsForMenu]
        
        return types
    }
    
    // MARK: - CR MEALS
    func addMeal(reff : DocumentReference){
        // Add a new document with a generated ID
    //        var ref: DocumentReference? = nil
        reff.collection("Meals").addDocument(data:[
            "companyID" : "2",
            "name": "Noosh",
            "detail": "Griekse yoghurt, Anne&Max granola en vers fruit",
            "price" : 10,
            "about": [1,2,3,5,6,7],
            "allergens": [1,2,3,4],
            "protein": "",
            "fat": "",
            "carbs": "",
            "additions": [],
            "isPopular": true,
            "imageRef": "gs://chow-town-bc783.appspot.com/Meals/43690812_260822031257663_7880763896869087864_n.jpg",
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(reff.documentID)")
            }
        }
    
    }
    
    func getMealsForMenu(selectedMenu : Menu, completion: @escaping () -> Void){
        db.collection("Menus/\(selectedMenu.menuID)/Meals").getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        
                        self.meals.append(Meal(dictionary: document.data())! )
                        
                        
                    }
                    completion()
                    print("Boom, \(self.meals)")
                }
        }
    }
    
     // MARK: - CR Menus
        func addMenu(){
            // Add a new document with a generated ID
           // var ref: DocumentReference? = nil
            let ref = db.collection("Menus").document()

            ref.setData( [
                "menuID" : ref.documentID,
                "companyID" : "2",
                "title": "Hot",
                "detail": "From 10:00 am",
                "iCon" : "icHotBevrage",
                "imageRef": "",
                "startTime": "",
                "color": "#FFC872",
                "isMeal" : false

            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(ref.documentID)")
                    self.addMeal(reff: ref)
                }
            }
 
        }
        
        func getMenus(completion: @escaping () -> Void){
            db.collection("Menus").getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            
                            self.menus.append(Menu(dictionary: document.data())! )
                            
                            
                        }
                        completion()
                        print("Boom, \(self.menus)")
                    }
            }
        }
    
    
    
    
    
}



