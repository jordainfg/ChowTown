//
//  PushNotificationService.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 10/01/2020.
//  Copyright © 2020 Jordain Gijsbertha. All rights reserved.
//

import Foundation
import Firebase
import UserNotifications
class PushNotificationService : NSObject  {
    
    
    static let shared = PushNotificationService()
    
    func start() {}
    
    
    func linkUserDeviceWithPushNotificationService(){
//        if #available(iOS 10.0, *) {
//          // For iOS 10 display notification (sent via APNS)
//          UNUserNotificationCenter.current().delegate = self
//
//          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
//          UNUserNotificationCenter.current().requestAuthorization(
//            options: authOptions,
//            completionHandler: {_, _ in })
//        } else {
//          let settings: UIUserNotificationSettings =
//          UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
//          application.registerUserNotificationSettings(settings)
//        }
//
//        application.registerForRemoteNotifications()

    }
    
}



