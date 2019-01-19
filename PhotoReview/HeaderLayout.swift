//
//  HeaderLayout.swift
//  PhotoReview
//
//  Created by Hsuen-Ju Li on 2019/1/18.
//  Copyright © 2019 Hsuen-Ju Li. All rights reserved.
//

import UIKit

class HeaderLayout : UICollectionViewFlowLayout{
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        let layoutAttributes = super.layoutAttributesForElements(in: rect)
        
        layoutAttributes?.forEach({ (attributes) in
            if attributes.representedElementKind == UICollectionView.elementKindSectionHeader{
                guard let collectionView = collectionView else{return}
                
                let contentOffsetY = collectionView.contentOffset.y
                
                if contentOffsetY > 0{
                    return
                }
                
                let height = attributes.frame.height - contentOffsetY
                let width = collectionView.frame.width
                attributes.frame = CGRect(x: 0, y: contentOffsetY, width: width, height: height)
            }
        })
        
        
        return layoutAttributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
