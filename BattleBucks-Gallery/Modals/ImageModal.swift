//
//  Modal.swift
//  BattleBucks-Gallery
//
//  Created by Sahib Hussain on 26/09/24.
//

import Foundation

struct Image: Codable {
    
    let id: Int
    let albumId: Int
    let title: String
    let urlString: String
    let thumbnailUrlString: String
    
    var url: URL? { URL(string: urlString) }
    var thumbnailUrl: URL? { URL(string: thumbnailUrlString) }
    
    enum CodingKeys: String, CodingKey {
        case id
        case albumId
        case title
        case urlString = "url"
        case thumbnailUrlString = "thumbnailUrl"
    }
    
}

struct Album: Codable {
    
    let id: Int
    let images: [Image]
    
}
