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
        
        requestPermission { status in
            if status == .authorized {
                print("authorized")
            }
        }
        
        
    }
    
}
