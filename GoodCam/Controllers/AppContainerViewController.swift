//
//  AppContainerViewController.swift
//  GoodCam
//
//  Created by Erdem Özgür on 6.04.2020.
//  Copyright © 2020 Erdem Özgür. All rights reserved.
//

import Foundation
import UIKit

class AppContainerViewController: UIViewController, PhotoListCollectionViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let photoListCVC = self.children.first as? PhotoListCollectionViewController else {
            return
        }
        
        photoListCVC.delegate = self
    }
    
    func photoListDidSelectImage(selectedImage: UIImage) {
        
        showImagePreview(previewImage: selectedImage)
        
    }
    
    private func showImagePreview(previewImage: UIImage) {
        
        guard let photoPreviewVC = self.storyboard?.instantiateViewController(withIdentifier: "PhotoPreviewViewController") as? PhotoPreviewViewController else {
            fatalError("PhotoPreviewViewController is not found ")
        }
        photoPreviewVC.previewImage = previewImage
        self.navigationController?.pushViewController(photoPreviewVC, animated: true)
        
    }

    @IBAction func cameraButtonPressed() {
        
        guard let photoFilterVC = self.storyboard?.instantiateViewController(withIdentifier: "PhotoFiltersViewController") as? PhotoFiltersViewController else {
            fatalError("PhotoFiltersViewController is not found")
        }
        self.addChildController(photoFilterVC)
        
    }
    
    
    
}
