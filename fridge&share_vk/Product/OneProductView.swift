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
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 5 * 2)
                    .cornerRadius(20)
                    .padding(20)
            } else {
                LoaderView()
                    .frame(height: UIScreen.main.bounds.height / 5 * 2)
                    .padding(20)
            }
        }
    }
}

struct ProductHeaderView: View {
    let productName: String
    let productStatus: String
    let productExpiration: Date
    
    var body: some View {
        HStack {
            Text(productName)
                .font(.largeTitle)
                .padding(45)
            
            Spacer()
            
            Text(productStatus)
                .font(.title3)
                .foregroundColor(statusColor)
                .padding(45)
        }
    }
    
    var statusColor: Color {
            switch productStatus {
            case statusOfProduct.given.rawValue:
                return .red
            case statusOfProduct.waiting.rawValue:
                return .gray
            default:
                return .green
            }
        }
}


struct ProductDetailsView: View {
    let productExpiration: Date
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Срок хранения")
                .font(.title3)
                .foregroundColor(.gray)
                .padding(.leading, 50)
                .padding(.bottom, 5)
            
            Text(dateFormatted(data: productExpiration))
                .font(.title2)
                .foregroundColor(expirationColor)
                .padding(.leading, 50)
                .padding(.bottom, 20)
        }
    }
    
    var expirationColor: Color {
           let currentDate = Date()
           let twoDaysFromNow = Calendar.current.date(byAdding: .day, value: 2, to: currentDate)!
           
           if productExpiration < currentDate {
               return .red
           } else if productExpiration <= twoDaysFromNow {
               return .orange
           } else {
               return .green
           }
       }
    
    func dateFormatted(data: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM yyyy"
        
        return formatter.string(from: data)
    }
}


struct ProductUserView: View {
    let username: String
    var profileImage: UIImage?
    
    var userId: String
    
    var body: some View {
        HStack {
            if let profileImage = profileImage {
                Image(uiImage: profileImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .padding(.leading, 25)
                    .padding(.trailing, 10)
            } else {
                ProgressView()
                    .frame(width: 50, height: 50)
                    .padding(.leading, 25)
                    .padding(.trailing, 10)
            }
            
            Text(username)
                .font(.title3)
        }
        .padding(20)
        .cornerRadius(10)
    }
}

struct ProductDeleteButton: View {
    var product: ProductData
    @Environment(\.presentationMode) var presentationMode
    @State var showingAlert = false
    
    var body: some View {
        Button(action: {
            FireBase.shared.deleteProduct(productID: product.id)
            showingAlert = true
        }) {
            Text("Удалить")
                .foregroundColor(.white)
        }
        .buttonStyle(RedButtonStyle())
        .padding(35)
        .cornerRadius(10)
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Продукт удален!"), dismissButton: .default(Text("OK")) {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct ProductAskButton: View {
    var body: some View {
        Button(action: {}) {
            Text("Попросить")
                .foregroundColor(.white)
        }
        .buttonStyle(BlueButtonStyle())
        .padding(35)
        .cornerRadius(10)
    }
}


struct OneProductView: View {
    @State var product: ProductData
    @State private var productImage: UIImage?
    @State private var profileImage: UIImage?
    @State private var username: String?
    var database = FireBase.shared
    
    let userId = UserDefaults.standard.string(forKey: "userId")
    @State var owner = UserData()
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Spacer()
                
                ProductImageView(productImage: productImage)
                
                ProductHeaderView(productName: product.name, productStatus: product.status, productExpiration: product.dateExploration)
               
                ProductDetailsView(productExpiration: product.dateExploration)
                
                ProductUserView(username: username ?? "nickname", profileImage: profileImage, userId: product.userId)
                
                if product.userId == userId {
                    
                    ProductDeleteButton(product: product)
                } else {
                    ProductAskButton()
                }
       
            }
        }
        .onAppear {
            FireBase.shared.getUserById(userId: product.userId) { user in
                if let user = user {
                    owner = user
                    FireBase.shared.uploadAvatar(avatarFileName: owner.avatar) { image in
                        self.profileImage = image
                    }
                    self.username = owner.name
                } else {
                    owner = UserData() // Default value if user is not found
                }
            }
            
            if let cachedImage = ImageCache.shared.getImage(for: product.image) {
                self.productImage = cachedImage
            } else {
                database.uploadProduct(productName: product.image) { image in
                    self.productImage = image
                    ImageCache.shared.setImage(image, for: product.image)
                }
            }
        }
    }
}
