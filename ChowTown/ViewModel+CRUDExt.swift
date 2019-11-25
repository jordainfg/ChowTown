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
    func addMenu(reff: DocumentReference){
        // Add a new document with a generated ID
        // var ref: DocumentReference? = nil
        
        reff.collection("Menu").addDocument(data:[
            "menuID" : reff.documentID,
            "companyID" : "2",
            "title": "Hot",
            "detail": "From 10:00 am",
            "iCon" : "icHotBevrage",
            "imageRef": "",
            "startTime": "",
            "color": "#FFC872",
            "isMeal" : false
            
        ]).collection("Meals").addDocument(data:[
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
                //self.addMeal(reff: )
            }
        }
        
    }
    
    
    func getMenus(forRestaurant: String , completion: @escaping () -> Void){
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
                print("Document added with ID: \(ref.documentID)")
                self.addMenu(reff: ref)
            }
        }
        
    }
    
    
}
