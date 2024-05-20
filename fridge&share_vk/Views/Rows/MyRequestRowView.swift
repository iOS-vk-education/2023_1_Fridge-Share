//
//  MyRequestRowView.swift
//  fridge&share_vk
//
//  Created by Елизавета Шерман on 19.05.2024.
//

import SwiftUI

struct MyRequestRowView: View {
    @State var request: RequestData
    
    @StateObject private var database = FireBase.shared
    @State private var productImage: UIImage?
    @State private var productName = ""
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                if let productImage = productImage {
                    Image(uiImage: productImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 60)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                } else {
                    ProgressView()
                        .frame(width: 60, height: 60)
                }
                
                Text(productName)
                    .font(.body)
                
                Spacer()
                
                //            Text(DateFormatter.localizedString(from: request.product.dateExploration, dateStyle: .short, timeStyle: .none))
                //                .font(.subheadline)
                
                if request.status == statusOfRequest.allowed.rawValue {
                    //                Rectangle()
                    //                    .fill(Color.green)
                    //                    .frame(width: 10, height: 10)
                    Image(systemName: "checkmark.circle")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .aspectRatio(contentMode: .fill)
                        .padding(.leading, 20)
                        .foregroundColor(.green)
                } else if request.status == statusOfRequest.denied.rawValue {
                    //                Rectangle()
                    //                    .fill(Color.red)
                    //                    .frame(width: 10, height: 10)
                    Image(systemName: "multiply.circle")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .aspectRatio(contentMode: .fill)
                        .padding(.leading, 20)
                        .foregroundColor(.red)
                } else {
                    //                Rectangle()
                    //                    .fill(Color.secondary)
                    //                    .frame(width: 10, height: 10)
                    Image(systemName: "clock.arrow.circlepath")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .aspectRatio(contentMode: .fill)
                        .padding(.leading, 20)
                        .foregroundColor(.secondary)
                    //                    .clipShape(Circle())
                }
            }
        }
        .onAppear {
            database.getProductById(productId: request.productId) { product in
                if let product = product {
                    if let cachedImage = ImageCache.shared.getImage(for: product.image) {
                        self.productImage = cachedImage
                    } else {
                        database.uploadProduct(productName: product.image) { image in
                            self.productImage = image
                            ImageCache.shared.setImage(image, for: product.image)
                        }
                    }
                    
                    productName = product.name
                }
            }
        }
    }
}

//#Preview {
//    MyRequestRowView()
//}

