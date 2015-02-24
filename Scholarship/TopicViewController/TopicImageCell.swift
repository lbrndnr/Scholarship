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
    
    let highlightView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.0, alpha: 0.3)
        
        return view
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
        
        self.contentView.addSubview(self.highlightView)
        // Swift bug
        constrain(self.contentView, self.highlightView) { view, highlightView in
            highlightView.edges == view.edges; return
        }
        
        self.rac_valuesForKeyPath("highlighted", observer: self).subscribeNext { _ in
            self.highlightView.hidden = !self.highlighted
        }
    }
    
    // MARK: -
    
}
