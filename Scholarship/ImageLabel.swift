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
        
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .ScaleAspectFill
        
        return imageView
    }()
    
    private let blurView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .Dark)
        let visualEffectView = UIVisualEffectView(effect: effect)
        
        return visualEffectView
    }()

    // MARK: - Initialization
    
    init(text: String, image: UIImage) {
        super.init()
        
        self.textLabel.text = text
        self.imageView.image = image
        
        self.addSubview(self.blurView)
        self.blurView.contentView.addSubview(self.imageView)
        self.addSubview(self.textLabel)
        
        constrain(self, self.textLabel, self.blurView) { view, textLabel, blurView in
            textLabel.edges == view.edges
            blurView.edges == view.edges
        }

    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: -

}
