//
//  TopicFlowLayout.swift
//  Scholarship
//
//  Created by Laurin Brandner on 12/02/15.
//  Copyright (c) 2015 Laurin Brandner. All rights reserved.
//

import UIKit
import ReactiveCocoa

class TopicFlowLayout: UICollectionViewFlowLayout {
    
    // MARK: - Initialization
    
    override init() {
        super.init()
        
        self.initialize()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.initialize()
    }
    
    private func initialize() {
        self.rac_valuesForKeyPath("collectionView.bounds", observer: self).subscribeNext { _ in
            if let collectionView = self.collectionView {
                let bounds = collectionView.bounds
                self.itemSize = CGSize(width: bounds.width*0.75, height: 100)
            }
        }
    }
    
    // MARK: -
    
    
}
