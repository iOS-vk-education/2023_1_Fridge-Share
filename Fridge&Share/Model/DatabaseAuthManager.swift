//
//  DatabaseAuthManager.swift
//  Fridge&Share
//
//  Created by Елизавета Шерман on 27.12.2023.
//

import UIKit
import FirebaseAuth



class FirebaseAuthManager {
//    static let shared = FirebaseAuthManager()
//    var userId: String = ""
//    func createUser(email: String, password: String, completionBlock: @escaping (_ success: Bool) -> Void) {
//        Auth.auth().createUser(withEmail: email, password: password) {(authResult, error) in
//            if let user = authResult?.user {
//                let userItem = User(id: user.uid, email: email, password: password)
//                listOfUsers.append(userItem)
//                FireBase.shared.addUser(user: userItem, id: user.uid)
//                completionBlock(true)
//            } else {
//                completionBlock(false)
//            }
//        }
//    }
    static let shared = FirebaseAuthManager()
        var userId: String = ""

    func createUser(email: String, password: String, completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] (authResult, error) in
            guard let self = self, let user = authResult?.user else {
                completionBlock(false)
                return
            }
            
            // Update userId in FirebaseAuthManager
            self.userId = user.uid
            
            let userItem = User(id: user.uid, email: email, password: password)
            FireBase.shared.addUser(user: userItem, id: user.uid)
            
            // Use completion block to indicate success
            self.handleSignInSuccess(completionBlock: completionBlock)
        }
    }
    
    func getUserId() -> String {
        return userId
    }
    
    func setUserId(id: String) {
        userId = id
    }
    
    func signIn(email: String, pass: String, completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: pass) { (result, error) in
            if let error = error {
                completionBlock(false)
            } else {
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
