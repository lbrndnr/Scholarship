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
        button.setImage(UIImage(named: "Laurin-wink"), forState: .Highlighted)

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
        
        let text = NSLocalizedString("My name is Laurin Brandner. I’m a 20-year-old developer living in Switzerland.\n \nTap on the topics below to learn more about me.", comment: "Introduction Text")
        let attributedText = attributedStringWithText(text, color: UIColor(white: 0.0, alpha: 0.7), font: UIFont.lightHelveticaNeueWithSize(18.0), lineSpacing: 8.0)
        
        label.attributedText = attributedTitle+attributedText
        
        return label
    }()
    
    let topics = [Topic.aboutTopic(), Topic.projectsTopic(), Topic.interestsTopic()]
    private var topicButtons = [TopicButton]()
    
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
            textLabel.centerY == avatarButton.centerY
            textLabel.leading == view.centerX+offset
            textLabel.width == view.width*0.3
        }
        
        self.topicButtons = self.topics.map { topic in
            let button = TopicButton()
            button.topic = topic
            button.titleLabel?.font = UIFont.systemFontOfSize(25.0)
            button.layer.cornerRadius = 5.0
            button.layer.masksToBounds = true
            
            self.view.addSubview(button)
            
            return button
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for button in self.topicButtons {
            button.rac_signalForControlEvents(.TouchUpInside).subscribeNext() { _ in
                if let topic = button.topic {
                    let controller = TopicViewController(topic: topic)
                    self.navigationController?.presentViewController(controller, animated: true, completion: nil)
                }
            }
        }
    }
    
    // MARK: - Layout
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.layoutTopicButtons(self.view.bounds, interfaceOrientation: UIApplication.sharedApplication().statusBarOrientation)
    }
    
    
    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        UIView.animateWithDuration(duration, delay: 0.0, options: .BeginFromCurrentState, animations: {
            let bounds = CGRect(origin: CGPointZero, size: CGSize(width: self.view.bounds.height, height: self.view.bounds.width))
            self.layoutTopicButtons(bounds, interfaceOrientation: toInterfaceOrientation)
        }, completion: nil)
    }
    
    func layoutTopicButtons(bounds: CGRect, interfaceOrientation: UIInterfaceOrientation) {
        if interfaceOrientation.isPortrait {
            let offset: CGFloat = 50
            let size = CGSize(width: 0.6*bounds.width, height: 80)
            var center: CGPoint = {
                let totalButtonHeight = CGFloat(self.topicButtons.count)*size.height
                let totalButtonOffset = CGFloat(self.topicButtons.count-1)*offset
                let centerY = self.avatarButton.frame.maxY+size.height/2+(bounds.maxY-self.avatarButton.frame.maxY-totalButtonHeight-totalButtonOffset)/2
                
                return CGPoint(x: bounds.midX, y: centerY)
                }()
            
            for button in self.topicButtons {
                button.frame = CGRect(center: center, size: size)
                
                center.y += size.height+offset
            }
        }
        else {
            let offset: CGFloat = 100
            let size = CGSize(width: 0.2*bounds.width, height: 130)
            var center: CGPoint = {
                let totalButtonWidth = CGFloat(self.topicButtons.count)*size.width
                let totalButtonOffset = CGFloat(self.topicButtons.count-1)*offset
                let centerX = size.width/2+(bounds.maxX-totalButtonWidth-totalButtonOffset)/2
                let centerY = self.avatarButton.frame.maxY+(bounds.maxY-self.avatarButton.frame.maxY)/2
                
                return CGPoint(x: centerX, y: centerY)
                }()
            
            for button in self.topicButtons {
                button.frame = CGRect(center: center, size: size)
                
                center.x += size.width+offset
            }
        }
    }
    
    // MARK: -

}

