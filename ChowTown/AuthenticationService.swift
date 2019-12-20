//
//  AuthenticationService.swift
//  ChowTown
//
//  Created by Jordain Gijsbertha on 12/12/2019.
//  Copyright © 2019 Jordain Gijsbertha. All rights reserved.
//

import Foundation

import Firebase
class AuthenticationService {
    static let shared = AuthenticationService()
    
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
                    "userID": "\(authResult.user.uid)",
                    "name": "test",
                    "email": "\(authResult.user.email!)",
                    "rewardPoints": 20,
                     "rewardPoints": [""]
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
            guard self != nil else { return }
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
    
    func getAuthenticatedUserData(){
        
    }
    
    
}
