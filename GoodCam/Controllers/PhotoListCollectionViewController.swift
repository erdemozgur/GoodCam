//
//  PhotoListCollectionViewController.swift
//  GoodCam
//
//  Created by Erdem Özgür on 6.04.2020.
//  Copyright © 2020 Erdem Özgür. All rights reserved.
//

import Foundation
import UIKit
import Photos

protocol PhotoListCollectionViewControllerDelegate {
    func photoListDidSelectImage(selectedImage: UIImage)
}

class PhotoListCollectionViewController: UICollectionViewController {

    private var images = [PHAsset]()
    var delegate: PhotoListCollectionViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populatePhotos()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.collectionView.reloadData()
    }
    
    private func requestPermission(completion: @escaping(PHAuthorizationStatus) -> ()) {
        
        PHPhotoLibrary.requestAuthorization { status in
            DispatchQueue.main.async {
                completion(status)
            }
        }
        
    }
    
    
    private func populatePhotos() {
        
        requestPermission { [weak self] status in
            if status == .authorized {
                guard let self = self else { return }
                
                let assets = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
                
                assets.enumerateObjects { (object, count, stop) in
                    
                    self.images.append(object)
                    
                }
                self.images.reverse()
                self.collectionView.reloadData()
                
                 
            }
        }
        
    }
    
}


extension PhotoListCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as? PhotoCollectionViewCell else {
            fatalError("PhotoCollectionViewCell is not found")
        }
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        let asset = self.images[indexPath.row]
        let manager = PHImageManager.default()
        manager.requestImage(for: asset, targetSize: CGSize(width: 100.0, height: 100.0), contentMode: .aspectFit, options: nil) { (image, _ ) in
            
            DispatchQueue.main.async {
                cell.photoImagEView.image = image
            }
        }
        
        return cell
    }
}

extension PhotoListCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let asset = self.images[indexPath.row]
        let manager = PHImageManager.default()
        
        let options = PHImageRequestOptions()
        options.isSynchronous = true
        
        manager.requestImage(for: asset, targetSize: CGSize(width: 320, height: 480), contentMode: .aspectFill, options: options) { (image, _) in
            
            if let image = image {
                self.delegate?.photoListDidSelectImage(selectedImage: image)
                
                
            }
        }
        
    }
}

