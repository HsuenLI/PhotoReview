//
//  CustomCollectionCell.swift
//  PhotoReview
//
//  Created by Hsuen-Ju Li on 2019/1/18.
//  Copyright © 2019 Hsuen-Ju Li. All rights reserved.
//

import UIKit

class PhotoSelectorCell : UICollectionViewCell {
    
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
        backgroundColor = .blue
    }
}
