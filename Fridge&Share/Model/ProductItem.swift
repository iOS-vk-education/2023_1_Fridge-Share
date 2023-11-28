//
//  ProductItem.swift
//  Fridge&Share
//
//  Created by Елизавета Шерман on 27.11.2023.
//

import Foundation

struct Product {
    let name: String
    let image: String
    let explorationDate: String
    
    init(name: String, image: String, explorationDate: String) {
        self.name = name
        self.image = image
        self.explorationDate = explorationDate
    }
}
