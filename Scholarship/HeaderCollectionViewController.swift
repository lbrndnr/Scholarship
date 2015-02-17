//
//  HeaderCollectionViewController.swift
//  Scholarship
//
//  Created by Laurin Brandner on 13/02/15.
//  Copyright (c) 2015 Laurin Brandner. All rights reserved.
//

import UIKit
import Cartography
import ReactiveCocoa

class HeaderCollectionViewController: UICollectionViewController {

    var headerImage: UIImage?
    var defaultHeaderHeight: CGFloat = 200.0
    
    private lazy var headerView = UIView()
    
    private lazy var headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .ScaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private lazy var blurredHeaderImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .ScaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .Center
        label.font = UIFont.systemFontOfSize(24.0)
        label.textColor = UIColor.whiteColor()
        
        return label
    }()
    
    lazy var dismissButton: UIButton = {
        let button = UIButton.buttonWithType(.System) as UIButton
        button.setTitle(NSLocalizedString("Back", comment: "Back"), forState: .Normal)
        button.titleLabel?.font = UIFont.boldSystemFontOfSize(UIFont.labelFontSize())
        
        return button
    }()
    
    // MARK: - View Lifecycle
    
    override func loadView() {
        super.loadView()
        
        self.view.addSubview(self.headerView)
        
        self.headerView.addSubview(self.headerImageView)
        // Swift bug
        constrain(self.headerView, self.headerImageView) { headerView, headerImageView in
            headerImageView.edges == headerView.edges; return
        }
        
        self.headerView.addSubview(self.blurredHeaderImageView)
        // Swift bug
        constrain(self.headerView, self.blurredHeaderImageView) { headerView, blurredHeaderImageView in
            blurredHeaderImageView.edges == headerView.edges; return
        }
        
        self.headerView.addSubview(self.titleLabel)
        // Swift bug
        constrain(self.headerView, self.titleLabel) { headerView, titleLabel in
            titleLabel.edges == headerView.edges; return
        }
        
        self.view.addSubview(self.dismissButton)
        constrain(self.view, self.headerView, self.dismissButton) { view, headerView, dismissButton in
            dismissButton.right == view.right-30
            dismissButton.top == headerView.bottom+20
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rac_valuesForKeyPath("headerImage", observer: self).subscribeNext { _ in
            self.headerImageView.image = self.headerImage
            self.blurredHeaderImageView.image = self.headerImage?.applyBlurWithRadius(20.0, tintColor: UIColor(white: 0.11, alpha: 0.3), saturationDeltaFactor: 1.4, maskImage: nil)
        }
        
        if let collectionView = self.collectionView {
            collectionView.backgroundColor = UIColor.whiteColor()
            collectionView.registerClass(TopicParagraphCell.self, forCellWithReuseIdentifier: "ParagraphCell")
            collectionView.registerClass(TopicImageCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "ImageCell")
            
            self.rac_valuesForKeyPath("defaultHeaderHeight", observer: self).subscribeNext { _ in
                collectionView.contentInset = UIEdgeInsets(top: self.defaultHeaderHeight, left: 0.0, bottom: 0.0, right: 0.0)
            }
            
            collectionView.rac_valuesForKeyPath("contentOffset", observer: self).subscribeNext { _ in
                let offset = collectionView.contentOffset.y
                self.headerView.frame = CGRect(x: 0.0, y: 0.0, width: collectionView.frame.width, height: max(-offset, 0.0))
                
                if offset+self.defaultHeaderHeight < 0 {
                    self.blurredHeaderImageView.alpha = 1.0-((offset+self.defaultHeaderHeight)/(-self.defaultHeaderHeight))
                }
                else {
                    self.blurredHeaderImageView.alpha = 1.0
                }
            }
        }
        
        self.rac_valuesForKeyPath("title", observer: self).subscribeNext { _ in
            self.titleLabel.text = self.title
        }
        
        // Swift bug
        self.dismissButton.rac_signalForControlEvents(.TouchUpInside).subscribeNext { _ in
            self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil); return
        }
    }
    
    // MARK: - Status Bar Style
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    // MARK: -

}
