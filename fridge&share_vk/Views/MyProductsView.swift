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
    
    @EnvironmentObject var user: UserData
    
    var database = FireBase.shared
    
    var body: some View {
        List {
            ForEach(searchResults, id: \.self) { product in
                NavigationLink {
                    OneProductView(product: product)
                } label: {
                    ProductRowView(product: product)
                }
            }
        }
        .navigationTitle(Constants.navigationTitle)
        .onAppear {
            database.getAllProducts()
        }
    }
    
    var searchResults: [ProductData] {
        return database.products.filter { $0.userId == user.id }
    }
}
