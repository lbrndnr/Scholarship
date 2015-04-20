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
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20

        super.init(collectionViewLayout: layout)
        
        self.headerImage = topic.headerImage
        self.title = topic.title
    }

    required init(coder aDecoder: NSCoder) {
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
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(paragraphCellIdentifier, forIndexPath: indexPath) as! TopicParagraphCell
            self.configureParagraphCell(cell, paragraph: paragraph)
            
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(imageCellIdentifier, forIndexPath: indexPath) as! TopicImageCell
            cell.imageView.image = paragraph.images?[indexPath.item-1].0
            
            return cell
        }
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let paragraph = self.topic.paragraphs[indexPath.section]
        
        let width = collectionView.bounds.width*0.6
        self.configureParagraphCell(self.prototypeCell, paragraph: paragraph)
        self.prototypeCell.setPreferedMaxLayoutWidthForCellWidth(width)
        
        return CGSize(width: width, height: self.prototypeCell.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return self.topic.paragraphs[section].images.map { _ in CGSize(width: 0.2*collectionView.bounds.width, height: 50) } ?? CGSizeZero
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        let defaultInset: CGFloat = 20
        let edgeInset: CGFloat = 60
        
        if (section == 0) {
            return UIEdgeInsets(top: edgeInset, left: 0, bottom: defaultInset, right: 0)
        }
        else if (section == collectionView.numberOfSections()-1) {
            return UIEdgeInsets(top: defaultInset, left: 0, bottom: edgeInset, right: 0)
        }
        
        return UIEdgeInsets(top: defaultInset, left: 0, bottom: defaultInset, right: 0)
    }

    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return (indexPath.item != 0)
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.deselectItemAtIndexPath(indexPath, animated: false)
        
        let delayTime = dispatch_time(DISPATCH_TIME_NOW,  Int64(0.03 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            let cell = collectionView.cellForItemAtIndexPath(indexPath) as! TopicImageCell
            let paragraph = self.topic.paragraphs[indexPath.section]
            
            let imageInfo: JTSMediaInfo = {
                let info = JTSMediaInfo()
                info.image = cell.imageView.image
                info.referenceRect = cell.imageView.frame
                info.referenceView = cell.contentView
                info.referenceContentMode = cell.imageView.contentMode
                info.referenceCornerRadius = cell.layer.cornerRadius
                info.videoURL = paragraph.images?[indexPath.item-1].1
                
                return info
            }()
            
            let controller = JTSImageViewController(imageInfo: imageInfo, mode: .Image, backgroundStyle: .Scaled)
            controller.showFromViewController(self, transition: ._FromOriginalPosition, completion: nil)
        }
    }
    
    // MARK: - SKStoreProductViewControllerDelegate

    func productViewControllerDidFinish(viewController: SKStoreProductViewController!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Other Methods
    
    func configureParagraphCell(cell: TopicParagraphCell, paragraph: Paragraph) {
        cell.titleLabel.text = paragraph.title
        cell.imageView.image = paragraph.mainImage
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        let attributes = [NSForegroundColorAttributeName: UIColor(white: 0.0, alpha: 0.7), NSFontAttributeName: UIFont.lightHelveticaNeueWithSize(16.0), NSParagraphStyleAttributeName: paragraphStyle]
        cell.textLabel.attributedText = NSAttributedString(string: paragraph.text, attributes: attributes)
        
        if let source = paragraph.source {
            cell.button.hidden = false
            cell.button.setTitle(source.name, forState: .Normal)
            
            switch source {
            case .GitHub(let URL):
                cell.button.rac_command = RACCommand(signalBlock: { _ in
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
                    
                    return RACSignal.empty()
                })
                
            case .AppStore(let identifier):
                cell.button.rac_command = RACCommand(signalBlock: { _ in
                    let parameters = [SKStoreProductParameterITunesItemIdentifier : identifier]
                    let controller = SKStoreProductViewController()
                    controller.delegate = self
                    controller.loadProductWithParameters(parameters, completionBlock: nil)
                    self.presentViewController(controller, animated: true, completion: nil)
                    
                    return RACSignal.empty()
                })
            }
        }
        else {
            cell.button.hidden = true
            cell.button.rac_command = nil
        }
    }
    
    // MARK: -
    
}
