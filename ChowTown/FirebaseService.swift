//
//  FirebaseService.swift
//  Nutshell
//
//  Created by Jordain Gijsbertha on 10/15/19.
//  Copyright © 2019 Jordain  Gijsbertha. All rights reserved.
//

import Foundation
import Firebase
import KeychainSwift

enum appState {
    case didFinishLaunchingWithOptions
    case applicationDidEnterBackground
    case applicationDidBecomeActive
    case applicationWillTerminate
    case applicationIsAuthenticatingWithGoogle
}

enum authenticationState {
    case isLoggedIn
    case isLoggedOut
}

class FirebaseService : NSObject {
    static let shared = FirebaseService()
    
    func start() {}
    
    var db : Firestore?
    
    var handle: AuthStateDidChangeListenerHandle?
    
    var userData : User?
    
    let keychain = KeychainSwift()
    let authenticationStateKeyChainKey = ""
    
    
    var authState : authenticationState = .isLoggedOut
    
    func configure(){
        FirebaseApp.configure()
        db = Firestore.firestore()
        
        if authState == .isLoggedOut {
            Auth.auth().signInAnonymously() { (authResult, error) in
                if authResult != nil{
                    print("Signed in anonymously")
                }
                else if error != nil{
                    print("Error singin in anonymously")
                   
                }
            }
        }
        
        
    }
    
    public private(set) var authenticationState: AuthenticationState? {
        set {
            // save to the keychain
            if let state = newValue, let archived = try? PropertyListEncoder().encode(state) {
                keychain.set(archived, forKey: authenticationStateKeyChainKey)
            } else {
                keychain.delete(authenticationStateKeyChainKey)
            }
        }
        
        get {
            if
                let data = keychain.getData(authenticationStateKeyChainKey),
                let state = try? PropertyListDecoder().decode(AuthenticationState.self, from: data) {
                return state
            }
            return nil
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    //Creates a user in the database and authentication Pane
    func createUser(withEmail: String, password: String , completionHandler: @escaping (Result<User, CoreError>) -> Void){
        Auth.auth().createUser(withEmail: withEmail, password: password) { (authResult, error) in
            if let authResult = authResult{
                // Add a new document with a your own ids
                self.userData? = authResult.user
                self.db?.collection("Users").document(authResult.user.uid).setData([
                    "name": "test",
                    "email": "\(authResult.user.email!)",
                    "user_ID": "\(authResult.user.uid)",
                    
                ])
//               
                completionHandler(.success(authResult.user))
            }
            else if error != nil{
                print(error)
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
                        
                        self?.setAuthenticationState(uid: user.uid)
                        
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
    
    func setAuthenticationState(uid : String){
        
        
        let docRef = db?.collection("Users").document(uid)
        
        docRef?.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                if let data = document.data(){
                    self.authenticationState = AuthenticationState(dictionary: data)
                    self.setAuthState(state: .isLoggedIn)
                }
                print("Document data: \(dataDescription)")
            } else {
                
                self.setAuthState(state: .isLoggedOut)
                print("Document does not exist")
            }
        }
        
    }
    
    func setAuthState(state : authenticationState){
        self.authState = state
    }
    
    func checkAuthenticationState(){
        if authenticationState == nil {
            setAuthState(state: .isLoggedOut)
        } else {
            setAuthState(state: .isLoggedIn)
        }
    }
    
    func clearAllSessionData(){
        authenticationState = nil
        setAuthState(state: .isLoggedOut)
    }
}
