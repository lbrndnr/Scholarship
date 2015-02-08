//
//  ImageLabel.swift
//  Scholarship
//
//  Created by Laurin Brandner on 07/02/15.
//  Copyright (c) 2015 Laurin Brandner. All rights reserved.
//

import UIKit
import Cartography

class ImageLabel: UIView {
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .Center
        
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .ScaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private let blurView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .Light)
        let visualEffectView = UIVisualEffectView(effect: effect)
        
        return visualEffectView
    }()

    // MARK: - Initialization
    
    init(text: String, image: UIImage?) {
        super.init(frame: CGRect())
        
        self.textLabel.text = text
        self.imageView.image = image
        
        self.addSubview(self.imageView)
        self.imageView.addSubview(self.blurView)
        self.addSubview(self.textLabel)
        
        constrain(self, self.textLabel, self.imageView) { view, textLabel, imageView in
            textLabel.edges == view.edges
            imageView.edges == view.edges
        }
        
        constrain(self.imageView, self.blurView) { imageView, blurView in
            // Swift bug
            blurView.edges == imageView.edges; return
        }
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: -
    

}
