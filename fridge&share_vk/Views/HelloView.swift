//
//  HelloView.swift
//  fridge&share_vk
//
//  Created by Елизавета Шерман on 17.04.2024.
//

import SwiftUI

struct HelloView: View {
    private enum Constants {
        static let isLoggedIn = "isLoggedIn"
        static let helloLabel = "Привет! Это Fridge&Share!"
        static let signInButton = "Войти"
        static let registrateButton = "Зарегистрироваться"
    }
    
    @State private var isLoggedIn: Bool = UserDefaults.standard.bool(forKey: Constants.isLoggedIn)
    
    @EnvironmentObject var userData: UserData
    
    @State private var loginIsActive = false
    @State private var registrationIsActive = false
    
    var body: some View {
        NavigationView {
            if isLoggedIn {
                TabBar(user: _userData)
            } else {
                VStack {
                    Text(Constants.helloLabel)
                    
                    NavigationLink(
                        destination: LoginView(shouldPopToRootView: self.$loginIsActive, updateParentState: { self.isLoggedIn = true }),
                        isActive: self.$loginIsActive
                    ) {
                        Text(Constants.signInButton)
                    }.isDetailLink(false)
                        .padding()
                    
                    NavigationLink(
                        destination: RegistrationView(rootIsActive: self.$registrationIsActive),
                        isActive: self.$registrationIsActive
                    ) {
                        Text(Constants.registrateButton)
                    }.isDetailLink(false)
                }
            }
        }
        .onAppear {
            isLoggedIn = UserDefaults.standard.bool(forKey: Constants.isLoggedIn)
        }
    }
}

#Preview {
    HelloView()
        .environmentObject(UserData())
}

