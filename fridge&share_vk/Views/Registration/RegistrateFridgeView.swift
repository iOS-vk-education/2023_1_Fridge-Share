//
//  RegistrateFridgeView.swift
//  fridge&share_vk
//
//  Created by Елизавета Шерман on 17.04.2024.
//

import SwiftUI

struct FridgeView: View {
    private enum Constants {
        static let isLoggedIn = "isLoggedIn"
        static let okButton = "OK"
        static let successfulRegistration = "Регистрация прошла успешно!"
        static let navigationTitle = "Список холодильников на этаже"
    }
    
    @StateObject
    var database = FireBase.shared
    @StateObject
    var authentification = FireBaseAuthManager.shared
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var userData: UserData
    
    var floor: FloorData
    
    @State var fridges: [FridgeData] = []
    @State var isLoading = true
    
    @State var showingAlert = false
    
    @Binding var shouldPopToRootView : Bool
    
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        VStack {
            if isLoading {
                ProgressView()
            } else {
                List {
                    ForEach(fridges, id: \.self) { fridge in
                        VStack(alignment: .leading) {
                            Text(String(fridge.number))
                                .buttonStyle(PlainButtonStyle())
                                .background(
                                    Button(action: {
                                        userData.fridge = fridge.id
                                        authentification.createUser(userData: userData) {success in
                                            UserDefaults.standard.setValue(true, forKey: Constants.isLoggedIn)
                                        }
                                        showingAlert = true
                                    }, label: {
                                        EmptyView()
                                    })
                                    .alert(isPresented: $showingAlert, content: {
                                        Alert(title: Text(Constants.successfulRegistration), dismissButton: .default(Text(Constants.okButton), action: {
                                            self.isLoggedIn = true
                                            self.shouldPopToRootView = false
                                        }))
                                    })
                                )
                        }
                    }
                }
                .navigationTitle(Constants.navigationTitle)
            }
        }
        .onAppear {
            if fridges.isEmpty {
                database.getAllFridgesInFloor(floorFridges: floor.fridges) { fridges in
                    self.fridges = fridges
                    isLoading = false
                }
            }
        }
    }
}

