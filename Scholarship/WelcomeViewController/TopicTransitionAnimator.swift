//
//  TopicTransitionAnimator.swift
//  Scholarship
//
//  Created by Laurin Brandner on 12/02/15.
//  Copyright (c) 2015 Laurin Brandner. All rights reserved.
//

import UIKit

class TopicTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let presenting: Bool
    let topicButton: BlurButton
    
    // MARK: - Initialization
    
    init(presenting: Bool, topicButton: BlurButton) {
        self.topicButton = topicButton
        self.presenting = presenting
        
        super.init()
    }
    
    // MARK: - UIViewControllerAnimatedTransitioning
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 2.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        
        if let fromViewController = fromViewController {
            if let toViewController = toViewController {
                let imageView = UIImageView(image: self.topicButton.backgroundImageForState(.Normal))
                imageView.contentMode = .ScaleAspectFill
                imageView.clipsToBounds = true
                imageView.frame = self.topicButton.frame
                
                toViewController.view.frame = fromViewController.view.frame
                toViewController.view.alpha = 0.0
                
                transitionContext.containerView().addSubview(toViewController.view)
                transitionContext.containerView().addSubview(imageView)
                
                UIView.animateWithDuration(self.transitionDuration(transitionContext), animations: {
                    imageView.frame = CGRectMake(0, 0, 1024, 80)
                    toViewController.view.alpha = 1.0
                    }, completion: { finished in
                        imageView.removeFromSuperview()
                        transitionContext.completeTransition(true)
                })
            }
        }
        
    }

}
