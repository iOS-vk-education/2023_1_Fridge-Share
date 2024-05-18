//
//  Models.swift
//  fridge&share_vk
//
//  Created by Елизавета Шерман on 17.04.2024.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseStorage
import SwiftUI

enum statusOfProduct: String {
    case available = "доступен"
    case waiting = "ждет ответа"
    case given = "отдан"
}

struct DormitoryData: Codable, Hashable {
    var name: String
    var address: String
    var floors: [String]
}

struct FloorData: Codable, Hashable {
    var id: String
    var number: Int
    var fridges: [String]
}

struct FridgeData: Codable, Hashable {
    var id: String
    var number: Int
    var products: [String]
}

struct ProductData: Codable, Hashable {
    var id: String
    var name: String
    var dateExploration: Date
    var dateAdded: Date
    var userId: String
    var status: statusOfProduct.RawValue
    var image: String
}

class UserData: ObservableObject, Codable {
    @Published var id: String
    @Published var email: String
    @Published var name: String
    @Published var dormitory: String
    @Published var floor: String
    @Published var fridge: String
    @Published var password: String
    @Published var avatar: String
    
    init(id: String = "", email: String = "", name: String = "", dormitory: String = "", floor: String = "", fridge: String = "", password: String = "", avatar: String = "") {
        self.id = id
        self.email = email
        self.name = name
        self.dormitory = dormitory
        self.floor = floor
        self.fridge = fridge
        self.password = password
        self.avatar = avatar
    }
    
    
    enum CodingKeys: String, CodingKey {
        case id, email, name, dormitory, floor, fridge, password, avatar
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(email, forKey: .email)
        try container.encode(name, forKey: .name)
        try container.encode(dormitory, forKey: .dormitory)
        try container.encode(floor, forKey: .floor)
        try container.encode(fridge, forKey: .fridge)
        try container.encode(password, forKey: .password)
        try container.encode(avatar, forKey: .avatar)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        email = try container.decode(String.self, forKey: .email)
        name = try container.decode(String.self, forKey: .name)
        dormitory = try container.decode(String.self, forKey: .dormitory)
        floor = try container.decode(String.self, forKey: .floor)
        fridge = try container.decode(String.self, forKey: .fridge)
        password = try container.decode(String.self, forKey: .password)
        avatar = try container.decode(String.self, forKey: .avatar)
    }
    
    func updateData() {
        FireBase.shared.getUserById(userId: self.id) { userData in
            if let userData = userData {
                DispatchQueue.main.async {
                    self.name = userData.name
                    self.floor = userData.floor
                    self.avatar = userData.avatar
                }
            }
        }
    }
}
