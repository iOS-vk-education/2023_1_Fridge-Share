//
//  MyFridgeView.swift
//  fridge&share_vk
//
//  Created by Елизавета Шерман on 17.04.2024.
//

import SwiftUI
import UserNotifications


struct MyFridge: View {
    private enum Constants {
        static let naviagtionTitle = "Мой холодильник"
    }
    
    @StateObject var user: UserData
    
    @StateObject var database = FireBase.shared
    
    @State private var isLoading = true
    
    var body: some View {
        Group {
            if isLoading {
                LoaderView()
            } else {
                List {
                    ForEach(database.productsInMyFridge, id: \.self) { product in
                        NavigationLink {
                            OneProductView(product: product)
                        } label: {
                            ProductRowView(product: product)
                        }
                    }
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle(Constants.naviagtionTitle)
        .onAppear {
            loadFridgeData()
        }
    }
    
    private func loadFridgeData() {
        isLoading = true
        database.getFridgeById(fridgeId: user.fridge) { fridge in
            isLoading = false
        }
    }
}
