//
//  DatabaseAuthManager.swift
//  Fridge&Share
//
//  Created by Елизавета Шерман on 27.12.2023.
//

import UIKit
import FirebaseAuth



class FirebaseAuthManager {
    static let shared = FirebaseAuthManager()
    var userId: String = "" {
        didSet {
            print(oldValue, userId)
        }
    }

    func createUser(email: String, password: String, completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] (authResult, error) in
            guard let self = self, let user = authResult?.user else {
                completionBlock(false)
                return
            }
            UserDefaults.standard.set(email, forKey: "email")
            UserDefaults.standard.set(password, forKey: "password")
            self.userId = user.uid
            
            let userItem = User(id: user.uid, email: email, password: password)
            FireBase.shared.addUser(user: userItem, id: user.uid)
            
            self.handleSignInSuccess(completionBlock: completionBlock)
        }
    }
    func signInWithUserDefaults(completion: @escaping (Bool) -> Void) {
        guard let email = UserDefaults.standard.string(forKey: "email"),
                let password = UserDefaults.standard.string(forKey: "password")
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
    
    func getUserId() -> String {
        return Auth.auth().currentUser?.uid ?? ""
    }
    
    func setUserId(id: String) {
        userId = id
    }
    
    func signIn(email: String, pass: String, completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: pass) { (result, error) in
            if let error = error {
                completionBlock(false)
            } else {
                UserDefaults.standard.set(email, forKey: "email")
                UserDefaults.standard.set(pass, forKey: "password")
                completionBlock(true)
            }
        }
    }
    
    private func handleSignInSuccess(completionBlock: @escaping (_ success: Bool) -> Void) {
        // Дополнительные действия при успешной аутентификации
        // Например, загрузка данных пользователя и обновление интерфейса
        
        // Вызов блока завершения для сообщения об успешной аутентификации
        completionBlock(true)
    }
}
