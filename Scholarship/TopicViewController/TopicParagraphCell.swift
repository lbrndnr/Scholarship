//
//  TopicParagraphCell.swift
//  Scholarship
//
//  Created by Laurin Brandner on 13/02/15.
//  Copyright (c) 2015 Laurin Brandner. All rights reserved.
//

import UIKit
import Cartography

class TopicParagraphCell: UICollectionViewCell {

    var textLabel: UILabel = {
        let label = UILabel()
        
        
        return label
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initialize()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.initialize()
    }
    
    private func initialize() {
        self.contentView.addSubview(self.textLabel)
        // Swift bug
        constrain(self.contentView, self.textLabel) { view, textLabel in
            textLabel.edges == view.edges; return
        }
    }
    
    // MARK: -
    
}
