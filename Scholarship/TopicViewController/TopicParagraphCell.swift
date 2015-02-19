//
//  TopicParagraphCell.swift
//  Scholarship
//
//  Created by Laurin Brandner on 13/02/15.
//  Copyright (c) 2015 Laurin Brandner. All rights reserved.
//

import UIKit
import Cartography
import ReactiveCocoa

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
        
        var leadingTitleLabelConstraint: NSLayoutConstraint?
        var trailingTitleLabelConstraint: NSLayoutConstraint?
        
        constrain(self.contentView, self.titleLabel, self.imageView) { view, titleLabel, imageView in
            imageView.leading == view.left
            imageView.top == view.top
            imageView.width <= 120
            imageView.height <= view.height
            
            titleLabel.top == imageView.top
            leadingTitleLabelConstraint = titleLabel.leading == imageView.right
            trailingTitleLabelConstraint = titleLabel.trailing == view.right
        }
        
        self.contentView.addSubview(self.textLabel)
        constrain(self.contentView, self.titleLabel, self.textLabel) { view, titleLabel, textLabel in
            textLabel.top == titleLabel.bottom
            textLabel.leading == titleLabel.leading
            textLabel.trailing == titleLabel.trailing
            textLabel.bottom == view.bottom
        }
        
        self.rac_valuesForKeyPath("imageView.image", observer: self).subscribeNext { _ in
            let offset: CGFloat = (self.imageView.image == nil) ? 0 : 20
            
            leadingTitleLabelConstraint?.constant = offset
            trailingTitleLabelConstraint?.constant = -offset
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let width = self.bounds.width-self.imageView.frame.width
        self.titleLabel.preferredMaxLayoutWidth = width
        self.textLabel.preferredMaxLayoutWidth = width
    }
    
    // MARK: -
    
}
