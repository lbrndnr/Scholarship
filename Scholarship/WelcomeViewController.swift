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

    private lazy var avatarButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.redColor()
        button.layer.masksToBounds = true
        button.setImage(UIImage(named: "Laurin"), forState: .Normal)
        
        let images = [UIImage(named: "Laurin-wink"), UIImage(named: "Laurin-sarcastic")]
        
        let setImageAtIndex: (Int) -> () = { index in
            let image = images[index]
            button.setImage(image, forState: .Highlighted)
        }
        
        setImageAtIndex(0)
        button.rac_signalForControlEvents(.TouchUpInside).subscribeNext { _ in
            let index = Int(arc4random_uniform(UInt32(images.count)))
            setImageAtIndex(index)
        }
        
        button.rac_valuesForKeyPath("bounds", observer: self).subscribeNext { _ in
            button.layer.cornerRadius = button.bounds.height/2.0
        }
        
        return button
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = "Hi There! \n My name is Laurin. I'm from Switzerland. I code. A lot."
        label.font = UIFont.systemFontOfSize(24.0)
        label.backgroundColor = UIColor.greenColor()
        label.numberOfLines = 0
        label.textAlignment = .Center
        
        return label
    }()
    
    private lazy var projectsLabel: ImageLabel = {
        let image = UIImage(named: "crimson-banner")
        let imageLabel = ImageLabel(text: NSLocalizedString("Projects", comment: "Projects"), image: image)
        
        return imageLabel
    }()
    
    private lazy var hobbiesLabel: ImageLabel = {
        let image = UIImage(named: "crimson-banner")
        let imageLabel = ImageLabel(text: NSLocalizedString("Hobbies", comment: "Hobbies"), image: image)
        
        return imageLabel
    }()
    
    // MARK: - View Lifecycle
    
    override func loadView() {
        super.loadView()
        
        self.view.addSubview(self.avatarButton)
        self.view.addSubview(self.textLabel)
        
        constrain(self.view, self.avatarButton, self.textLabel) { view, avatarButton, textLabel in
            avatarButton.width  == 150
            avatarButton.height == 150
            avatarButton.centerX == view.centerX
            avatarButton.top == view.top+50
            
            textLabel.width == view.width*0.6
            textLabel.height == 300
            textLabel.top == avatarButton.bottom+50
            textLabel.centerX == view.centerX
        }
        
        self.view.addSubview(self.projectsLabel)
        self.view.addSubview(self.hobbiesLabel)
        
        constrain(self.view, self.projectsLabel, self.hobbiesLabel) { view, projectsLabel, hobbiesLabel in
            hobbiesLabel.width == view.width
            hobbiesLabel.height == 50
            hobbiesLabel.bottom == view.bottom
            
            projectsLabel.width == view.width
            projectsLabel.height == 50
            projectsLabel.bottom == hobbiesLabel.top
        }
    }
    
    // MARK: -


}

