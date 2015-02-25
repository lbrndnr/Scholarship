//
//  TopicImageCell.swift
//  Scholarship
//
//  Created by Laurin Brandner on 13/02/15.
//  Copyright (c) 2015 Laurin Brandner. All rights reserved.
//

import UIKit
import Cartography
import ReactiveCocoa

class TopicImageCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .ScaleAspectFill
        
        return imageView
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initialize()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.initialize()
    }
    
    private func initialize() {
        self.layer.cornerRadius = 8.0
        self.layer.masksToBounds = true
        
        self.contentView.addSubview(self.imageView)
        // Swift bug
        constrain(self.contentView, self.imageView) { view, imageView in
            imageView.edges == view.edges; return
        }
        
        self.rac_valuesForKeyPath("highlighted", observer: self).subscribeNext { _ in
            UIView.animateWithDuration(0.1, delay: 0.0, options: .BeginFromCurrentState, animations: {
                self.transform = (self.highlighted) ? CGAffineTransformMakeScale(0.95, 0.95) : CGAffineTransformIdentity
            }, completion: nil)
        }
    }
    
    // MARK: -
    
}
