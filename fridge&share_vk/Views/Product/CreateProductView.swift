import SwiftUI

struct CreateProductView: View {
    @State var selectedCategoryIndex: Int?
    @State var expirationDate = Date()
    @State var isShowingImagePicker = false
    @State var selectedImage: UIImage?
    @State var productName = ""
    
    @StateObject var database = FireBase.shared
    
    var userId = UserDefaults.standard.string(forKey: "userId")
    @StateObject var user: UserData
    
    @State var showingAlert = false
    @Binding var shouldPopUp: Bool
    
    let categories = ["Молоко и яйца", "Сладкое", "Мясо и рыба", "Фрукты и овощи", "Соусы", "Готовая еда", "Напитки"]
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Button(action: {
                        self.isShowingImagePicker = true
                    }) {
                        if let image = selectedImage {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 200, height: 200)
                                .cornerRadius(10)
                        } else {
                            Image(systemName: "photo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 200, height: 200)
                                .cornerRadius(10)
                                .foregroundColor(.gray)
                        }
                    }
                    .sheet(isPresented: $isShowingImagePicker) {
                        ImagePicker(selectedImage: self.$selectedImage)
                    }
                    
                    CategoriesView(selectedCategoryIndex: $selectedCategoryIndex)
                    .padding()
                    
                    TextField("Название продукта", text: $productName)
                        .padding()
                    
                    DatePicker("Дата истечения срока годности", selection: $expirationDate, displayedComponents: .date)
                        .padding()
                    
                    Spacer()
                    
                    Button(action: {
                        let id = UUID().uuidString
                        let product = ProductData(id: id, name: productName, dateExploration: expirationDate, dateAdded: Date.now, userId: userId ?? "", status: statusOfProduct.available.rawValue, image: "\(id).jpeg", category: categories[selectedCategoryIndex ?? 0])
                        
                        database.uploadProductImage(productName: product.image, image: selectedImage ?? UIImage()) {_ in
                            
                        }
                        
                        database.addProduct(productData: product)
                        
                        database.addProductToFridge(fridgeID: user.fridge, productID: product.id)
                        
                        showingAlert = true
                        
                        productName = ""
                        
                    }) {
                        Text("Добавить")
                            .frame(width: 200, height: 50)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding()
                    }
                }
            }
            .navigationTitle("Добавить продукт")
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Успешно добавлено"), dismissButton: .default(Text("OK")) {
                    shouldPopUp = false
                    presentationMode.wrappedValue.dismiss()
                })
            }
        }
    }
}

struct CategoriesView: View {
    let categories = ["Молоко и яйца", "Сладкое", "Мясо и рыба", "Фрукты и овощи", "Соусы", "Готовая еда", "Напитки"]
    @Binding var selectedCategoryIndex: Int?

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 4) {
                ForEach(categories.indices, id: \.self) { index in
                    Button(action: {
                        self.selectedCategoryIndex = index
                    }) {
                        Text(self.categories[index])
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(self.selectedCategoryIndex == index ? Color.blue : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(self.selectedCategoryIndex == index ? Color.blue : Color.gray, lineWidth: 1)
                            )
                    }
                }
            }
            .padding(.vertical)
        }
    }
}


//struct AddProductView_Previews: PreviewProvider {
//    static var previews: some View {
//        CreateProductView()
//    }
//}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var presentationMode
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker
        
        init(parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

