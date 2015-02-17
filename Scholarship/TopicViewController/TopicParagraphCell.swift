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

    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .Center
        
        return imageView
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.lightHelveticaNeueWithSize(20.0)
        label.textColor = UIColor(white: 0.0, alpha: 0.8)
        
        return label
    }()
    
    var textLabel: UILabel = {
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
        
        let offset: CGFloat = 10
        constrain(self.contentView, self.titleLabel, self.imageView) { view, titleLabel, imageView in
            imageView.top == view.top+offset
            imageView.leading == view.left+offset
            
            titleLabel.leading == imageView.right+2*offset
            titleLabel.top == imageView.top
        }
        
        self.contentView.addSubview(self.textLabel)
        constrain(self.contentView, self.titleLabel, self.textLabel) { view, titleLabel, textLabel in
            textLabel.leading == titleLabel.leading
            textLabel.top == titleLabel.bottom+offset
            textLabel.trailing == view.right-offset
        }
    }
    
    // MARK: -
    
}
