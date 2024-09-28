//
//  ViewModal.swift
//  BattleBucks-Gallery
//
//  Created by Sahib Hussain on 26/09/24.
//

import SHNetwork
import SHDesign

class HomeViewModal {
    
    static let shared = HomeViewModal()
    
    internal typealias Response<T: Codable> = Result<T, Error>
    
    private init() {}
    
    public func getImages(_ completion: @escaping (Result<[Image], Error>) -> Void) {
        
        let apiURL = "https://jsonplaceholder.typicode.com/photos"
        SHNetwork.shared.sendGetRequest(with: apiURL, param: "") { (response: Response<[Image]>) in
            completion(response)
        }
        
    }
    
}

extension HomeVC {
    
    func fetchImages() {
        loader?.isHidden = false
        HomeViewModal.shared.getImages { [weak self] result in
            self?.loader?.isHidden = true
            switch result {
            case .success(let images):
                self?.albums = self?.groupByAlbums(images) ?? []
                self?.collectionView?.reloadData()
            case .failure(let error):
                Toast.showError("Error", subtitle: error.localizedDescription)
            }
        }
    }
    
    func groupByAlbums(_ images: [Image]) -> [Album] {
        let groupedImages = images.reduce(into: [Int: [Image]]()) { result, image in
            result[image.albumId, default: []].append(image)
        }
        return groupedImages.map { Album(id: $0.key, images: $0.value) }
    }
    
}
