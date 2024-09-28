//
//  GalleryVC.swift
//  BattleBucks-Gallery
//
//  Created by Sahib Hussain on 27/09/24.
//

import UIKit
import TinyConstraints
import Hero

class GalleryVC: UIViewController {
    
    public var album: Album? = nil
    
    var collectionView: UICollectionView?
    var flowLayout: UICollectionViewFlowLayout?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Album #\(album?.id ?? 0)"
        setupCollectionView()
        
    }
    
    private func setupCollectionView() {
        
        // Set up UICollectionViewFlowLayout
        flowLayout = UICollectionViewFlowLayout()
        flowLayout?.minimumInteritemSpacing = 12
        flowLayout?.minimumLineSpacing = 12
        flowLayout?.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 20, right: 16)
        
        // Set up UICollectionView
        guard let flowLayout else { return }
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.hero.modifiers = [.cascade]
        collectionView?.register(GalleryCVC.self, forCellWithReuseIdentifier: GalleryCVC.identifier)
        
        guard let collectionView else { return }
        view.addSubview(collectionView)
        collectionView.edgesToSuperview()
        
    }
    
    
}

// MARK: - UICollectionView DataSource and Delegate
extension GalleryVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return album?.images.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCVC.identifier, for: indexPath) as! GalleryCVC
        if let image = album?.images.safeIndex(indexPath.item) { cell.configure(with: image) }
        cell.hero.modifiers = [.fade, .scale(0.5)]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width / 3.0) - 20.0
        return CGSize(width: width, height: width)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailVC()
        vc.album = album
        vc.selectedIndex = indexPath.item
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
