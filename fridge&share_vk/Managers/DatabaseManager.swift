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
    }
    
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
    
    func addDormitory(dormitoryData: DormitoryData) {
        do {
            let documentRef = try database.collection(Constants.dormitories).addDocument(from: dormitoryData)
            print("Общежитие успешно добавлено с идентификатором: \(documentRef.documentID)")
        } catch {
            print("Ошибка при добавлении общежития: \(error.localizedDescription)")
        }
    }
    
    func getAllDormitories() {
        dormitories.removeAll()
        database.collection(Constants.dormitories).addSnapshotListener { [weak self] (querySnapshot, error) in
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
                } catch {
                    print(error)
                    fatalError("Could not fetch dormitory data")
                }
            }
        }
    }
    
    func getAllProducts() {
        products.removeAll()
        database.collection(Constants.products).addSnapshotListener { [weak self] (querySnapshot, error) in
            guard (querySnapshot?.documents) != nil else {
                print("No documents")
                return
            }
            
            for document in querySnapshot!.documents {
                do {
                    let productData = try document.data(as: ProductData.self)
                    self?.products.append(productData)
                } catch {
                    print(error)
                    fatalError("Could not fetch product data")
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
    
    func getFridgeById(fridgeId: String, completion: @escaping (FridgeData?) -> Void) {
        let docRef = database.collection(Constants.fridges).document(fridgeId)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                do {
                    let fridgesData = try document.data(as: FridgeData.self)
                    self.getAllProductsInFridge(fridgeProducts: fridgesData.products) { products in
                        self.productsInMyFridge = products
                    }
                    completion(fridgesData)
                    
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
    
    func uploadProduct(productName: String, completion: @escaping (UIImage) -> Void) {
        let ref = storage.reference().child(Constants.products).child(productName)
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
    
}

