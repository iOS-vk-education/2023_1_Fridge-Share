//
//  MyProductsView.swift
//  fridge&share_vk
//
//  Created by Елизавета Шерман on 17.04.2024.
//

import SwiftUI

struct MyProducts: View {
    private enum Constants {
        static let navigationTitle = "Мои продукты"
    }
    
    @StateObject var user: UserData
    
    @StateObject var database = FireBase.shared
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            ProductAddButton(user: user)
            
            List {
                ForEach(searchResults, id: \.self) { product in
                    NavigationLink {
                        OneProductView(product: product)
                    } label: {
                        ProductRowView(product: product)
                    }
                }
            }
            .listStyle(.plain)
        }
        .navigationTitle(Constants.navigationTitle)
        .onAppear {
//            if database.products.isEmpty {
                database.getAllProducts()
//            }
        }
    }
    
    var searchResults: [ProductData] {
        return database.products.filter { $0.userId == user.id }
    }
}

struct ProductAddButton: View {
    @State private var addingIsActive = false
    @StateObject var user: UserData
    
    var body: some View {
        Button(action: {

        }, label: {
            NavigationLink(destination: CreateProductView(user: user, shouldPopUp: self.$addingIsActive), isActive: self.$addingIsActive,
                           label: {
                Text("Добавить продукт")
                    .foregroundColor(.white)
            })
        })
        .buttonStyle(BlueButtonStyle())
        .padding(35)
        .cornerRadius(10)
    }
}
