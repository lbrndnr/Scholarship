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

    }
    
    // MARK: -
    
    
}
