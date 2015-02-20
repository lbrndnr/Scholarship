//
//  TopicViewController.swift
//  Scholarship
//
//  Created by Laurin Brandner on 11/02/15.
//  Copyright (c) 2015 Laurin Brandner. All rights reserved.
//

import UIKit
import StoreKit
import Cartography

private let paragraphCellIdentifier = "ParagraphCell"
private let imageCellIdentifier = "ImageCell"

class TopicViewController: HeaderCollectionViewController, UICollectionViewDelegateFlowLayout, SKStoreProductViewControllerDelegate {
    
    let topic: Topic
    
    private lazy var prototypingCell = TopicParagraphCell(frame: CGRectZero)

    // MARK: - Initialization
    
    init(topic: Topic) {
        self.topic = topic
        
        let layout = TopicFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20.0, left: 0.0, bottom: 0.0, right: 0.0)
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20

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
        
        if let collectionView = self.collectionView {
            collectionView.backgroundColor = UIColor.whiteColor()
            collectionView.alwaysBounceVertical = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let collectionView = self.collectionView {
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
            
            if let source = paragraph.source {
                cell.button.hidden = false
                cell.button.setTitle(source.name, forState: .Normal)
                
                switch source {
                case .GitHub(let URL):
                    cell.button.rac_signalForControlEvents(.TouchUpInside).subscribeNext { _ in
                        let parameters = [SKStoreProductParameterITunesItemIdentifier : ""]
                        let controller = SKStoreProductViewController()
                        controller.delegate = self
                        controller.loadProductWithParameters(parameters, completionBlock: nil)
                        self.presentViewController(controller, animated: true, completion: nil)
                    }
                    
                case .AppStore(let identifier):
                    cell.button.rac_signalForControlEvents(.TouchUpInside).subscribeNext { _ in
                        let parameters = [SKStoreProductParameterITunesItemIdentifier : identifier]
                        let controller = SKStoreProductViewController()
                        controller.delegate = self
                        controller.loadProductWithParameters(parameters, completionBlock: nil)
                        self.presentViewController(controller, animated: true, completion: nil)
                    }
                }
            }
            else {
                cell.button.hidden = true
            }
            
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(imageCellIdentifier, forIndexPath: indexPath) as TopicImageCell
            cell.imageView.image = paragraph.images?[indexPath.item-1]
            
            return cell
        }
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let bounds = collectionView.bounds
        
        let paragraph = self.topic.paragraphs[indexPath.section]

        let cell = TopicParagraphCell(frame: CGRectZero)
        cell.titleLabel.text = paragraph.title
        cell.textLabel.text = paragraph.text
        cell.imageView.image = paragraph.mainImage
        
        cell.bounds = CGRectMake(0, 0, 0.6*bounds.width, cell.bounds.height)
        cell.contentView.bounds = cell.bounds
        
        // Layout subviews, this will let labels on this cell to set preferredMaxLayoutWidth
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        
        return cell.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return self.topic.paragraphs[section].images.map { _ in CGSize(width: 0.2*collectionView.bounds.width, height: 50) } ?? CGSizeZero
    }

    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return (indexPath.item != 0)
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.item != 0 {
            let cell = collectionView.cellForItemAtIndexPath(indexPath) as TopicImageCell
            
            let imageInfo: JTSImageInfo = {
                let info = JTSImageInfo()
                info.image = cell.imageView.image
                info.referenceRect = cell.imageView.frame
                info.referenceView = cell.contentView
                info.referenceContentMode = cell.imageView.contentMode
                info.referenceCornerRadius = cell.imageView.layer.cornerRadius
            
                return info
            }()
            
            let controller = JTSImageViewController(imageInfo: imageInfo, mode: .Image, backgroundStyle: .Scaled)
            controller.showFromViewController(self, transition: ._FromOriginalPosition) {
                collectionView.deselectItemAtIndexPath(indexPath, animated: false)
            }
        }
        else {
            collectionView.deselectItemAtIndexPath(indexPath, animated: true)
        }
    }
    
    // MARK: - SKStoreProductViewControllerDelegate

    func productViewControllerDidFinish(viewController: SKStoreProductViewController!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: -
    
}
