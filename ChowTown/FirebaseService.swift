//
//  FirebaseService.swift
//  Nutshell
//
//  Created by Jordain Gijsbertha on 10/15/19.
//  Copyright © 2019 Jordain  Gijsbertha. All rights reserved.
//

import Foundation
import Firebase
class FirebaseService {
    static let shared = FirebaseService()
    
    var db : Firestore?
    
    var handle: AuthStateDidChangeListenerHandle?
    
    var userData : User?
    
    
    
    
    func configure(){
        FirebaseApp.configure()
        db = Firestore.firestore()
        
    }
    
    func createUser(withEmail: String, password: String , completionHandler: @escaping (Result<User, CoreError>) -> Void){
        Auth.auth().createUser(withEmail: withEmail, password: password) { (authResult, error) in
            if let authResult = authResult{
                // Add a new document with a your own ids
                self.userData? = authResult.user
                self.db?.collection("Users").document(authResult.user.uid).setData([
                    "email": "\(authResult.user.email!)",
                    "isAdmin": false,
                ])
                completionHandler(.success(authResult.user))
            }
            else if error != nil{
                completionHandler(.failure(.unAuthenticated))
            }
            
        }
        
    }
    
    func loginUser(Email: String, password: String, completionHandler: @escaping (Result<User, CoreError>) -> Void){
        Auth.auth().signIn(withEmail: Email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            if let authResult = authResult{
                Auth.auth().addStateDidChangeListener { (auth, user) in
                    if let user = user {
                        self?.userData = user
                        completionHandler(.success(authResult.user))
                    }
                }
            }
            else if error != nil{
                completionHandler(.failure(.unAuthenticated))
            }
        }
        
    }
    
    
}
