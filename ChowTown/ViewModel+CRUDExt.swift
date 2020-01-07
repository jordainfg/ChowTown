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
        let restID = UserDefaults.standard.string(forKey: "selectedRestaurant")!
        let refMeal = db.collection("Restaurant/\(restID)/Menu/Bwv6ujfH8P9eDcx0X4xb/Meals").document()
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
        let restID = UserDefaults.standard.string(forKey: "selectedRestaurant")!
          let refMeal = db.collection("Restaurant/\(restID)/PopularMeals").document()
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
        db.collection("Restaurant/\(restID)/PopularMeals").getDocuments() { (querySnapshot, err) in
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
        let restID = UserDefaults.standard.string(forKey: "selectedRestaurant")!
        let refMenu = db.collection("Restaurant/\(restID))/Menu").document()
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
    
    
    
    // MARK: - CR Restaurants
    func getRestaurants(completion: @escaping () -> Void){
       
        db.collection("Restaurant").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                     self.restaurants.removeAll()
                    self.restaurants.append(Restaurant(dictionary: document.data())! )
                    
                    
                }
                completion()
                print("Boom, \(self.restaurants)")
            }
        }
    }
    
    func getRestaurant(completion: @escaping () -> Void){
           
           let restID = UserDefaults.standard.string(forKey: "selectedRestaurant")!
           let docRef = db.collection("Restaurant").document(restID)
           
           docRef.getDocument { (document, error) in
               if let document = document, document.exists {
                _ = document.data().map(String.init(describing:)) ?? "nil"
                   self.selectedRestaurant = Restaurant(dictionary: document.data()!)
                   print("got the restaurant")
                   completion()
               } else {
                   print("Document does not exist")
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
    
//    func favoriteRestaurant(){
//       // let userID = (FirebaseService.shared.authenticationState?.user_ID)!
//        let docRef = db.collection("Users").document("muzunI6MKLNck3msZU5dO0NeBNh1")
//
//             docRef.setData( [
//                   "user_ID" : "testing",
//                  
//               ]){ err in
//                   if let err = err {
//                       print("Error adding document: \(err)")
//                   } else {
//                       print("Edites")
//                      
//                   }
//               }
//    }
    
    // MARK: - CR Rewards
    
    func getRewards(completionHandler: @escaping (Result<Response, CoreError>) -> Void){
          rewards.removeAll()
          let restID = UserDefaults.standard.string(forKey: "selectedRestaurant")!
          db.collection("Restaurant/\(restID)/Rewards").getDocuments() { (querySnapshot, err) in
              if let err = err {
                  print("Error getting documents: \(err)")
                completionHandler(.failure(.error(error: err)))
              } else {
                if querySnapshot!.documents.isEmpty {
                    completionHandler(.failure(.noSuchCollection))
                }
                  for document in querySnapshot!.documents {
                      
                      self.rewards.append(Reward(dictionary: document.data())! )
                      
                    completionHandler(.success(.collectionRetrieved))
                  }
                  
              }
          }
      }
    
    func addRewardPoints(points : Int){
         let userID = (FirebaseService.shared.authenticationState?.user_ID)!
        let restID = UserDefaults.standard.string(forKey: "selectedRestaurant")!
               let docRef = db.collection("Users/\(userID)/Rewards").document(restID)

                    docRef.setData( [
                       "restID" : UserDefaults.standard.string(forKey: "selectedRestaurant")!,
                          "rewardPoints" : points,
                         
                      ]){ err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("rewards added with ID: \(docRef.documentID)")
               
            }
        }
        
    }
    
    func getRewardPointsForRestaurant(completionHandler: @escaping (Result<Response, CoreError>) -> Void){
        if FirebaseService.shared.authState == .isLoggedOut {
            completionHandler(.failure(.unAuthenticated))
            print (completionHandler(.failure(.unAuthenticated)))
        }
        if let userID = FirebaseService.shared.authenticationState?.user_ID {
        let restID = UserDefaults.standard.string(forKey: "selectedRestaurant")!
        let docRef = db.collection("Users/\(userID)/Rewards").document(restID)
        
        docRef.getDocument { (document, error) in
            if let err = error {
              completionHandler(.failure(.error(error: err)))
            }
            if let document = document, document.exists {
                _ = document.data().map(String.init(describing:)) ?? "nil"
                self.rewardPoints = UserRewardPoints(dictionary: document.data()!)
                print("got the reward points for the user")
                completionHandler(.success(.documentRetrieved))
            } else {
                print("Document does not exist")
                completionHandler(.failure(.noSuchDocument))
            }
        }
        }
    }
    
}
