//
//  UIImage+Extension.swift
//  BattleBucks-Gallery
//
//  Created by Sahib Hussain on 27/09/24.
//

import UIKit
import TinyConstraints

extension UIImageView {
    
    func image(from imageModal: Image?, thumbnail: Bool = false, placeholder: UIImage? = nil) {
        
        let loader = UIActivityIndicatorView(style: .medium)
        loader.startAnimating()
        self.addSubview(loader)
        loader.centerInSuperview()
        
        self.image = placeholder
        
        guard let imageModal else { loader.removeFromSuperview(); return }
        var url: URL?
        var urlString: String?
        if let imageUrl = imageModal.url, !thumbnail { url = imageUrl;  urlString = imageUrl.absoluteString + "_full" }
        if let imageUrl = imageModal.thumbnailUrl, thumbnail { url = imageUrl; urlString = imageUrl.absoluteString }
        
        guard let url, let urlString else { loader.removeFromSuperview(); return }
        if let cachedImage = CacheManager.shared.getImage(forKey: url.absoluteString) { self.image = cachedImage; loader.removeFromSuperview(); return }
        
        // Download the image from the URL
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, let image = UIImage(data: data), error == nil else { loader.removeFromSuperview(); return }
            self?.cacheImage(image, forKey: urlString)
            if let url = imageModal.url, thumbnail { self?.cacheImage(url, forKey: url.absoluteString + "_full") }
            if let url = imageModal.thumbnailUrl, !thumbnail { self?.cacheImage(url, forKey: url.absoluteString) }
            DispatchQueue.main.async { self?.image = image; loader.removeFromSuperview() }
        }.resume()
    }
    
    private func cacheImage(_ url: URL, forKey key: String) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let image = UIImage(data: data), error == nil else { return }
            CacheManager.shared.cacheImage(image, forKey: key)
        }.resume()
    }
    
    private func cacheImage(_ image: UIImage, forKey key: String) {
        CacheManager.shared.cacheImage(image, forKey: key)
    }
    
}
