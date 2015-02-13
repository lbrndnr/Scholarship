//
//  TopicViewController.swift
//  Scholarship
//
//  Created by Laurin Brandner on 11/02/15.
//  Copyright (c) 2015 Laurin Brandner. All rights reserved.
//

import UIKit
import Cartography

class TopicViewController: UICollectionViewController {
    
    let topic: Topic
    
    let headerView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .ScaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()

    // MARK: - Initialization
    
    init(topic: Topic) {
        self.topic = topic
        
        super.init(collectionViewLayout: TopicFlowLayout())
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func loadView() {
        super.loadView()
        
        self.collectionView?.backgroundColor = UIColor.whiteColor()
        self.collectionView?.alwaysBounceVertical = true
        
        self.headerView.image = self.topic.headerImage
        self.view.addSubview(self.headerView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let collectionView = self.collectionView {
            collectionView.backgroundColor = UIColor.whiteColor()
            collectionView.registerClass(TopicParagraphCell.self, forCellWithReuseIdentifier: "ParagraphCell")
            collectionView.registerClass(TopicImageCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "ImageCell")
            
            collectionView.contentInset = UIEdgeInsets(top: 200, left: 0.0, bottom: 0.0, right: 0.0)
            
            collectionView.rac_valuesForKeyPath("contentOffset", observer: self).subscribeNext { _ in
                let offset = collectionView.contentOffset.y
                if offset <= 0.0 {
                    let collectionViewFrame = collectionView.frame
                    self.headerView.frame = CGRect(x: 0.0, y: 0.0, width: collectionViewFrame.width, height: -offset)
                }
            }
        }
    }
    
    // MARK: - UICollectionViewDataSource
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return self.topic.paragraphs.count
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ParagraphCell", forIndexPath: indexPath) as TopicParagraphCell
        cell.textLabel.text = self.topic.paragraphs[indexPath.section].text
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "ImageCell", forIndexPath: indexPath) as TopicImageCell
        cell.imageView.image = self.topic.paragraphs[indexPath.section].image
        
        return cell
    }
    
    // MARK: -
    
}
