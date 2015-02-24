//
//  TopicViewController.swift
//  Scholarship
//
//  Created by Laurin Brandner on 11/02/15.
//  Copyright (c) 2015 Laurin Brandner. All rights reserved.
//

import UIKit
import ReactiveCocoa
import StoreKit
import Cartography

private let paragraphCellIdentifier = "ParagraphCell"
private let imageCellIdentifier = "ImageCell"

class TopicViewController: HeaderCollectionViewController, UICollectionViewDelegateFlowLayout, SKStoreProductViewControllerDelegate {
    
    let topic: Topic
    
    private lazy var prototypeCell = TopicParagraphCell(frame: CGRectZero)

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
            self.configureParagraphCell(cell, paragraph: paragraph)
            
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
        self.configureParagraphCell(self.prototypeCell, paragraph: paragraph)
        
        self.prototypeCell.bounds = CGRectMake(0, 0, 0.6*bounds.width, self.prototypeCell.bounds.height)
        self.prototypeCell.contentView.bounds = self.prototypeCell.bounds
        
        // Layout subviews, this will let labels on this cell to set preferredMaxLayoutWidth
        self.prototypeCell.setNeedsLayout()
        self.prototypeCell.layoutIfNeeded()
        
        return self.prototypeCell.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
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
            
            let imageInfo: JTSMediaInfo = {
                let info = JTSMediaInfo()
                info.image = cell.imageView.image
                info.referenceRect = cell.imageView.frame
                info.referenceView = cell.contentView
                info.referenceContentMode = cell.imageView.contentMode
                info.referenceCornerRadius = cell.imageView.layer.cornerRadius
                info.videoURL = NSBundle.mainBundle().URLForResource("Crimson-Typing", withExtension: "mp4")
            
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
    
    // MARK: - Other Methods
    
    func configureParagraphCell(cell: TopicParagraphCell, paragraph: Topic.Paragraph) {
        cell.titleLabel.text = paragraph.title
        cell.textLabel.text = paragraph.text
        cell.imageView.image = paragraph.mainImage
        
        if let source = paragraph.source {
            cell.button.hidden = false
            cell.button.setTitle(source.name, forState: .Normal)
            
            switch source {
            case .GitHub(let URL):
                cell.button.rac_signalForControlEvents(.TouchUpInside).subscribeNext { _ in
                    let controller  = WebViewController()
                    controller.title = source.name
                    controller.webView.loadRequest(NSURLRequest(URL: URL))
                    
                    controller.navigationItem.rightBarButtonItem = {
                        let item = UIBarButtonItem(title: NSLocalizedString("Open in Safari", comment: "Open in Safari"), style: .Plain, target: nil, action: nil)
                        item.rac_command = RACCommand(signalBlock: { _ in
                            UIApplication.sharedApplication().openURL(URL)
                            self.dismissViewControllerAnimated(true, completion: nil)
                            
                            return RACSignal.empty()
                        })
                        
                        return item
                    }()
                    
                    controller.navigationItem.leftBarButtonItem = {
                        let item = UIBarButtonItem(barButtonSystemItem: .Cancel, target: nil, action: nil)
                        item.rac_command = RACCommand(signalBlock: { _ in
                            self.dismissViewControllerAnimated(true, completion: nil)
                            
                            return RACSignal.empty()
                        })
                        
                        return item
                    }()
                    
                    let navigationController = UINavigationController(rootViewController: controller)
                    navigationController.modalPresentationStyle = .FormSheet
                    
                    self.presentViewController(navigationController, animated: true, completion: nil)
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
    }
    
    // MARK: -
    
}
