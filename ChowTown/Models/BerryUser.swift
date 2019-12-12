//
//  BerryUser.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 12/12/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import Foundation


public struct BerryUser{
    
    
    var name: String
    var email: String
    var rewardPoints: String
    var favoriteRestaurants : [String]
    
    init?(dictionary: [String: Any]) {
        guard let name = dictionary["name"] as? String else { return nil }
        self.name = name
        self.email = dictionary["email"] as! String
        
        self.rewardPoints = dictionary["rewardPoints"] as! String
        self.favoriteRestaurants = dictionary["favoriteRestaurants"] as! Array<String>
        
    }
    
}
