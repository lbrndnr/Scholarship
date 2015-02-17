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
        
        let layout = TopicFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10.0, left: 0.0, bottom: 10.0, right: 0.0)

        super.init(collectionViewLayout: layout)
        
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
            collectionView.registerClass(TopicImageCell.self, forCellWithReuseIdentifier: imageCellIdentifier)
        }
    }
    
    // MARK: - UICollectionViewDataSource
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return self.topic.paragraphs.count
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let paragraph = self.topic.paragraphs[section]
        
        return 1+(paragraph.images?.count ?? 0)
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let paragraph = self.topic.paragraphs[indexPath.section]
        
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(paragraphCellIdentifier, forIndexPath: indexPath) as TopicParagraphCell
            cell.titleLabel.text = paragraph.title
            cell.textLabel.text = paragraph.text
            cell.imageView.image = paragraph.mainImage
            
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(imageCellIdentifier, forIndexPath: indexPath) as TopicImageCell
            cell.imageView.image = paragraph.images?[indexPath.item-1]
            cell.backgroundColor = UIColor.greenColor()
            
            return cell
        }
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let text: NSString = self.topic.paragraphs[indexPath.section].text
        let bounds = collectionView.bounds
        let constraint = CGSize(width: 0.6*bounds.width, height: CGFloat.max)
        let attributes = [NSFontAttributeName: UIFont.lightHelveticaNeueWithSize(18.0)]
        
        return text.boundingRectWithSize(constraint, options: .UsesLineFragmentOrigin, attributes: attributes, context: nil).size
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if let images = self.topic.paragraphs[section].images {
            let bounds = collectionView.bounds
            return CGSize(width: 0.2*bounds.width, height: 50)
        }
        
        return CGSizeZero
    }
    
    // MARK: -
    
}
