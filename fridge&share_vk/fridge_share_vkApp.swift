//
//  fridge_share_vkApp.swift
//  fridge&share_vk
//
//  Created by Елизавета Шерман on 17.04.2024.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseStorage

@main
struct dataBaseApp: App {
    private enum Constants {
        static let isLoggedIn = "isLoggedIn"
        static let userId = "userId"
    }
    
    @State var userData: UserData?
    let isLoggedIn = UserDefaults.standard.bool(forKey: Constants.isLoggedIn)
    let userId = UserDefaults.standard.string(forKey: Constants.userId)

    init() {
        FirebaseApp.configure()
        FireBase.shared.getAllDormitories()
        
    }

    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                if let userId = userId {
                    let _: ()? = FireBase.shared.getUserById(userId: userId) { user in
                        userData = user
                    }
                }
            }
            HelloView()
                .environmentObject(userData ?? UserData())
        }
    }
}


