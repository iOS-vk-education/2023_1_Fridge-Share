//
//  SearchView.swift
//  fridge&share_vk
//
//  Created by Елизавета Шерман on 17.04.2024.
//

import SwiftUI

struct SearchView: View {
    private enum Constants {
        static let navigationTitle = "Ищем продукт"
    }

    @State private var searchText = ""
    @State private var searchIsActive = false
    
    @StateObject
    var database = FireBase.shared
    
    var body: some View {
        if #available(iOS 16.0, *) {
            if #available(iOS 17.0, *) {
                    NavigationStack {
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
                        
                    }
                    .searchable(text: $searchText, isPresented: $searchIsActive)
                    .onAppear {
                        database.getAllProducts()
                    }
            } else {
                
            }
        } else {
            
        }
    }
    
    var searchResults: [ProductData] {
        if searchText.isEmpty {
            return database.products
        } else {
            return database.products.filter { $0.name.contains(searchText) }
        }
    }
}

#Preview {
    SearchView()
}



struct LoadingView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .gray))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}

