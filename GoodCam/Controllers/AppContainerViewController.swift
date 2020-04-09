//
//  AppContainerViewController.swift
//  GoodCam
//
//  Created by Erdem Özgür on 6.04.2020.
//  Copyright © 2020 Erdem Özgür. All rights reserved.
//

import Foundation
import UIKit

class AppContainerViewController: UIViewController, PhotoListCollectionViewControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, PhotoFilterViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let photoListCVC = self.children.first as? PhotoListCollectionViewController else {
            return
        }
        //getting selected cell's image from photoListCollectionViewController
        photoListCVC.delegate = self
    }
    
    //protocol func
    func photoListDidSelectImage(selectedImage: UIImage) {
        
        showImagePreview(previewImage: selectedImage)
        
    }
    
    func photoFilterCancel() {
        showPhotosList()
    }
    func photoFilterDone() {
        
    }
    
    private func showPhotosList() {
        
        self.view.subviews.forEach {
            $0.removeFromSuperview()
        }
        guard let photoListCVC = self.storyboard?.instantiateViewController(withIdentifier: "PhotoListCollectionViewController") as? PhotoListCollectionViewController else {  fatalError("PhotoListCollectionViewController is not found")}
        photoListCVC.delegate = self
        self.addChildController(photoListCVC)
        
    }
    
    private func showImagePreview(previewImage: UIImage) {
        //Showing image into PhotoPreviewViewController
        guard let photoPreviewVC = self.storyboard?.instantiateViewController(withIdentifier: "PhotoPreviewViewController") as? PhotoPreviewViewController else {
            fatalError("PhotoPreviewViewController is not found ")
        }
        photoPreviewVC.previewImage = previewImage
        self.navigationController?.pushViewController(photoPreviewVC, animated: true)
        
    }

    @IBAction func cameraButtonPressed() {
        
        //checking if the phone's camera available
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            let imagePickerVC = UIImagePickerController()
            imagePickerVC.sourceType = .camera
            imagePickerVC.delegate = self
            self.present(imagePickerVC, animated: true, completion: nil)
        }
        
    }
    
}

extension  AppContainerViewController {
    
    //using image after taking the photo.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let originalImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        showPhotoFiltersViewController(for: originalImage) // using the photo which was taken and passing it.
        
        
        picker.dismiss(animated: true, completion: nil)
         
    }
    //Passing Image to photoFiltersViewController
    private func showPhotoFiltersViewController(for image: UIImage) {
        guard let photoFiltersVC = self.storyboard?.instantiateViewController(withIdentifier: "PhotoFiltersViewController") as? PhotoFiltersViewController else {
            fatalError("PhotoFiltersViewController is not found")
        }
        
        photoFiltersVC.image = image
        photoFiltersVC.delegate = self
        self.addChildController(photoFiltersVC)
        
    }
    
    //Clicking cancel button to dismiss the view.
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)

    }
    
}
