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

class BlurButton: UIButton {
    
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
        
        let duration = 0.2
        let damping: CGFloat = 0.6
        self.rac_signalForControlEvents(.TouchDown).subscribeNext { _ in
            UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: damping, initialSpringVelocity: 0.0, options: .BeginFromCurrentState, animations: {
                self.transform = CGAffineTransformMakeScale(0.95, 0.95);
            }, completion: nil)
        }
        
        RACSignal.merge([self.rac_signalForControlEvents(.TouchUpInside), self.rac_signalForControlEvents(.TouchUpOutside)]).subscribeNext { _ in
            UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: damping, initialSpringVelocity: 0.0, options: .BeginFromCurrentState, animations: {
                self.transform = CGAffineTransformIdentity
                }, completion: nil)
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: -

}
