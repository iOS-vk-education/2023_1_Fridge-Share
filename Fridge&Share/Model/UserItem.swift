//
//  UserItem.swift
//  Fridge&Share
//
//  Created by Елизавета Шерман on 27.12.2023.
//

import Foundation
import FirebaseFirestore

struct User {
    @DocumentID var id: String?
    let email: String
    let password: String
    var name: String?
    var surname: String?
    var numberOfFloor: Int?
    var numberOfFrige: Int?
    
    init(id: String? = nil, email: String, password: String, name: String? = nil, surname: String? = nil, numberOfFloor: Int? = nil, numberOfFrige: Int? = nil) {
        self.id = id
        self.email = email
        self.password = password
        self.name = name
        self.surname = surname
        self.numberOfFloor = numberOfFloor
        self.numberOfFrige = numberOfFrige
    }
}
