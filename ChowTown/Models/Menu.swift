//
//  SubMenu.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 12/11/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import Foundation


public struct Menu{
    var menuID : String
    var title : String
    var detail: String
    var color : String
    var iCon : String
    var startTime : String
   var imageRef : String
    var companyID : String
    var isMeal : Bool
    
    
    init?(dictionary: [String: Any]) {
        guard let companyID = dictionary["companyID"] as? String else { return nil }
        self.companyID = companyID
        self.title = dictionary["title"] as! String
        self.menuID = dictionary["menuID"] as! String
        self.detail = dictionary["detail"] as! String
        self.iCon = dictionary["iCon"] as! String
        self.imageRef = dictionary["imageRef"] as! String
        self.startTime = dictionary["startTime"] as! String
        self.color = dictionary["color"] as! String
        self.isMeal = dictionary["isMeal"] as! Bool
    }
    
    
}

