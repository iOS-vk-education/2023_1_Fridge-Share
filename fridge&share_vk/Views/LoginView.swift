//
//  LoginView.swift
//  fridge&share_vk
//
//  Created by Елизавета Шерман on 17.04.2024.
//

import SwiftUI

struct LoginView: View {
    private enum Constants {
        static let enterLabel = "Вводи почту и пароль!"
        static let email = "Email"
        static let password = "Password"
        static let successfulLogin = "Вы успешно вошли в учетную запись"
        static let failureLogin = "Данные введены неверно!"
        static let isLoggedIn = "isLoggedIn"
        static let okButton = "OK"
        static let enterButton = "Войти"
        static let userId = "userId"
        static let fieldWidth: CGFloat = 200
        static let fieldHeight: CGFloat = 50
    }
    
    @Binding var shouldPopToRootView : Bool
    
    @State var email: String = ""
    @State var password: String = ""
    @State var loginDidSucceed: ((Bool) -> Void)?
    var authManager = FireBaseAuthManager.shared
    @State var showingAlert = false
    @State var message: String = ""
    
    var updateParentState: () -> Void
    
    @EnvironmentObject var userData: UserData
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text(Constants.enterLabel)
            
            TextField(Constants.email, text: $email) {
                UIApplication.shared.endEditing()
            }
                .frame(width: Constants.fieldWidth, height: Constants.fieldHeight, alignment: .center)
                .textFieldStyle(.roundedBorder)
            
            SecureField(Constants.password, text: $password) {
                UIApplication.shared.endEditing()
            }
                .frame(width: Constants.fieldWidth, height: Constants.fieldHeight, alignment: .center)
                .textFieldStyle(.roundedBorder)
            
            Button(action: {
                authManager.signIn(email: email, password: password) {(success) in
                    DispatchQueue.main.async {
                        if success {
                            message = Constants.successfulLogin
                            loginDidSucceed?(true)
                            UserDefaults.standard.setValue(true, forKey: Constants.isLoggedIn)
                        } else {
                            message = Constants.failureLogin
                            UserDefaults.standard.setValue(false, forKey: Constants.isLoggedIn)
                            loginDidSucceed?(false)
                        }
                        showingAlert = true
                    }
                }
            }, label: {
                Text(Constants.enterButton)
            })
            .alert(isPresented: .constant(message.isEmpty)) {
                Alert(title: Text("Подождите"), message: Text("Загрузка..."), dismissButton: .none)
            }
            .alert(isPresented: .constant(!message.isEmpty)) {
                Alert(title: Text(message.isEmpty ? "Ошибка!" : "Успех!"), message: Text(message.isEmpty ? Constants.failureLogin : message), dismissButton: .default(Text(Constants.okButton)) {
                    fetchUserProfile()
                    updateParentState()
                    shouldPopToRootView = false
                })
            }
        }
        .dismissKeyboardOnTap()
    }
    
    private func fetchUserProfile() {
        if let userId = UserDefaults.standard.string(forKey: Constants.userId) {
            FireBase.shared.getUserById(userId: userId) { user in
                if let user = user {
                    userData.name = user.name
                    userData.email = user.email
                    userData.password = user.password
                    userData.dormitory = user.dormitory
                    userData.floor = user.floor
                    userData.fridge = user.fridge
                    userData.id = userId
                    userData.avatar = user.avatar
                }
            }
        }
    }
}
