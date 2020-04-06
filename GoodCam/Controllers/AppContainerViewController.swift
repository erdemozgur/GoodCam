//
//  AppContainerViewController.swift
//  GoodCam
//
//  Created by Erdem Özgür on 6.04.2020.
//  Copyright © 2020 Erdem Özgür. All rights reserved.
//

import Foundation
import UIKit

class AppContainerViewController: UIViewController {
    
    
    @IBAction func cameraButtonPressed() {
        
        guard let photoFilterVC = self.storyboard?.instantiateViewController(withIdentifier: "PhotoFiltersViewController") as? PhotoFiltersViewController else {
            fatalError("PhotoFiltersViewController is not found")
        }
        self.addChildController(photoFilterVC)
        
    }
    
    
    
}
