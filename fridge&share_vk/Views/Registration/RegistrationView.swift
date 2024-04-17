//
//  RegistrationView.swift
//  fridge&share_vk
//
//  Created by Елизавета Шерман on 17.04.2024.
//

import SwiftUI

struct RegistrationView: View {
    private enum Constants {
        static let username = "Username"
        static let email = "Email"
        static let password = "Password"
        static let letMeetLabel = "Давайте познакомимся!"
        static let nextButton = "Дальше!"
    }
    
    @State var username: String = ""
    @State var email: String = ""
    @State var password: String = ""
    
    @EnvironmentObject var userData: UserData
    
    @Binding var rootIsActive : Bool
    
    var body: some View {
        VStack {
            Text(Constants.letMeetLabel)
                .padding()
            
            TextField(Constants.username, text: $username)
                .frame(width: 200, height: 50, alignment: .center)
                .textFieldStyle(.roundedBorder)
            
            TextField(Constants.email, text: $email)
                .frame(width: 200, height: 50, alignment: .center)
                .textFieldStyle(.roundedBorder)
            
            SecureField(Constants.password, text: $password)
                .frame(width: 200, height: 50, alignment: .center)
                .textFieldStyle(.roundedBorder)
            
            NavigationLink(
                destination: RegistrateDormitoryView(preRootIsActive: self.$rootIsActive)
                    .onAppear {
                        userData.name = username
                        userData.email = email
                        userData.password = password
                    }
            ) {
                Text(Constants.nextButton)
            }
            .isDetailLink(false)
        }
    }
}

