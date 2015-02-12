//
//  TopicViewController.swift
//  Scholarship
//
//  Created by Laurin Brandner on 11/02/15.
//  Copyright (c) 2015 Laurin Brandner. All rights reserved.
//

import UIKit
import Cartography

class TopicViewController: UIViewController {
    
    let topic: Topic
    
    let headerView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .ScaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    let collectionView: UICollectionView = {
        let layout = TopicFlowLayout()
        let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        
        return collectionView
    }()

    // MARK: - Initialization
    
    init(topic: Topic) {
        self.topic = topic
        
        super.init(nibName: nil, bundle: nil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func loadView() {
        super.loadView()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.headerView.image = self.topic.headerImage
        self.view.addSubview(self.headerView)
        constrain(self.view, self.headerView) { view, headerView in
            headerView.width == view.width
            headerView.top == view.top
            headerView.left == view.left
            headerView.height == view.height*0.1
        }
        
        //self.collectionView.dataSource = self
        self.view.addSubview(self.collectionView)
        constrain(self.view, self.headerView, self.collectionView) { view, headerView, collectionView in
            collectionView.width == view.width
            collectionView.bottom == view.bottom
            collectionView.top == headerView.bottom
        }
    }
    
    // MARK: - UICollectionViewDataSource
    
//    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
//        return self.topic.paragraphs.count
//    }
//    
//    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 1+self.topic.paragraphs[section].image.map {
//            return 1
//        }
//    }
//    
//    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
//        
//    }
    
    // MARK: -
    
}
