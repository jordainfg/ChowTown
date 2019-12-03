//
//  Meal.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 21/11/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import Foundation
public struct Meal{
    
    var companyID : String
    var name: String
    var detail : String
    var price : Int
    var about : Array<Int>
    var allergens: Array<Any>
    var protein : String
    var fat : String
    var carbs : String
    var additions: Array<Any>
    var isPopular : Bool
    var imageRef : String
  
        init?(dictionary: [String: Any]) {
            guard let companyID = dictionary["companyID"] as? String else { return nil }
            self.companyID = companyID
            self.name = dictionary["name"] as! String
             self.detail = dictionary["detail"] as! String
             self.price = dictionary["price"] as! Int
             self.about = dictionary["about"] as! Array<Int>
             self.allergens = dictionary["allergens"] as! Array<Any>
             self.protein = dictionary["protein"] as! String
             self.fat = dictionary["fat"] as! String
             self.carbs = dictionary["carbs"] as! String
             self.additions = dictionary["additions"] as! Array<Any>
             self.isPopular = dictionary["isPopular"] as! Bool
             self.imageRef = dictionary["imageRef"] as! String
    
            
        }
    
}
