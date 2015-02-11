//
//  ImageLabel.swift
//  Scholarship
//
//  Created by Laurin Brandner on 07/02/15.
//  Copyright (c) 2015 Laurin Brandner. All rights reserved.
//

import UIKit
import Cartography

class BlurButton: UIButton {
    
    // MARK: - Initialization
    
    override init() {
        super.init(frame: CGRectZero)
        
        if let imageView = self.imageView {
            let effect = UIBlurEffect(style: .Light)
            let blurView = UIVisualEffectView(effect: effect)
            self.insertSubview(blurView, aboveSubview: imageView)
            
            // Swift bug
            constrain(self, blurView) { view, blurView in
                blurView.edges == view.edges; return
            }
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: -

}
