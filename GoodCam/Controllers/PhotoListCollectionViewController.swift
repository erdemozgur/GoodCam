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

class PhotoListCollectionViewController: UICollectionViewController {

    private var images = [PHAsset]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populatePhotos()
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

