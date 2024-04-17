//
//  MyFridgeView.swift
//  fridge&share_vk
//
//  Created by Елизавета Шерман on 17.04.2024.
//

import SwiftUI

struct MyFridge: View {
    private enum Constants {
        static let naviagtionTitle = "Мой холодильник"
    }
    
    @EnvironmentObject var user: UserData
    
    var database = FireBase.shared
    
    var body: some View {
        List {
            ForEach(database.productsInMyFridge, id: \.self) { product in
                NavigationLink {
                    OneProductView(product: product)
                } label: {
                    ProductRowView(product: product)
                }
            }
        }
        .navigationTitle(Constants.naviagtionTitle)
        .onAppear {
            database.getFridgeById(fridgeId: user.fridge) { _ in
                
            }
        }
    }
}
