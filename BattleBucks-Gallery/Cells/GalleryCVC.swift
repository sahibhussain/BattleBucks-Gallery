//
//  AlbumTVC.swift
//  BattleBucks-Gallery
//
//  Created by Sahib Hussain on 27/09/24.
//

import UIKit
import TinyConstraints
import Hero

class GalleryCVC: UICollectionViewCell {
    
    static let identifier: String = "AlbumTVC"
    
    var albumImageView: UIImageView?
    var albumTitleLabel: UILabel?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    private func initialize() {
        
        albumImageView = UIImageView()
        albumImageView?.contentMode = .scaleAspectFill
        albumImageView?.clipsToBounds = true
        albumImageView?.layer.cornerRadius = 8
        
        albumTitleLabel = UILabel()
        albumTitleLabel?.font = .systemFont(ofSize: 12, weight: .light)
        albumTitleLabel?.textAlignment = .center
        albumTitleLabel?.textColor = .label
        albumTitleLabel?.backgroundColor = .init(white: 0.0, alpha: 0.5)
        albumTitleLabel?.layer.cornerRadius = 8
        albumTitleLabel?.clipsToBounds = true
        
        guard let albumImageView, let albumTitleLabel else { return }
        contentView.addSubview(albumImageView)
        contentView.addSubview(albumTitleLabel)
        albumImageView.edgesToSuperview()
        albumTitleLabel.edgesToSuperview()
        
    }
    
    
    public func configure(with album: Album) {
        albumImageView?.image(from: album.images.first, thumbnail: true)
        albumTitleLabel?.text = (album.images.count > 100 ? "100+" : "\(album.images.count)") + " Photos"
    }
    
    public func configure(with image: Image) {
        albumImageView?.image(from: image, thumbnail: true)
        albumImageView?.hero.id = "\(image.id)"
        albumTitleLabel?.isHidden = true
    }
    
}
