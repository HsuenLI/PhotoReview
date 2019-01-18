//
//  ViewController.swift
//  PhotoReview
//
//  Created by Hsuen-Ju Li on 2019/1/17.
//  Copyright © 2019 Hsuen-Ju Li. All rights reserved.
//

import UIKit
import Photos

class PhotoViewController: UICollectionViewController {

    //Outlets
    let headerId = "headerId"
    let cellId = "cellId"
    var photos = [UIImage]()
    let smallImageSize = CGSize(width: 200, height: 200)
    let largeHeaderSize = CGSize(width: 600, height: 600)
    var selectedImage : UIImage?
    var photoAssets = [PHAsset]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.register(PhotoHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView.register(PhotoSelectorCell.self, forCellWithReuseIdentifier: cellId)
        
        fetchPhotos()
    }
    
    fileprivate func fetchPhotos(){
        let options = PHFetchOptions()
        options.fetchLimit = 10
        let allPhotos = PHAsset.fetchAssets(with: .image, options: options)
        DispatchQueue.global(qos: .background).async{
            allPhotos.enumerateObjects { (asset, count, stop) in
                let imageManager = PHImageManager.default()
                let targetSize = self.smallImageSize
                let options = PHImageRequestOptions()
                options.isSynchronous = true
                imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFit, options: options, resultHandler: { (image, info) in
                    
                    if let image = image{
                        self.photos.append(image)
                        self.photoAssets.append(asset)
                        if self.selectedImage == nil{
                            self.selectedImage = image
                        }
                    }
                    
                    if count == allPhotos.count-1{
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                        }
                    }
                })
            }
        }
    }
    
}

extension PhotoViewController : UICollectionViewDelegateFlowLayout{
    //Header
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! PhotoHeaderView
        
        if let selectedImage = selectedImage{
            if let index = self.photos.index(of: selectedImage){
                let imageManager = PHImageManager.default()
                imageManager.requestImage(for: photoAssets[index], targetSize: largeHeaderSize, contentMode: .default, options: nil) { (image, info) in
                    header.photoImageView.image = image
                }
            }
        }

        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = view.frame.width
        return CGSize(width: width, height: width)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PhotoSelectorCell
        cell.photoImageView.image = photos[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 12) / 3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 3, left: 3, bottom: 0, right: 3)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedImage = photos[indexPath.item]
        collectionView.reloadData()
    }
}

