//
//  Reward.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 11/12/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import Foundation
public struct Reward{
    
    var name : String
    var points: String
    
    
    init?(dictionary: [String: Any]) {
          guard let name = dictionary["name"] as? String else { return nil }
          self.name = name
          self.points = dictionary["points"] as! String
         
     
          
      }
        
}

public struct UserRewardPoints{
    
    var restID : String
    var rewardPoints: String
    
    
    init?(dictionary: [String: Any]) {
          guard let restID = dictionary["restID"] as? String else { return nil }
          self.restID = restID
          self.rewardPoints = dictionary["rewardPoints"] as! String
         
     
          
      }
        
}
