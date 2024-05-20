//
//  MyAnswersRowView.swift
//  fridge&share_vk
//
//  Created by Елизавета Шерман on 19.05.2024.
//

import SwiftUI

struct MyAnswersRowView: View {
    @State var request: RequestData
    
    @StateObject private var database = FireBase.shared
    @State private var productImage: UIImage?
    @State private var profileImage: UIImage?
    @State private var productName = ""
    
    @State private var isButtonTapped: Bool = false
    
    var body: some View {
        VStack(alignment: .listRowSeparatorLeading) {
            HStack {
                if let productImage = productImage {
                    Image(uiImage: productImage)
                        .resizable()
                        .frame(width: 60, height: 60)
                        .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                } else {
                    ProgressView()
                        .frame(width: 60, height: 60)
                }
                
                Text(productName)
                
                Spacer()
                
                if let profileImage = profileImage {
                    Image(uiImage: profileImage)
                        .resizable()
                        .frame(width: 60, height: 60)
                        .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                        .clipShape(Circle())
                } else {
                    ProgressView()
                        .frame(width: 60, height: 60)
                }
            }
            
            HStack {
                Button(action: {
                    if !isButtonTapped {
                        isButtonTapped = true
                        print("Approve button tapped")
                        buttonTapped(status: statusOfRequest.allowed.rawValue)
                    }
                }, label: {
                    Image(systemName: "checkmark")
                        .foregroundColor(.white)
                        .frame(width: 100, height: 30)
                        .background(.green)
                        .cornerRadius(10)
                })
                
                Button(action: {
                    if !isButtonTapped {
                        isButtonTapped = true
                        print("Deny button tapped")
                        buttonTapped(status: statusOfRequest.denied.rawValue)
                    }
                }, label: {
                    Image(systemName: "multiply")
                        .foregroundColor(.white)
                        .frame(width: 100, height: 30)
                        .background(.red)
                        .cornerRadius(10)
                })
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
            
            database.getUserById(userId: request.customerId) { customer in
                if let customer = customer {
                    if let cachedImage = ImageCache.shared.getImage(for: customer.avatar) {
                        self.profileImage = cachedImage
                    } else {
                        database.uploadAvatar(avatarFileName: customer.avatar) { image in
                            self.profileImage = image
                        }
                    }
                }
            }
        }
    }
    
//    private func buttonTapped(status: String) {
//        request.status = status
//        database.updateRequest(request: request) { result in
//            switch result {
//            case .success:
//                database.getProductById(productId: request.productId) { product in
//                    guard var updatedProduct = product else { return }
//                    if status == statusOfRequest.allowed.rawValue {
//                        updatedProduct.status = statusOfProduct.given.rawValue
//                    } else {
//                        updatedProduct.status = statusOfProduct.available.rawValue
//                    }
//                    
//                    database.updateProduct(product: updatedProduct) { result in
//                        switch result {
//                        case .success:
//                            // Вызов метода getAllRequests для обновления данных в таблице с ответами
//                            database.getAllRequests()
//                            isButtonTapped = false
//                        case .failure(let error):
//                            print("Error updating product: \(error.localizedDescription)")
//                        }
//                    }
//                }
//            case .failure(let error):
//                print("Error updating request: \(error.localizedDescription)")
//                isButtonTapped = false
//            }
//        }
//    }
    private func buttonTapped(status: String) {
        request.status = status
        print(status)
        database.updateRequest(request: request) { _ in
            database.getProductById(productId: request.productId) { product in
                var newProduct = product
                if status == statusOfRequest.allowed.rawValue {
                    newProduct?.status = statusOfProduct.given.rawValue
                } else {
                    newProduct?.status = statusOfProduct.available.rawValue
                }
                
                if let product = newProduct {
                    database.updateProduct(product: product) { _ in
                        // Обновляем список запросов после изменения статуса
                        database.getAllRequests()
                    }
                }
            }
        }
    }

    
}

//#Preview {
//    MyAnswersRowView()
//}

