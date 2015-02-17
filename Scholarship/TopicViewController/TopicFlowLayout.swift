//
//  TopicFlowLayout.swift
//  Scholarship
//
//  Created by Laurin Brandner on 12/02/15.
//  Copyright (c) 2015 Laurin Brandner. All rights reserved.
//

import UIKit
import ReactiveCocoa

class TopicFlowLayout: UICollectionViewFlowLayout {
    
    private var layoutAttributes = [[UICollectionViewLayoutAttributes]]()
    
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
                    var origin = CGPoint(x: self.sectionInset.left, y: self.sectionInset.top)
                    
                    for s in 0..<(dataSource.numberOfSectionsInCollectionView?(collectionView) ?? 0) {
                        let numberOfItems = dataSource.collectionView(collectionView, numberOfItemsInSection: s)
                        
                        var layoutAttributes = [UICollectionViewLayoutAttributes]()
                        let numberOfSecondaryItems = numberOfItems-1
                        
                        if numberOfItems > 0 {
                            let mainItemSize = delegate.collectionView?(collectionView, layout: self, sizeForItemAtIndexPath: NSIndexPath(forItem: 0, inSection: s)) ?? CGSizeZero
                            let secondaryItemSize: CGSize = {
                                let spacing = CGFloat(numberOfSecondaryItems-1)*self.minimumInteritemSpacing
                                let width = (mainItemSize.width-spacing)/CGFloat(numberOfSecondaryItems)
                                
                                return CGSize(width: width, height: self.secondaryItemHeight)
                            }()
                            
                            for i in 0..<numberOfItems {
                                var frame = CGRectZero
                                if i == 0 {
                                    frame = CGRect(center: CGPoint(x: collectionView.bounds.midX, y: mainItemSize.height/2.0+origin.y), size: mainItemSize)
                                    origin = CGPoint(x: frame.minX, y: frame.maxY+self.minimumLineSpacing)
                                }
                                else {
                                    frame = CGRect(origin: origin, size: secondaryItemSize)
                                    
                                    if i == numberOfItems-1 {
                                        origin = CGPoint(x: self.sectionInset.left, y: frame.maxY+self.sectionInset.bottom+self.sectionInset.top)
                                    }
                                    else {
                                        origin.x = frame.maxX+self.minimumInteritemSpacing
                                    }
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
