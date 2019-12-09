//
//  ViewModel+CRUDExt.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 25/11/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import Foundation
import Firebase

extension ViewModel{
    // MARK: - CR MEALS
    func addMeal(refRestaurant : DocumentReference?, refMenu :DocumentReference?){
        // Add a new document with a generated ID
        
     //  let refMeal = db.collection("Restaurant/\(refRestaurant.documentID)/Menu/\(refMenu.documentID)/Meals").document()
        let refMeal = db.collection("Restaurant/XyKLjdbP818Od9uX7atq/Menu/Bwv6ujfH8P9eDcx0X4xb/Meals").document()
        refMeal.setData([
            "companyID" : "2",
            "name": "Noosh Bowl",
            "detail": "Geweld in appelsap, met wortel, noten en vers fruit",
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
                print("Meal added with ID: \(refMeal.documentID)")
            }
        }
    }
    
    func addPopularMeal(){
           // Add a new document with a generated ID
          let refMeal = db.collection("Restaurant/XyKLjdbP818Od9uX7atq/PopularMeals").document()
           refMeal.setData([
               "companyID" : "2",
               "name": "Acai bowl",
               "detail": "Choose from Berries, pears, apples, grapes, citrus. winter: grapefruit, oranges, kiwi,",
               "price" : 10,
               "about": [1,2,3,5,6,7],
               "allergens": [1,2,3,4],
               "protein": "",
               "fat": "",
               "carbs": "",
               "additions": [],
               "isPopular": true,
               "imageRef": "gs://chow-town-bc783.appspot.com/Meals/placeholder7.jpg",
           ]) { err in
               if let err = err {
                   print("Error adding document: \(err)")
               } else {
                   print("Meal added with ID: \(refMeal.documentID)")
               }
           }
       }
    
    func getPopularMeals( completion: @escaping () -> Void){
        self.Popularmeals.removeAll()
         //db.collection("Menus/\(selectedMenu.menuID)/Meals").getDocuments() { (querySnapshot, err) in
        let restID = UserDefaults.standard.string(forKey: "selectedRestaurant")!
        //print("Restaurant/\(restID)/Menu/\(selectedMenu.menuID)/Meals")
        db.collection("Restaurant/XyKLjdbP818Od9uX7atq/PopularMeals").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    
                    self.Popularmeals.append(Meal(dictionary: document.data())! )
                    
                    
                }
                completion()
                print("Boom, \(self.meals)")
            }
        }
    }

    
    
    func getMealsForMenu(selectedMenu : Menu, completion: @escaping () -> Void){
       // selectedMenu : Menu,
         //db.collection("Menus/\(selectedMenu.menuID)/Meals").getDocuments() { (querySnapshot, err) in
        self.meals.removeAll()
        let restID = UserDefaults.standard.string(forKey: "selectedRestaurant")!
        print("Restaurant/\(restID)/Menu/\(selectedMenu.menuID)/Meals")
        db.collection("Restaurant/\(restID)/Menu/\(selectedMenu.menuID)/Meals").getDocuments() { (querySnapshot, err) in
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
    func addMenu(reff: DocumentReference?){
        // Add a new document with a generated ID
        // var ref: DocumentReference? = nil
       //  let refMenu = db.collection("Restaurant/\(reff.documentID)/Menu").document()
        let refMenu = db.collection("Restaurant/XyKLjdbP818Od9uX7atq/Menu").document()
        refMenu.setData([
            "menuID" : refMenu.documentID,
            "companyID" : "2",
            "title": "Lunch",
            "detail": "From 10:00 am",
            "iCon" : "icDinner",
            "imageRef": "",
            "startTime": "",
            "color": "#A72D89",
            "isMeal" : false,
            
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Menu added with ID: \(refMenu.documentID)")
                self.addMeal(refRestaurant: reff, refMenu: refMenu)
            }
        }
        
    }
    
    
    func getMenus(forRestaurant: String , completion: @escaping () -> Void){
        self.menus.removeAll()
           db.collection("Restaurant/\(forRestaurant)/Menu").getDocuments() { (querySnapshot, err) in
               if let err = err {
                   print("Error getting documents: \(err)")
               } else {
                   for document in querySnapshot!.documents {
                       
                    self.menus.append(Menu(dictionary: document.data())! )
                       
                       
                   }
                   completion()
                   print("The menus for this restaurant are:, \(self.menus)")
               }
           }
       }
    
    
    
    
    func getRestaurants(completion: @escaping () -> Void){
        self.restaurants.removeAll()
        db.collection("Restaurant").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    
                    self.restaurants.append(Restaurant(dictionary: document.data())! )
                    
                    
                }
                completion()
                print("Boom, \(self.restaurants)")
            }
        }
    }
    
    func addRestaurant(){
        // Add a new document with a generated ID
        // var ref: DocumentReference? = nil
        let ref = db.collection("Restaurant").document()
        
        ref.setData( [
            "restID" : ref.documentID,
            "name" : "Anne&Max",
            "about": "Sandwiches - Panini - Biologishe Koffie & Thee - Salades - Speltmuesli. Anne&Max de freshfood&coffeecafe. Elke dag ontbijt, koffie, lunch, high tea en borrel. Gratis WiFi. Van ontbijt tot borrel. Vers & Gezonde producten",
            "address": "Kerkplein 4, 2513 AZ Den Haag",
            "emailAddress" : "annem@max.nl",
            "hours": "Monday - Friday",
            "phone": "070 891 2860",
            "color": "#FFC872",
            "imageRefrence": "",
            "facebookURL": "",
            "instagramURL": "",
            "logoURL" : "",
            "websiteURL" : "",
        ]){ err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Restaurant added with ID: \(ref.documentID)")
                self.addMenu(reff: ref)
            }
        }
        
    }
    
    
}
