//
//  RegistrateDormitoryView.swift
//  fridge&share_vk
//
//  Created by Елизавета Шерман on 17.04.2024.
//

import SwiftUI

struct RegistrateDormitoryView: View {
    private enum Constants {
        static let navigationTitle = "Выбери общежитие!"
    }
    
    @StateObject
    var database = FireBase.shared
    
    @EnvironmentObject var userData: UserData
    
    @Binding var preRootIsActive : Bool
    
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        List {
            ForEach(database.dormitories, id: \.self) { dormitory in
                NavigationLink(destination: FloorsView(dormitory: dormitory, twoPreRootIsActive: self.$preRootIsActive, isLoggedIn: self.$isLoggedIn)) {
                    VStack(alignment: .leading) {
                        Text(dormitory.name)
                        Text(dormitory.address)
                    }
                }
                .isDetailLink(false)
                .buttonStyle(PlainButtonStyle())
                .background(
                    Button(action: {
                        userData.dormitory = dormitory.name
                    }, label: {
                        EmptyView()
                    })
                )
            }
        }.navigationTitle(Constants.navigationTitle)
    }
}
