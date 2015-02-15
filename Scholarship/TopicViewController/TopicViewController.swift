//
//  TopicViewController.swift
//  Scholarship
//
//  Created by Laurin Brandner on 11/02/15.
//  Copyright (c) 2015 Laurin Brandner. All rights reserved.
//

import UIKit
import Cartography

private let paragraphCellIdentifier = "ParagraphCell"
private let imageCellIdentifier = "ImageCell"

class TopicViewController: HeaderCollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let topic: Topic

    // MARK: - Initialization
    
    init(topic: Topic) {
        self.topic = topic
        
        super.init(collectionViewLayout: TopicFlowLayout())
        
        self.headerImage = topic.headerImage
        self.title = topic.title
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
            collectionView.registerClass(TopicParagraphCell.self, forCellWithReuseIdentifier: paragraphCellIdentifier)
            collectionView.registerClass(TopicImageCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: imageCellIdentifier)
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
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(paragraphCellIdentifier, forIndexPath: indexPath) as TopicParagraphCell
        cell.textLabel.text = self.topic.paragraphs[indexPath.section].text
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: imageCellIdentifier, forIndexPath: indexPath) as TopicImageCell
        cell.imageView.image = self.topic.paragraphs[indexPath.section].image
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let text: NSString = self.topic.paragraphs[indexPath.section].text
        let bounds = collectionView.bounds
        let constraint = CGSize(width: 0.6*bounds.width, height: CGFloat.max)
        let attributes = [NSFontAttributeName: UIFont.lightHelveticaNeueWithSize(18.0)]
        
        return text.boundingRectWithSize(constraint, options: .UsesLineFragmentOrigin, attributes: attributes, context: nil).size
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if let image = self.topic.paragraphs[section].image {
            let bounds = collectionView.bounds
            return CGSize(width: 0.2*bounds.width, height: 50)
        }
        
        return CGSizeZero
    }
    
    // MARK: -
    
}
