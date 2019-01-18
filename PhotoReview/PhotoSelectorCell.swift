//
//  CustomCollectionCell.swift
//  PhotoReview
//
//  Created by Hsuen-Ju Li on 2019/1/18.
//  Copyright © 2019 Hsuen-Ju Li. All rights reserved.
//

import UIKit

class PhotoSelectorCell : UICollectionViewCell {
    
    //Outles
    let photoImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupView(){
        layer.cornerRadius = 5.0
        layer.masksToBounds = true
        addSubview(photoImageView)
        photoImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
}
