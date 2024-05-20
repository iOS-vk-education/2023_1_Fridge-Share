//
//  DatabaseManager.swift
//  fridge&share_vk
//
//  Created by Елизавета Шерман on 17.04.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage
import SwiftUI

class FireBase: ObservableObject {
    private enum Constants {
        static let dormitories = "dormitories"
        static let floors = "floors"
        static let products = "products"
        static let users = "users"
        static let fridges = "fridges"
        static let avatars = "avatars"
        static let requests = "requests"
    }
    @Published var isLoading = false
    static let shared = FireBase()
    let database = Firestore.firestore()
    let storage = Storage.storage()
    
    private init() {}
    
    @Published
    var dormitories: [DormitoryData] = []
    
    @Published
    var floors: [FloorData] = []
    
    @Published
    var fridges: [FridgeData] = []
    
    @Published
    var products: [ProductData] = []
    
    @Published
    var productsInMyFridge: [ProductData] = []
    
    @Published
    var requests: [RequestData] = []
    
    @Published
    var myAnswers: [RequestData] = []
    
    @Published
    var myRequests: [RequestData] = []
    
    func addDormitory(dormitoryData: DormitoryData) {
        do {
            let documentRef = try database.collection(Constants.dormitories).addDocument(from: dormitoryData)
            print("Общежитие успешно добавлено с идентификатором: \(documentRef.documentID)")
        } catch {
            print("Ошибка при добавлении общежития: \(error.localizedDescription)")
        }
    }
    
//    func addProduct(productData: ProductData) {
//        do {
//            let documentRef = try database.collection(Constants.products).addDocument(from: productData)
//            print("Продукт успешно добавлено с идентификатором: \(documentRef.documentID)")
//        } catch {
//            print("Ошибка при добавлении продукта: \(error.localizedDescription)")
//        }
//    }
    func addProduct(productData: ProductData) {
        do {
            let documentRef = try database.collection(Constants.products).document(productData.id).setData(from: productData)
            print("Product successfully added with ID: \(productData.id)")
        } catch {
            print("Error adding product: \(error.localizedDescription)")
        }
    }

    
    func getAllDormitories() {
        isLoading = true
        dormitories.removeAll()
        database.collection(Constants.dormitories).getDocuments { [weak self] (querySnapshot, error) in
            guard (querySnapshot?.documents) != nil else {
                print("No documents")
                return
            }
            
            for document in querySnapshot!.documents {
                do {
                    let dormitoryData = try document.data(as: DormitoryData.self)
                    self?.getAllFloorsInDormitory(dormitoryFloors: dormitoryData.floors) { floors in
                        self?.floors = floors
                    }
                    self?.dormitories.append(dormitoryData)
                    self?.isLoading = false
                } catch {
                    print(error)
                    fatalError("Could not fetch dormitory data")
                }
            }
        }
    }

