//
//  Establishment.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 15/11/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import Foundation


public struct Restaurant{
    
    var restID : String
    var name : String
    var about: String
    var address: String
    var emailAddress: String
    var hours: String
    var phone : String
    var color : String
    var imageRefrence : String
    var facebookURL : String
    var instagramURL : String
    var logoURL : String
    var websiteURL : String
    
    
    
    
    init?(dictionary: [String: Any]) {
        guard let restID = dictionary["restID"] as? String else { return nil }
        self.restID = restID
        self.name = dictionary["name"] as! String
        self.about = dictionary["about"] as! String
        self.address = dictionary["address"] as! String
        self.emailAddress = dictionary["emailAddress"] as! String
        self.hours = dictionary["hours"] as! String
        self.phone = dictionary["phone"] as! String
        self.color = dictionary["color"] as! String
        self.imageRefrence = dictionary["imageRefrence"] as! String
        self.facebookURL = dictionary["facebookURL"] as! String
        self.instagramURL = dictionary["instagramURL"] as! String
        self.logoURL = dictionary["logoURL"] as! String
        self.websiteURL = dictionary["websiteURL"] as! String
        

    }
        
}
