//
//  ProductRowView.swift
//  fridge&share_vk
//
//  Created by Елизавета Шерман on 17.04.2024.
//

import SwiftUI

struct ProductRowView: View {
    private enum Constants {
        static let imageFrame: CGFloat = 72
        static let imageCornerRadius: CGFloat = 12
    }
    
    @State var product: ProductData
    var database = FireBase.shared
    
    @State private var productImage: UIImage?
    var body: some View {
        HStack {
            if let image = productImage {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: Constants.imageFrame, height: Constants.imageFrame)
                    .clipShape(RoundedRectangle(cornerRadius: Constants.imageCornerRadius))
            } else {
                ProgressView()
                    .frame(width: Constants.imageFrame, height: Constants.imageFrame)
            }
            VStack(alignment: .leading) {
                Text(product.name)
                if #available(iOS 15.0, *) {
                    Text(String(product.status)).font(.caption).foregroundStyle(.secondary)
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

