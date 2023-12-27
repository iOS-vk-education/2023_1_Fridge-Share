//
//  DataBase.swift
//  Fridge&Share
//
//  Created by Елизавета Шерман on 27.12.2023.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

class FireBase {
    static let shared = FireBase()
    let database = Firestore.firestore()
    let storage = Storage.storage()
    
    func uploadProduct(currenrProductId: String, photo: UIImage, completion: (Result<URL, Error>) -> Void) {
        let ref = storage.reference().child("products")
    }
    
    func addProduct(product: Product) {
        database.collection("products").addDocument(data: [
            "name" : product.name,
            "image": product.image,
            "explorationDate" : product.explorationDate
        ]) { error in
            if let error = error {
                print("Error writing document: \(error)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    func addUser(user: User, id: String) {
        database.collection("users").document(id).setData([
            "id" : id,
            "email" : user.email,
            "password" : user.password,
            "name" : user.name,
            "surname" : user.surname,
            "numberOfFloor" : user.numberOfFloor,
            "numberOfFrige" : user.numberOfFrige
        ], merge: true) { error in
            if let error = error {
                print("Error writing document: \(error)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    func updateUser(documentId: String, user: User) {
        database.collection("users").document(documentId).setData([
            "id" : documentId,
            "email" : user.email,
            "password" : user.password,
            "name" : user.name,
            "surname" : user.surname,
            "numberOfFloor" : user.numberOfFloor,
            "numberOfFrige" : user.numberOfFrige
        ], merge: true) { error in
            if let error = error {
                print("Error changing document: \(error)")
            } else {
                print("Document successfully changed!")
            }
        }

    }
    
    func getAllData() {
        database.collection("products").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            listOfProducts = documents.map { (queryDocumentSnapshot) -> Product in
                let data = queryDocumentSnapshot.data()
                let id = queryDocumentSnapshot.documentID
                let name = data["name"] as? String ?? ""
                let image = data["image"] as? String ?? ""
                let explorationDate = data["explorationDate"] as? String ?? ""
                var product = Product(name: name, image: image, explorationDate: explorationDate)
                product.id = id
                return product
            }
            
        }
    }
    
    func getAllUsers(completion: @escaping ([User]) -> Void) {
        database.collection("users").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                completion([])
                return
            }
            
            let dispatchGroup = DispatchGroup()
            
            for queryDocumentSnapshot in documents {
                let data = queryDocumentSnapshot.data()
                let id = queryDocumentSnapshot.documentID
                let productID = data["product ID"] as? String ?? ""
                
                dispatchGroup.enter()
                
                listOfUsers = documents.map { (queryDocumentSnapshot) -> User in
                    let data = queryDocumentSnapshot.data()
                    let id = queryDocumentSnapshot.documentID
                    let email = data["email"] as? String ?? ""
                    let password = data["password"] as? String ?? ""
                    let name = data["name"] as? String ?? ""
                    let surname = data["surname"] as? String ?? ""
                    let numberOfFloor = data["numberOfFloor"] as? Int ?? 0
                    let numberOfFrige = data["numberOfFrige"] as? Int ?? 0
                    var userItem = User(id: id, email: email, password: password, name: name, surname: surname, numberOfFloor: numberOfFloor, numberOfFrige: numberOfFrige)
                    return userItem
                }
                
            }
            
            dispatchGroup.notify(queue: .main) {
                completion(listOfUsers)
            }
        }
    }
    

    func getAllRequests(completion: @escaping ([RequestItem]) -> Void) {
        database.collection("requests").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                completion([])
                return
            }
            
            let dispatchGroup = DispatchGroup()
            
            for queryDocumentSnapshot in documents {
                let data = queryDocumentSnapshot.data()
                let id = queryDocumentSnapshot.documentID
                let productID = data["product ID"] as? String ?? ""
                
                dispatchGroup.enter()
                
                self.fetchProduct(documentId: productID) { product in
                    let result = data["result"] as? Bool ?? false
                    var requestItem = RequestItem(product: product, result: result)
                    requestItem.id = id
                    listOfRequests.append(requestItem)
                    print(requestItem)
                    dispatchGroup.leave()
                }
            }
            
            dispatchGroup.notify(queue: .main) {
                completion(listOfRequests)
            }
        }
    }
    
    func getAllAnswers(completion: @escaping ([AnswerItem]) -> Void) {
        database.collection("answers").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                completion([])
                return
            }
            
            let dispatchGroup = DispatchGroup()
            
            for queryDocumentSnapshot in documents {
                let data = queryDocumentSnapshot.data()
                let id = queryDocumentSnapshot.documentID
                let productID = data["product ID"] as? String ?? ""
                
                dispatchGroup.enter()
                
                self.fetchProduct(documentId: productID) { product in
                    let answer = data["answer"] as? String ?? "noanswer"
                    var answerCase = answerCase.noanswer
                    switch answer {
                    case "noanswer": answerCase = .noanswer
                    case "agree": answerCase = .agree
                    case "disagree": answerCase = .disagree
                    default: answerCase = .noanswer
                    }
                    let answerItem = AnswerItem(id: id, product: product, answer: answerCase)
                    listOfAnswers.append(answerItem)
                    dispatchGroup.leave()
                }
            }
            
            dispatchGroup.notify(queue: .main) {
                completion(listOfAnswers)
            }
        }
    }
    
    // Update the fetchProduct function to use a completion handler
    func fetchProduct(documentId: String, completion: @escaping (Product) -> Void) {
        let docRef = database.collection("products").document(documentId)
        
        docRef.getDocument { document, error in
            if let error = error as NSError? {
                print("Error getting document: \(error.localizedDescription)")
                completion(Product(name: "fail", image: "butter", explorationDate: "00.00.0000"))
            } else {
                if let document = document {
                    let data = document.data()
                    let id = document.documentID
                    let name = data?["name"] as? String ?? ""
                    let image = data?["image"] as? String ?? ""
                    let explorationDate = data?["explorationDate"] as? String ?? ""
                    var product = Product(name: name, image: image, explorationDate: explorationDate)
                    product.id = id
                    completion(product)
                }
            }
        }
    }
    
    func deleteRequest(documentId: String) {
        database.collection("requests").document(documentId).delete() { error in
            if let error = error {
                print("Error deleting request document: \(error)")
//                completion(false)
            } else {
                print("Request document successfully deleted!")
//                completion(true)
            }
        }
    }
    
    func deleteAnswer(documentId: String) {
        database.collection("answers").document(documentId).delete() { error in
            if let error = error {
                print("Error deleting request document: \(error)")
//                completion(false)
            } else {
                print("Request document successfully deleted!")
//                completion(true)
            }
        }
    }


    func updateAnswer(documentId: String, productId: String, answer: answerCase) {
        database.collection("answers").document(documentId).setData(["product ID" : productId,
                                                                     "answer" : answer.rawValue],
        merge: true)
    }
    
}
