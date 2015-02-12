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
    
    let headerView = UIImageView()

    // MARK: Initialization
    
    init(topic: Topic) {
        self.topic = topic
        
        super.init(nibName: nil, bundle: nil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    // MARK: View Lifecycle
    
    override func loadView() {
        super.loadView()
        
        self.headerView.image = self.topic.headerImage
        self.view.addSubview(self.headerView)
        constrain(self.view, self.headerView) { view, headerView in
            headerView.width == view.width
            headerView.top == view.top
            headerView.left == view.left
        }
    }
    
    // MARK: -
    
}
