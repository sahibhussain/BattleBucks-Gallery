//
//  DetailVC.swift
//  BattleBucks-Gallery
//
//  Created by Sahib Hussain on 27/09/24.
//

import UIKit
import TinyConstraints

class DetailVC: UIViewController {
    
    public var album: Album? = nil
    public var selectedIndex: Int? = nil
    
    var collectionView: UICollectionView?
    var flowLayout: UICollectionViewFlowLayout?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView?.layoutIfNeeded()
        if let selectedIndex {
            collectionView?.scrollToItem(at: IndexPath(item: selectedIndex, section: 0), at: .centeredHorizontally, animated: false)
        }
    }
    
    private func setupCollectionView() {
        
        // Set up UICollectionViewFlowLayout
        flowLayout = UICollectionViewFlowLayout()
        flowLayout?.minimumInteritemSpacing = 0
        flowLayout?.minimumLineSpacing = 0
        flowLayout?.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout?.scrollDirection = .horizontal
        
        // Set up UICollectionView
        guard let flowLayout else { return }
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView?.isPagingEnabled = true
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.hero.modifiers = [.cascade]
        collectionView?.register(ImageCVC.self, forCellWithReuseIdentifier: ImageCVC.identifier)
        
        guard let collectionView else { return }
        view.addSubview(collectionView)
        collectionView.edgesToSuperview()
        
    }
    
}


// MARK: - UICollectionView DataSource and Delegate
extension DetailVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return album?.images.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCVC.identifier, for: indexPath) as! ImageCVC
        if let image = album?.images.safeIndex(indexPath.item) { cell.configure(with: image, heroID: "\(image.id)") }
        cell.hero.modifiers = [.fade, .scale(0.5)]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
}
