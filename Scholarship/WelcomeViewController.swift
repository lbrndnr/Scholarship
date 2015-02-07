//
//  ViewController.swift
//  Scholarship
//
//  Created by Laurin Brandner on 06/02/15.
//  Copyright (c) 2015 Laurin Brandner. All rights reserved.
//

import UIKit
import Cartography
import ReactiveCocoa

class WelcomeViewController: UIViewController {

    lazy var avatarButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.redColor()
        
        button.rac_signalForControlEvents(.TouchDown).subscribeNext { _ in
            button.backgroundColor = UIColor.greenColor()
        }
        button.rac_signalForControlEvents(.TouchUpInside).subscribeNext { _ in
            button.backgroundColor = UIColor.redColor()
        }
        
        return button
    }()
    
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = "Hi There! \n My name is Laurin. I'm from Switzerland. I code. A lot."
        label.font = UIFont.systemFontOfSize(24.0)
        label.backgroundColor = UIColor.greenColor()
        label.numberOfLines = 0
        label.textAlignment = .Center
        
        return label
    }()
    
    // MARK: - View Lifecycle
    
    override func loadView() {
        super.loadView()
        
        self.view.addSubview(self.avatarButton)
        self.view.addSubview(self.textLabel)
        
        constrain(self.view, self.avatarButton, self.textLabel) { view, avatarButton, textLabel in
            avatarButton.width  == 100
            avatarButton.height == 100
            avatarButton.centerX == view.centerX
            avatarButton.top == view.top+50
            
            textLabel.width == view.width*0.6
            textLabel.height == 300
            textLabel.top == avatarButton.bottom+50
            textLabel.centerX == view.centerX
        }
    }
    
    // MARK: -


}

