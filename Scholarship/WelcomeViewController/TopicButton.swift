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
            self.setBackgroundImage(self.topic?.headerImage, forState: .Normal)
        }
    }
    
    // MARK: - Initialization
    
    override init() {
        super.init(frame: CGRectZero)
        
        self.adjustsImageWhenHighlighted = false
        if let imageView = self.imageView {
            let effect = UIBlurEffect(style: .Light)
            let blurView = UIVisualEffectView(effect: effect)
            blurView.userInteractionEnabled = false
            self.insertSubview(blurView, aboveSubview: imageView)
            
            // Swift bug
            constrain(self, blurView) { view, blurView in
                blurView.edges == view.edges; return
            }
        }
        
        self.rac_valuesForKeyPath("highlighted", observer: self).subscribeNext { _ in
            UIView.animateWithDuration(0.2, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.0, options: .BeginFromCurrentState, animations: {
                self.transform = (self.highlighted) ? CGAffineTransformMakeScale(0.95, 0.95) : CGAffineTransformIdentity
            }, completion: nil)
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: -

}