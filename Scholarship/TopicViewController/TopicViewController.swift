//
//  TopicViewController.swift
//  Scholarship
//
//  Created by Laurin Brandner on 11/02/15.
//  Copyright (c) 2015 Laurin Brandner. All rights reserved.
//

import UIKit
import Cartography

class TopicViewController: HeaderCollectionViewController {
    
    let topic: Topic

    // MARK: - Initialization
    
    init(topic: Topic) {
        self.topic = topic
        
        super.init(collectionViewLayout: TopicFlowLayout())
        
        self.headerImage = topic.headerImage
    }

    required override init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func loadView() {
        super.loadView()
        
        self.collectionView?.backgroundColor = UIColor.whiteColor()
        self.collectionView?.alwaysBounceVertical = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let collectionView = self.collectionView {
            collectionView.backgroundColor = UIColor.whiteColor()
            collectionView.registerClass(TopicParagraphCell.self, forCellWithReuseIdentifier: "ParagraphCell")
            collectionView.registerClass(TopicImageCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "ImageCell")
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
