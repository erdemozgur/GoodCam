//
//  UIImageView+Extensions.swift
//  GoodCam
//
//  Created by Erdem Özgür on 6.04.2020.
//  Copyright © 2020 Erdem Özgür. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    static func imageForFilterView() -> UIImageView {
        
        let filterImageView = UIImageView(image: UIImage(named: "filter-default-image"))
        filterImageView.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 80, height: 80))
        filterImageView.layer.cornerRadius = 6.0
        filterImageView.layer.masksToBounds = true
        return filterImageView
        
    }
    
    
}
