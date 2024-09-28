//
//  ImageCVC.swift
//  BattleBucks-Gallery
//
//  Created by Sahib Hussain on 28/09/24.
//

import UIKit
import TinyConstraints

class ImageCVC: UICollectionViewCell {
    
    static let identifier: String = "AlbumTVC"
    
    var fullImageView: UIImageView?
    var imageTitleLabel: UILabel?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    private func initialize() {
        
        fullImageView = UIImageView()
        fullImageView?.contentMode = .scaleAspectFill
        fullImageView?.clipsToBounds = true
        
        imageTitleLabel = UILabel()
        imageTitleLabel?.font = .systemFont(ofSize: 12, weight: .light)
        imageTitleLabel?.textAlignment = .center
        imageTitleLabel?.textColor = .label
        imageTitleLabel?.numberOfLines = 0
        imageTitleLabel?.clipsToBounds = true
        
        guard let fullImageView, let imageTitleLabel else { return }
        let view = UIView()
        view.backgroundColor = .init(white: 0.0, alpha: 0.3)
        view.addSubview(imageTitleLabel)
        imageTitleLabel.horizontalToSuperview(insets: .horizontal(16))
        imageTitleLabel.verticalToSuperview(insets: .vertical(12))
        
        contentView.addSubview(fullImageView)
        contentView.addSubview(view)
        fullImageView.edgesToSuperview()
        view.horizontalToSuperview()
        view.bottomToSuperview(offset: -80)
        
    }
    
    
    public func configure(with image: Image, heroID: String? = nil) {
        fullImageView?.image(from: image, thumbnail: false)
        fullImageView?.hero.id = heroID
        imageTitleLabel?.text = image.title
    }
    
}
