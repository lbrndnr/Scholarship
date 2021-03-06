//
//  ImageLabel.swift
//  Scholarship
//
//  Created by Laurin Brandner on 07/02/15.
//  Copyright (c) 2015 Laurin Brandner. All rights reserved.
//

import UIKit
import Cartography
import ReactiveCocoa

class TopicButton: UIButton {
    
    var topic: Topic? {
        didSet {
            self.setTitle(self.topic?.title, forState: .Normal)
            self.reloadBlurredBackgroundImage()
        }
    }
    
    // MARK: - Initialization
    
    init() {
        super.init(frame: CGRectZero)
        
        self.adjustsImageWhenHighlighted = false
        self.rac_valuesForKeyPath("highlighted", observer: self).subscribeNext { _ in
            UIView.animateWithDuration(0.1, delay: 0.0, options: .BeginFromCurrentState, animations: {
                self.transform = (self.highlighted) ? CGAffineTransformMakeScale(0.95, 0.95) : CGAffineTransformIdentity
            }, completion: nil)
        }
        
        self.rac_valuesForKeyPath("frame", observer: self).subscribeNext { _ in
            self.reloadBlurredBackgroundImage()
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Blurring
    
    func reloadBlurredBackgroundImage() {
        if let headerImage = self.topic?.headerImage {
            var image = UIImage(image: headerImage, scaledToSize: self.frame.size)
            if let image = image?.blurredImageWithRadius(20.0, iterations: 1, tintColor: nil).applyLightEffect() {
                self.setBackgroundImage(image, forState: .Normal)
            }
        }
    }
    
    // MARK: -
    
}
