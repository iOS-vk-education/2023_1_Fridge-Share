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
    @State var userData: UserData? // User data
    @State var userId = UserDefaults.standard.string(forKey: Constants.userId)
    
    init() {
        FirebaseApp.configure()
        
        userId = UserDefaults.standard.string(forKey: Constants.userId)

        fireBase.getAllDormitories()
    }

    var body: some Scene {
        WindowGroup {
            if fireBase.isLoading {
                LoaderView()
                    .onAppear {
                        if let userId = userId {
                            FireBase.shared.getUserById(userId: userId) { user in
                                self.userData = user
                            }
                        }
                    }
            } else {
                HelloView()
                    .environmentObject(userData ?? UserData())
            }
        }
    }
}


extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
