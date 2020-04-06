//
//  PhotoPreviewViewController.swift
//  GoodCam
//
//  Created by Erdem Özgür on 6.04.2020.
//  Copyright © 2020 Erdem Özgür. All rights reserved.
//

import Foundation
import UIKit

class PhotoPreviewViewController: UIViewController {
    
    
    @IBOutlet weak var photoImageView: UIImageView!
    var previewImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.photoImageView.image = self.previewImage
    }
    
    
    
    
}
