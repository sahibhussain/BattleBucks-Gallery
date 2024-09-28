//
//  CacheManager.swift
//  BattleBucks-Gallery
//
//  Created by Sahib Hussain on 27/09/24.
//

import UIKit

class CacheManager {
    
    static let shared = CacheManager()
    
    private init() {}
    
    
    private var task: URLSessionDataTask?
    private var imageCache = NSCache<NSString, UIImage>()
    private var thumbnailCache = NSCache<NSString, UIImage>()
    
    func cacheImage(_ image: UIImage, forKey key: String) {
        imageCache.setObject(image, forKey: key as NSString)
    }
    
    func getImage(forKey key: String) -> UIImage? {
        return imageCache.object(forKey: key as NSString)
    }
    
}