    func getAllProducts() {
        products.removeAll()
        database.collection(Constants.products).getDocuments { [weak self] (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            for document in documents {
                do {
                    let productData = try document.data(as: ProductData.self)
                    DispatchQueue.main.async {
                        self?.products.append(productData)
                    }
                } catch {
                    print("Error decoding product data: \(error)")
                }
            }
        }
    }

    func getFridgeById(fridgeId: String, completion: @escaping (FridgeData?) -> Void) {
        productsInMyFridge.removeAll()
        let docRef = database.collection(Constants.fridges).document(fridgeId)
        docRef.getDocument { [weak self] (document, error) in
            guard let self = self else { return }
            if let document = document, document.exists {
                do {
                    let fridgesData = try document.data(as: FridgeData.self)
                    self.getAllProductsInFridge(fridgeProducts: fridgesData.products) { products in
                        DispatchQueue.main.async {
                            self.productsInMyFridge = products
                            completion(fridgesData)
                        }
                    }
                } catch {
                    print("Error decoding fridge data:", error)
                    completion(nil)
                }
            } else {
                print("Document for fridge ID \(fridgeId) does not exist")
                completion(nil)
            }
        }
    }

    
    func getAllProductsInFridge(fridgeProducts: [String], completion: @escaping ([ProductData]) -> Void) {
        var products = [ProductData]()
        var completedCount = 0
        
        for productId in fridgeProducts {
            getProductById(productId: productId) { productData in
                if let productData = productData {
                    products.append(productData)
                }
                completedCount += 1
                if completedCount == fridgeProducts.count {
                    completion(products)
                }
            }
        }
    }
    
    func getFloorById(floorId: String, completion: @escaping (FloorData?) -> Void) {
        let docRef = database.collection(Constants.floors).document(floorId)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                do {
                    var floorData = try document.data(as: FloorData.self)
                    self.getAllFridgesInFloor(floorFridges: floorData.fridges) { fridges in
                        self.fridges = fridges
                    }
                    completion(floorData)
                    
                } catch {
                    print("Error decoding floor data:", error)
                    completion(nil)
                }
            } else {
                print("Document for floor ID \(floorId) does not exist")
                completion(nil)
            }
        }
    }
    
    
    func getAllFloorsInDormitory(dormitoryFloors: [String], completion: @escaping ([FloorData]) -> Void) {
        var floors = [FloorData]()
        var completedCount = 0
        
        for floorId in dormitoryFloors {
            getFloorById(floorId: floorId) { floorData in
                if let floorData = floorData {
                    floors.append(floorData)
                }
                completedCount += 1
                if completedCount == dormitoryFloors.count {
                    floors.reverse()
                    completion(floors)
                }
            }
        }
    }
    
    func addProductToFridge(fridgeID: String, productID: String) {
        // Создаем ссылку на документ холодильника в коллекции "fridges"
        let fridgeRef = database.collection(Constants.fridges).document(fridgeID)
        
        // Обновляем данные холодильника
        fridgeRef.getDocument { (document, error) in
            if let document = document, document.exists {
                var data = document.data() ?? [:]
                if var productIDs = data["products"] as? [String] {
                    // Проверяем, есть ли уже этот продукт в массиве
                    if !productIDs.contains(productID) {
                        productIDs.append(productID)
                        data["products"] = productIDs
                        fridgeRef.setData(data) { error in
                            if let error = error {
                                print("Ошибка при добавлении продукта в холодильник: \(error)")
                            } else {
                                print("Продукт успешно добавлен в холодильник.")
                            }
                        }
                    } else {
                        print("Этот продукт уже есть в холодильнике.")
                    }
                } else {
                    print("Ошибка: массив productIDs не найден в данных холодильника.")
                }
            } else {
                print("Холодильник с указанным ID не найден.")
            }
        }
    }
    
    
    
    func getAllFridgesInFloor(floorFridges: [String], completion: @escaping ([FridgeData]) -> Void) {
        var fridges = [FridgeData]()
        var completedCount = 0
        
        for fridgeId in floorFridges {
            getFridgeById(fridgeId: fridgeId) { fridgeData in
                if let fridgeData = fridgeData {
                    fridges.append(fridgeData)
                }
                completedCount += 1
                if completedCount == floorFridges.count {
                    completion(fridges)
                }
            }
        }
    }
    
    func getProductById(productId: String, completion: @escaping (ProductData?) -> Void) {
        let docRef = database.collection(Constants.products).document(productId)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                do {
                    let productData = try document.data(as: ProductData.self)
                    completion(productData)
                    
                } catch {
                    print("Error decoding product data:", error)
                    completion(nil)
                }
            } else {
                print("Document for product ID \(productId) does not exist")
                completion(nil)
            }
        }
    }
    
    func getUserById(userId: String, completion: @escaping (UserData?) -> Void) {
        let docRef = database.collection(Constants.users).document(userId)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                do {
                    let userData = try document.data(as: UserData.self)
                    completion(userData)
                    
                } catch {
                    print("Error decoding user data:", error)
                    completion(nil)
                }
            } else {
                print("Document for user ID \(userId) does not exist")
                completion(nil)
            }
        }
    }
    
    func addUser(user: UserData) {
        do {
            let documentRef: () = try database.collection(Constants.users).document(user.id).setData(from: user)
            print("Пользователь успешно добавлен с идентификатором: \(user.id)")
        } catch {
            print("Ошибка при добавлении пользователь: \(error.localizedDescription)")
        }
    }
    
    func uploadAvatar(completion: @escaping (UIImage) -> Void) {
        let ref = storage.reference().child(Constants.avatars).child("acc9b03f77ce79cfae5f2f28e313ab7f.jpg")
        ref.getData(maxSize: (1 * 1024 * 1024)) { (data, error) in
            if let _error = error{
                print(_error)
            } else {
                if let _data  = data {
                    let myImage:UIImage! = UIImage(data: _data)
                    completion(myImage)
                }
            }
        }
    }

    func uploadAvatar(avatarFileName: String, completion: @escaping (UIImage?) -> Void) {
        let ref = self.storage.reference().child(Constants.avatars).child(avatarFileName)
        ref.getData(maxSize: (1 * 1024 * 1024)) { (data, error) in
            if let _error = error {
                print(_error)
                completion(nil)
            } else if let _data = data {
                let image = UIImage(data: _data)
                completion(image)
            }
        }
    }
    
    
    func uploadProduct(productName: String, completion: @escaping (UIImage) -> Void) {
        let ref = storage.reference().child(Constants.products).child(productName)
        ref.getData(maxSize: (2 * 1024 * 1024)) { (data, error) in
            if let _error = error{
                print(_error)
            } else {
                if let _data  = data {
                    let myImage:UIImage! = UIImage(data: _data)
                    completion(myImage)
                }
            }
        }
    }
    
    func uploadProductImage(productName: String, image: UIImage, completion: @escaping (Result<URL, Error>) -> Void) {
        let storageRef = Storage.storage().reference().child("products/\(productName)")
        print("products/\(productName)")
        if let imageData = image.jpegData(compressionQuality: 0.4) {
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            
            storageRef.putData(imageData, metadata: metadata) { metadata, error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    storageRef.downloadURL { url, error in
                        if let error = error {
                            completion(.failure(error))
                        } else if let url = url {
                            completion(.success(url))
                        }
                    }
                }
            }
        } else {
            completion(.failure(NSError(domain: "ImageError", code: -2, userInfo: [NSLocalizedDescriptionKey: "Не удалось конвертировать изображение"])))
        }
    }
    
    
    func deleteProduct(productID: String) {
        // Удаляем продукт из таблицы products
        let productRef = database.collection(Constants.products).document(productID)
        productRef.delete { error in
            if let error = error {
                print("Ошибка при удалении продукта из таблицы products:", error.localizedDescription)
                return
            } else {
                print("Продукт успешно удален из таблицы products")
            }
        }

        // Удаляем идентификатор продукта из холодильников в таблице fridges
        let fridgesRef = database.collection(Constants.fridges)
        fridgesRef.getDocuments { snapshot, error in
            if let error = error {
                print("Ошибка при получении данных из таблицы fridges:", error.localizedDescription)
                return
            }

            guard let snapshot = snapshot else {
                print("Данные из таблицы fridges не найдены")
                return
            }

            for document in snapshot.documents {
                let fridgeRef = document.reference
                fridgeRef.updateData(["products": FieldValue.arrayRemove([productID])]) { error in
                    if let error = error {
                        print("Ошибка при обновлении данных холодильника:", error.localizedDescription)
                    } else {
                        print("Идентификатор продукта успешно удален из холодильника")
                    }
                }
            }
        }
    }

    func updateProduct(product: ProductData, completion: @escaping (Result<Void, Error>) -> Void) {
        let productRef = database.collection(Constants.products).document(product.id)
        
        do {
            try productRef.setData(from: product, merge: true) { error in
                if let error = error {
                    print("Ошибка при обновлении продукта: \(error.localizedDescription)")
                    completion(.failure(error))
                } else {
                    print("Продукт успешно обновлен")
                    completion(.success(()))
                }
            }
        } catch {
            print("Ошибка при кодировании данных продукта: \(error.localizedDescription)")
            completion(.failure(error))
        }
    }

    func addRequest(requestData: RequestData) {
        do {
            let documentRef = try database.collection(Constants.requests).document(requestData.id).setData(from: requestData)
            print("Request successfully added with ID: \(requestData.id)")
        } catch {
            print("Error adding request: \(error.localizedDescription)")
        }
    }

    func getAllRequests() {
        requests.removeAll()
        database.collection(Constants.requests).getDocuments { [weak self] (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
                return
            }
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            self?.requests.removeAll() // Убедитесь, что массив очищен перед добавлением новых данных
            for document in documents {
                do {
                    let requestData = try document.data(as: RequestData.self)
                    DispatchQueue.main.async {
                        self?.requests.append(requestData)
                    }
                } catch {
                    print("Error decoding request data: \(error)")
                }
            }
        }
    }

    
    func updateRequest(request: RequestData, completion: @escaping (Result<Void, Error>) -> Void) {
        let requestRef = database.collection(Constants.requests).document(request.id)
        
        do {
            try requestRef.setData(from: request, merge: true) { error in
                if let error = error {
                    print("Ошибка при обновлении запроса: \(error.localizedDescription)")
                    completion(.failure(error))
                } else {
                    print("Запрос успешно обновлен")
                    completion(.success(()))
                }
            }
        } catch {
            print("Ошибка при кодировании данных запроса: \(error.localizedDescription)")
            completion(.failure(error))
        }
    }
    
    func getMyAnswers(userId: String) {
        myAnswers.removeAll()
        myAnswers = requests.filter({ $0.ownerId == userId && $0.status == statusOfRequest.waiting.rawValue })
    }
    
    func getMyRequests(userId: String) {
        myRequests.removeAll()
        myRequests = requests.filter({ $0.customerId == userId })
    }
}

