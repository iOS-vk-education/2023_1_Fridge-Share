//
//  ImageCache.swift
//  fridge&share_vk
//
//  Created by Елизавета Шерман on 07.05.2024.
//

import UIKit

class ImageCache {
    static let shared = ImageCache()
    private var cache = NSCache<NSString, UIImage>()

    func getImage(for key: String) -> UIImage? {
        return cache.object(forKey: NSString(string: key))
    }

    func setImage(_ image: UIImage, for key: String) {
        cache.setObject(image, forKey: NSString(string: key))
    }
}
