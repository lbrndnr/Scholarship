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
    
    private let blurView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .Light)
        let visualEffectView = UIVisualEffectView(effect: effect)
        
        return visualEffectView
    }()

    // MARK: - Initialization
    
    override init() {
        super.init(frame: CGRectZero)
        
        if let imageView = self.imageView {
            self.insertSubview(self.blurView, aboveSubview: imageView)
            
            // Swift bug
            constrain(self, self.blurView) { view, blurView in
                blurView.edges == view.edges; return
            }
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: -

}
