//
//  TopicFlowLayout.swift
//  Scholarship
//
//  Created by Laurin Brandner on 12/02/15.
//  Copyright (c) 2015 Laurin Brandner. All rights reserved.
//

import UIKit
import ReactiveCocoa

class TopicFlowLayout: UICollectionViewLayout {
    
    private var layoutAttributes = [[UICollectionViewLayoutAttributes]]()
    
    var sectionInset: UIEdgeInsets = UIEdgeInsetsZero {
        didSet {
            self.invalidateLayout()
        }
    }
    
    var secondaryItemHeight: CGFloat = 100.0 {
        didSet {
            self.invalidateLayout()
        }
    }
    
    // MARK: - Layout
    
    override func prepareLayout() {
        super.prepareLayout()
        
        self.layoutAttributes.removeAll(keepCapacity: false)
        
        // Swift 1.2 improvements
        if let collectionView = self.collectionView {
            if let dataSource = collectionView.dataSource {
                if let delegate = collectionView.delegate as? UICollectionViewDelegateFlowLayout {
                    for s in 0..<(dataSource.numberOfSectionsInCollectionView?(collectionView) ?? 0) {
                        let numberOfItems = dataSource.collectionView(collectionView, numberOfItemsInSection: s)
                        
                        var layoutAttributes = [UICollectionViewLayoutAttributes]()
                        var origin = CGPoint(x: self.sectionInset.left, y: self.sectionInset.top)
                        let numberOfSecondaryItems = numberOfItems-1
                        
                        if numberOfItems > 0 {
                            let mainItemSize = delegate.collectionView?(collectionView, layout: self, sizeForItemAtIndexPath: NSIndexPath(forItem: 0, inSection: s)) ?? CGSizeZero
                            let secondaryItemSize = CGSize(width: mainItemSize.width/CGFloat(numberOfSecondaryItems), height: self.secondaryItemHeight)
                            
                            for i in 0..<numberOfItems {
                                var frame = CGRectZero
                                if i == 0 {
                                    frame = CGRect(center: CGPoint(x: collectionView.bounds.midX, y: mainItemSize.height/2.0), size: mainItemSize)
                                    origin = CGPoint(x: frame.minX, y: frame.maxY)
                                }
                                else {
                                    frame = CGRect(origin: origin, size: secondaryItemSize)
                                    origin.x = frame.maxX
                                }
                                
                                let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: NSIndexPath(forItem: i, inSection: s))
                                attributes.frame = frame
                                
                                layoutAttributes.append(attributes)
                            }
                        }
                        
                        self.layoutAttributes.append(layoutAttributes)
                    }
                }
            }
        }
    }
    
    override func collectionViewContentSize() -> CGSize {
        let rect = self.layoutAttributes.reduce(CGRectZero) { memo, section in
            return section.reduce(memo) { memo, attributes in
                return CGRectUnion(memo, attributes.frame)
            }
        }
        
        return rect.size
    }
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return (self.collectionView?.bounds.width ?? 0) != newBounds.width
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
        let allAttributes = self.layoutAttributes.reduce([UICollectionViewLayoutAttributes]()) { $0 + $1 }
        
        return allAttributes.filter { attributes in
            CGRectIntersectsRect(rect, attributes.frame)
        }
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes! {
        return self.layoutAttributes[indexPath.section][indexPath.item]
    }
    
    // MARK: -
    
    
}
