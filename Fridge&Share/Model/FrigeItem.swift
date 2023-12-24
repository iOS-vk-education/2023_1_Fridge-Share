//
//  FrigeItem.swift
//  Fridge&Share
//
//  Created by Елизавета Шерман on 27.11.2023.
//

import Foundation

class Frige {
    private var products = [Product]()
    
    init(products: [Product] = [Product]()) {
        self.products = products
    }
    
    func addProduct(product: Product) {
        products.append(product)
    }
    
    func getProducts() -> [Product] {
        return products
    }
}
