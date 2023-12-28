//
//  RequestItem.swift
//  Fridge&Share
//
//  Created by Елизавета Шерман on 27.12.2023.
//

import Foundation
import FirebaseFirestore

struct RequestItem {
    @DocumentID var id: String?
    let product: Product
    let result: Bool
    
    init(product: Product, result: Bool) {
        self.product = product
        self.result = result
    }
}
