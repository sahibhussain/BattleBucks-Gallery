//
//  HomeVC_Tests.swift
//  BattleBucks-Gallery
//
//  Created by Sahib Hussain on 27/09/24.
//

import XCTest
@testable import BattleBucks_Gallery

final class HomeVC_Tests: XCTestCase {
    
    var viewController: HomeVC!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewController = HomeVC()
        _ = viewController.view
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewController = nil
    }
    
    func testAllImagesLoadAsynchronously() throws {
        let expectation = self.expectation(description: "All valid image URLs should be loaded.")
        
        // Simulate async image loading (assuming you load images from URLs)
        HomeViewModal.shared.getImages { result in
            switch result {
            case .success(let images):
                
                let albums = self.viewController.groupByAlbums(images)
                XCTAssertFalse(albums.isEmpty, "No albums found in the gallery.")
                
                for album in albums {
                    XCTAssertFalse(album.images.isEmpty, "No images found in the album \(album.id).")
                    XCTAssertTrue(album.images.count == images.filter({ $0.albumId == album.id }).count, "Some images in the album \(album.id) are not counted correctly.")
                }
                
                expectation.fulfill()
            case .failure:
                XCTFail("Failed to load images.")
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
}
