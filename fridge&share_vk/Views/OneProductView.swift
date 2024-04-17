//
//  OneProductView.swift
//  fridge&share_vk
//
//  Created by Елизавета Шерман on 17.04.2024.
//

import SwiftUI

struct OneProductView: View {
    @State var product: ProductData
    
    @State private var productImage: UIImage?
    
    var database = FireBase.shared
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Spacer()
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
                HStack {
                    Text(String(product.name))
                        .font(.largeTitle)
                        .padding(20)
                    Spacer()
                    Text(String(product.status))
                        .font(.title3)
                        .foregroundColor(.green)
                        .padding(30)
                }
                Text("Срок хранения")
                    .font(.title3)
                    .foregroundColor(.gray)
                    .padding(.leading, 20)
                    .padding(.bottom, 5)
                Text("\(product.dateExploration) суток")
                    .font(.title2)
                    .foregroundColor(.green)
                    .padding(.leading, 20)
                    .padding(.bottom, 20)
                
                HStack {
                    Image("ava1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .padding(.trailing, 10)
                    Text("Никнейм")
                        .font(.title3)
                }
                .padding(20)
                .cornerRadius(10)
                Button(action: {}) {
                    Text("Удалить")
                        .foregroundColor(.white)
                }
                .buttonStyle(RedButtonStyle())
                .padding(35)
                .cornerRadius(10)
                Divider()
                Text("Похожие продукты")
                    .font(.title)
                    .padding(20)
                ScrollView(.horizontal){
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
        .onAppear {
            database.uploadProduct(productName: product.image) {
                image in
                self.productImage = image
            }
        }
    }
}
