//
//  ViewController.swift
//  BattleBucks-Gallery
//
//  Created by Sahib Hussain on 26/09/24.
//

import UIKit
import TinyConstraints
import Hero

class HomeVC: UIViewController {
    
    var albums: [Album] = []
    
    var collectionView: UICollectionView?
    var flowLayout: UICollectionViewFlowLayout?
    var loader: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Albums"
        setupCollectionView()
        fetchImages()
        
    }
    
    private func setupCollectionView() {
        
        // setup loader
        loader = UIActivityIndicatorView(style: .medium)
        loader?.color = .label
        loader?.startAnimating()
        loader?.isHidden = true
        
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
        
        guard let collectionView, let loader else { return }
        view.addSubview(collectionView)
        view.addSubview(loader)
        collectionView.edgesToSuperview()
        loader.centerInSuperview()
        
    }
    
}

// MARK: - UICollectionView DataSource and Delegate
extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCVC.identifier, for: indexPath) as! GalleryCVC
        if let album = albums.safeIndex(indexPath.item) { cell.configure(with: album) }
        cell.hero.modifiers = [.fade, .scale(0.5)]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width / 3.0) - 20.0
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Did select item at index: \(indexPath.item)")
        if let album = albums.safeIndex(indexPath.item) {
            let vc = GalleryVC()
            vc.album = album
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
