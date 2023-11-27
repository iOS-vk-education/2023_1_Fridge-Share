//
//  OneFloorC+Extensions.swift
//  Fridge&Share
//
//  Created by Елизавета Шерман on 27.11.2023.
//

import Foundation
import UIKit

extension UICollectionView {
    func register(for type: ReusableCollectionCell.Type) {
        register(type, forCellWithReuseIdentifier: type.reusableIdentifier)
    }
}
