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
        
        let setNewImage: () -> () = {
            var index = 0
            return {
                let image = images[index]
                button.setImage(image, forState: .Highlighted)
                
                index += 1
                if index >= images.count {
                    index = 0
                }
            }
        }()
        
        setNewImage()
        button.rac_signalForControlEvents(.TouchUpInside).subscribeNext { _ in
            setNewImage()
        }
        
        button.rac_valuesForKeyPath("bounds", observer: self).subscribeNext { _ in
            button.layer.cornerRadius = button.bounds.height/2.0
        }
        
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Hi There!"
        label.font = UIFont.lightHelveticaNeueWithSize(24.0)
        label.numberOfLines = 1
        label.textColor = UIColor(white: 0.0, alpha: 0.8)
        label.textAlignment = .Center
        
        return label
        }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = "My name is Laurin Brandner. I’m a 20-year-old student living in Switzerland.\n \nI started programming when I was 14. With 15 I released my first iOS application.\nSince then, I have worked with various programming languages."
        label.font = UIFont.lightHelveticaNeueWithSize(18.0)
        label.numberOfLines = 0
        label.textColor = UIColor(white: 0.0, alpha: 0.7)
        
        return label
    }()
    
    // MARK: - View Lifecycle
    
    override func loadView() {
        super.loadView()
        
        self.view.addSubview(self.avatarButton)
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.textLabel)
        
        constrain(self.view, self.avatarButton) { view, avatarButton in
            avatarButton.width  == 150
            avatarButton.height == 150
            avatarButton.centerX == view.centerX
            avatarButton.top == view.top+50
        }
        
        constrain(self.view, self.avatarButton, self.titleLabel) { view, avatarButton, titleLabel in
            titleLabel.width == view.width*0.7
            titleLabel.top == avatarButton.bottom+25
            titleLabel.centerX == view.centerX
        }
        
        constrain(self.titleLabel, self.textLabel) { titleLabel, textLabel in
            textLabel.width == titleLabel.width
            textLabel.top == titleLabel.bottom+25
            textLabel.centerX == titleLabel.centerX
        }
    }
    
    // MARK: -


}

