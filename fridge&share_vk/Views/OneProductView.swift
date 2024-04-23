//
//  OneProductView.swift
//  fridge&share_vk
//
//  Created by Елизавета Шерман on 17.04.2024.
//

import SwiftUI

struct ProductImageView: View {
    let productImage: UIImage?
    
    var body: some View {
        Group {
            if let image = productImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: UIScreen.main.bounds.height / 5 * 2)
                    .cornerRadius(20)
                    .ignoresSafeArea()
                    .padding(20)
            } else {
                ProgressView()
            }
        }
    }
}

struct ProductHeaderView: View {
    let productName: String
    let productStatus: String
    let productExpiration: Int
    
    var body: some View {
        HStack {
            Text(productName)
                .font(.largeTitle)
                .padding(20)
            
            Spacer()
            
            Text(productStatus)
                .font(.title3)
                .foregroundColor(.green)
                .padding(30)
        }
    }
}

struct ProductDetailsView: View {
    let productExpiration: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Срок хранения")
                .font(.title3)
                .foregroundColor(.gray)
                .padding(.leading, 20)
                .padding(.bottom, 5)
            
            Text("\(productExpiration) суток")
                .font(.title2)
                .foregroundColor(.green)
                .padding(.leading, 20)
                .padding(.bottom, 20)
        }
    }
}

struct ProductUserView: View {
    let username: String
    
    var body: some View {
        HStack {
            Image("ava1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .padding(.trailing, 10)
            
            Text(username)
                .font(.title3)
        }
        .padding(20)
        .cornerRadius(10)
    }
}

struct ProductDeleteButton: View {
    var body: some View {
        Button(action: {}) {
            Text("Удалить")
                .foregroundColor(.white)
        }
        .buttonStyle(RedButtonStyle())
        .padding(35)
        .cornerRadius(10)
    }
}

struct SimilarProductsView: View {
    var body: some View {
        VStack {
            Divider()
            
            Text("Похожие продукты")
                .font(.title)
                .padding(20)
            
            ScrollView(.horizontal) {
                HStack {
                    Image("milk2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150)
                        .cornerRadius(10)
                    
                    Image("milk2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150)
                        .cornerRadius(10)
                }
            }
        }
    }
}

struct OneProductView: View {
    @State var product: ProductData
    @State private var productImage: UIImage?
    var database = FireBase.shared
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Spacer()
                
                ProductImageView(productImage: productImage)
                
                ProductHeaderView(productName: product.name, productStatus: product.status, productExpiration: product.dateExploration)
                
                ProductDetailsView(productExpiration: product.dateExploration)
                
                ProductUserView(username: "Никнейм")
                
                ProductDeleteButton()
                
                SimilarProductsView()
            }
        }
        .onAppear {
            database.uploadProduct(productName: product.image) { image in
                self.productImage = image
            }
        }
    }
}
