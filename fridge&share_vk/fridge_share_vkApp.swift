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
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate

    private enum Constants {
        static let isLoggedIn = "isLoggedIn"
        static let userId = "userId"
    }
    
    @StateObject var fireBase = FireBase.shared
    
    @State var userData: UserData?
    let isLoggedIn = UserDefaults.standard.bool(forKey: Constants.isLoggedIn)
    let userId = UserDefaults.standard.string(forKey: Constants.userId)

    init() {
        FirebaseApp.configure()
        fireBase.getAllDormitories()
    }

    var body: some Scene {
        WindowGroup {
            if fireBase.isLoading {
                LoaderView()
            } else {
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
}


