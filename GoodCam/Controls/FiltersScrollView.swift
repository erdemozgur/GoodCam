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

protocol FiltersScrollViewDelegate {
    
    func filtersScrollViewDidSelectFilter(filter: CIFilter)
    
}

class FiltersScrollView: UIScrollView {
    
    private var filtersService: FiltersService!
    var filterDelegate: FiltersScrollViewDelegate?
    
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
    private func registerTapGestureRecognizer(for view: UIView) {
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        view.addGestureRecognizer(tapGestureRecognizer)
        
    }
    @objc func tapped(recognizer: UITapGestureRecognizer) {
        // taking which filter we tapped and setting delegate.
        guard let selectedFilterImageView = recognizer.view as? UIImageView else { return }
        
        self.filterDelegate?.filtersScrollViewDidSelectFilter(filter: FiltersService.all()[selectedFilterImageView.tag])
        
    }
    
    private func setupFilters() {
        
        //applying filters to default image
        var offset: CGFloat = 10.0
        
        for (index, filter) in FiltersService.all().enumerated() {
            
            let filterImageView = UIImageView.imageForFilterView()
            registerTapGestureRecognizer(for: filterImageView)
            self.addSubview(filterImageView)
            filterImageView.tag = index
            filterImageView.isUserInteractionEnabled = true
            
            filterImageView.frame.origin.x = offset
            filterImageView.center.y = self.frame.height/2
            
            offset += filterImageView.frame.width + filterImageView.frame.width/4
            self.contentSize = CGSize(width: offset, height: self.frame.height)
            
            self.filtersService.applyFilter(filter: filter, to: filterImageView.image!) {
                filterImageView.image = $0
            }
            
        }
        
    }
    
}

