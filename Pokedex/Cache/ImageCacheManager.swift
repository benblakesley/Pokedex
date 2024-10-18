//
//  ImageCache.swift
//  Pokedex
//
//  Created by Ben Blakesley on 18/10/2024.
//

import Foundation
import UIKit

class ImageCacheManager
{
    static let instance = ImageCacheManager()
    
    private init() {}
    
    var imageCache: NSCache<NSString, UIImage> = NSCache<NSString, UIImage>()
    
    func addImage(image: UIImage, name: String)
    {
        imageCache.setObject(image, forKey: name as NSString)
    }
    
    func removeImage(name: String)
    {
        imageCache.removeObject(forKey: name as NSString)
    }
    
    func getImage(name: String) -> UIImage?
    {
        return imageCache.object(forKey: name as NSString)
    }
}
