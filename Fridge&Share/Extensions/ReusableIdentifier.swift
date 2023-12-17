//
//  ReusableIdentifier.swift
//  Fridge&Share
//
//  Created by Елизавета Шерман on 27.11.2023.
//

import Foundation
import UIKit

protocol ReusableCollectionCell: UICollectionViewCell {
    static var reusableIdentifier: String { get }
}

extension ReusableCollectionCell {
    static var reusableIdentifier: String {
        NSStringFromClass(self)
    }
}
