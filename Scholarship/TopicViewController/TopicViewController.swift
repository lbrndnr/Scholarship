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
    }
    
    // MARK: -
    
}
