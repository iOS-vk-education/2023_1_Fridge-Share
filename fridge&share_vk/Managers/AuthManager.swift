//
//  AuthManager.swift
//  fridge&share_vk
//
//  Created by Елизавета Шерман on 17.04.2024.
//

import Foundation
import FirebaseAuth

class FireBaseAuthManager: ObservableObject {
    private enum Constants {
        static let email = "email"
        static let password = "password"
        static let userId = "userId"
        static let isLoggedIn = "isLoggedIn"
    }
    
    static let shared = FireBaseAuthManager()
    
    var database = FireBase.shared
    
    private init() {}
    
    var userId: String = "" {
        didSet {
            print(oldValue, userId)
        }
    }

    func createUser(userData: UserData, completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().createUser(withEmail: userData.email, password: userData.password) { [weak self] (authResult, error) in
            guard let self = self, let user = authResult?.user else {
                completionBlock(false)
                return
            }
            if let error = error {
                print("Error creating user:", error)
                return
            }
            UserDefaults.standard.set(userData.email, forKey: Constants.email)
            UserDefaults.standard.set(userData.password, forKey: Constants.password)
            self.userId = user.uid
            
            let userItem = UserData(id: user.uid, email: userData.email, name: userData.name, dormitory: userData.dormitory, floor: userData.floor, fridge: userData.fridge, password: userData.password)
            database.addUser(user: userItem)
            UserDefaults.standard.set(userItem.id, forKey: Constants.userId)
            
            self.handleSignInSuccess(completionBlock: completionBlock)
        }
    }
    
    func signIn(email: String, password: String, completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                completionBlock(false)
            } else {
                UserDefaults.standard.set(email, forKey: Constants.email)
                UserDefaults.standard.set(password, forKey: Constants.password)
                UserDefaults.standard.set(result?.user.uid, forKey: Constants.userId)
                self.userId = result?.user.uid ?? ""
                completionBlock(true)
            }
        }
    }
    
    func signInWithUserDefaults(completion: @escaping (Bool) -> Void) {
        guard let email = UserDefaults.standard.string(forKey: Constants.email),
              let password = UserDefaults.standard.string(forKey: Constants.password)
        else {
            completion(false)
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
    private func handleSignInSuccess(completionBlock: @escaping (_ success: Bool) -> Void) {
        completionBlock(true)
    }
}
