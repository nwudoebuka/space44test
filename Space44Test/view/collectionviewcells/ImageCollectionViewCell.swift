//
//  ImageCollectionViewCell.swift
//  Space44Test
//
//  Created by Chukwuebuka Nwudo on 13/12/2021.
//

import UIKit
import Kingfisher
class ImageCollectionViewCell:UICollectionViewCell {
    static let identifier = "imageViewCell"
    lazy var contentImg:UIImageView = {
        let contentImg = UIImageView()
        contentImg.image = UIImage(named: "dummypic")
        contentImg.layer.masksToBounds = true
        contentImg.layer.cornerRadius = 12
        return contentImg
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(data:AlbumDetailItem){
        contentImg.setImage(with: data.thumbnailURL)
    }
    
    func initView(){
        backgroundColor = .black
          addSubview(contentImg)
        contentImg.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
}
