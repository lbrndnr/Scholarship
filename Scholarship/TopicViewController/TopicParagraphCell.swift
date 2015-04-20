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
    
    let button: UIButton = {
        let button = UIButton.buttonWithType(.System) as! UIButton
        button.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        button.titleLabel?.font = UIFont.boldSystemFontOfSize(UIFont.systemFontSize())
        
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.lightHelveticaNeueWithSize(20.0)
        label.textColor = UIColor(white: 0.0, alpha: 0.8)
        
        return label
    }()
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        
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
        
        constrain(self.contentView, self.imageView, self.titleLabel) { view, imageView, titleLabel in
            imageView.leading == view.left
            imageView.top == view.top
            imageView.width <= 120
            imageView.height <= view.height
            
            titleLabel.top == view.top
            leadingTitleLabelConstraint = (titleLabel.leading == view.left)
            titleLabel.right == view.right
        }
        
        self.contentView.addSubview(self.button)
        constrain(self.contentView, self.button, self.imageView) { view, button, imageView in
            button.top == imageView.bottom+10
            button.right == imageView.right
            button.left == imageView.left
        }
        
        self.contentView.addSubview(self.textLabel)
        constrain(self.contentView, self.titleLabel, self.textLabel) { view, titleLabel, textLabel in
            textLabel.top == titleLabel.bottom+10
            textLabel.leading == titleLabel.leading
            textLabel.right == view.right
            textLabel.bottom == view.bottom
        }
        
        self.rac_valuesForKeyPath("imageView.image", observer: self).subscribeNext { _ in
            let offset: CGFloat = (self.imageView.image == nil) ? 0 : 20
            let imageWidth = min(self.imageView.image?.size.width ?? 0, 120)
            leadingTitleLabelConstraint?.constant = offset+imageWidth
        }
    }
    
    // MARK: - Layout
    
    func setPreferedMaxLayoutWidthForCellWidth(var width: CGFloat) {
        self.bounds = CGRect(origin: CGPointZero, size: CGSize(width: width, height: 500))
        self.contentView.frame = self.bounds
        
        self.setNeedsLayout()
        self.layoutIfNeeded()
        
        width -= self.titleLabel.frame.minX
        
        self.titleLabel.preferredMaxLayoutWidth = width
        self.textLabel.preferredMaxLayoutWidth = width
    }
    
    // MARK: -
    
}
