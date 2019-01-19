//
//  PhotoHeaderView.swift
//  PhotoReview
//
//  Created by Hsuen-Ju Li on 2019/1/18.
//  Copyright © 2019 Hsuen-Ju Li. All rights reserved.
//

import UIKit

class PhotoHeaderView : UICollectionReusableView{
    
    //Outlets
    let photoImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.borderWidth = 0.5
        return imageView
    }()
    var animator : UIViewPropertyAnimator!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupView(){
        addSubview(photoImageView)
        photoImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        photoImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        photoImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

        let separatorView = UIView()
        separatorView.backgroundColor = UIColor(white: 0, alpha: 0.3)
        addSubview(separatorView)
        separatorView.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 1)
        
        setupVisualEffectBlur()
    }
    
    fileprivate func setupVisualEffectBlur(){
        animator = UIViewPropertyAnimator(duration: 3.0, curve: .linear, animations: {
            [weak self] in
            
            let blurEffect = UIBlurEffect(style: .regular)
            let visualEffectView = UIVisualEffectView(effect: blurEffect)
            self?.addSubview(visualEffectView)
            visualEffectView.anchor(top: self?.topAnchor, left: self?.leftAnchor, bottom: self?.bottomAnchor, right: self?.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        })
    }
}
