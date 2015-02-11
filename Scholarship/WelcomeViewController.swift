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
        
        button.rac_signalForControlEvents(.TouchUpInside).merge(button.rac_signalForControlEvents(.TouchUpOutside)).subscribeNext { _ in
            setNewImage()
        }
        
        button.rac_valuesForKeyPath("bounds", observer: self).subscribeNext { _ in
            button.layer.cornerRadius = button.bounds.height/2.0
        }
        
        return button
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        
        func attributedStringWithText(text: String, #color: UIColor, #font: UIFont, #lineSpacing: CGFloat) -> NSAttributedString {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = lineSpacing
            let attributes = [NSForegroundColorAttributeName: color, NSFontAttributeName: font, NSParagraphStyleAttributeName: paragraphStyle]
            
            return NSAttributedString(string: text, attributes: attributes)
        }
        
        let title = NSLocalizedString("Hi There!\n", comment: "Introduction Title")
        let attributedTitle = attributedStringWithText(title, color: UIColor(white: 0.0, alpha: 0.8), font: UIFont.lightHelveticaNeueWithSize(36.0), lineSpacing: 30.0)
        
        let text = NSLocalizedString("My name is Laurin Brandner. I’m a 20-year-old student living in Switzerland.\n \nTap on the topics below to learn more about me.", comment: "Introduction Text")
        let attributedText = attributedStringWithText(text, color: UIColor(white: 0.0, alpha: 0.7), font: UIFont.lightHelveticaNeueWithSize(18.0), lineSpacing: 8.0)
        
        label.attributedText = attributedTitle+attributedText
        
        return label
    }()
    
    // MARK: - View Lifecycle
    
    override func loadView() {
        super.loadView()
        
        let offset = 20.0
        
        self.view.addSubview(self.avatarButton)
        constrain(self.view, self.avatarButton) { view, avatarButton in
            avatarButton.width  == 240
            avatarButton.height == 240
            avatarButton.trailing == view.centerX-offset
            avatarButton.top == view.top+160
        }
        
        self.view.addSubview(self.textLabel)
        constrain(self.view, self.avatarButton, self.textLabel) { view, avatarButton, textLabel in
            textLabel.top == avatarButton.top
            textLabel.leading == view.centerX+offset
            textLabel.width == view.width*0.3
        }

    }
    
    // MARK: -


}

