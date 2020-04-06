//
//  FiltersScrollView.swift
//  GoodCam
//
//  Created by Erdem Özgür on 6.04.2020.
//  Copyright © 2020 Erdem Özgür. All rights reserved.
//

import Foundation
import UIKit
import CoreImage

class FiltersScrollView: UIScrollView {
    
    private var filtersService: FiltersService!
    
    init(parentView: UIView, frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        
        self.filtersService = FiltersService()
        setupFilters()
    }
    
    private func setupFilters() {
        
        var offset: CGFloat = 10.0
        
        for (index, filter) in FiltersService.all().enumerated() {
            
            let filterImageView = UIImageView.imageForFilterView()
            self.addSubview(filterImageView)
            filterImageView.tag = index
            
            filterImageView.frame.origin.x = offset
            filterImageView.center.y = self.frame.height/2
            
            offset += filterImageView.frame.width + filterImageView.frame.width/4
            self.contentSize = CGSize(width: offset, height: self.frame.height)
            
        }
        
    }
    
}

