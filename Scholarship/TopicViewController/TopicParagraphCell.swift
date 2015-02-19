//
//  TopicParagraphCell.swift
//  Scholarship
//
//  Created by Laurin Brandner on 13/02/15.
//  Copyright (c) 2015 Laurin Brandner. All rights reserved.
//

import UIKit
import Cartography

class TopicParagraphCell: UICollectionViewCell {

    let imageView: UIImageView = UIImageView()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.lightHelveticaNeueWithSize(20.0)
        label.textColor = UIColor(white: 0.0, alpha: 0.8)
        
        return label
    }()
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.lightHelveticaNeueWithSize(18.0)
        label.textColor = UIColor(white: 0.0, alpha: 0.7)
        
        return label
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
        self.contentView.addSubview(self.imageView)
        self.contentView.addSubview(self.titleLabel)
        
        constrain(self.contentView, self.titleLabel, self.imageView) { view, titleLabel, imageView in
            imageView.leading == view.left
            imageView.top == view.top
            imageView.width <= 120
            imageView.height <= view.height
            
            titleLabel.leading == imageView.right+20
            titleLabel.top == imageView.top
        }
        
        self.contentView.addSubview(self.textLabel)
        constrain(self.contentView, self.titleLabel, self.textLabel) { view, titleLabel, textLabel in
            textLabel.top == titleLabel.bottom
            textLabel.leading == titleLabel.leading
            textLabel.trailing == view.right
        }
    }
    
    // MARK: -
    
}
