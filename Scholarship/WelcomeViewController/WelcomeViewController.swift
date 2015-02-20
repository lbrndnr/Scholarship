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
    private var topicButtons = [(TopicButton, ConstraintGroup)]()
    
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
            
            return (button, ConstraintGroup())
        }
        
        self.constrainTopicButtons(UIApplication.sharedApplication().statusBarOrientation)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for (button, _) in self.topicButtons {
            button.rac_signalForControlEvents(.TouchUpInside).subscribeNext() { _ in
                if let topic = button.topic {
                    let controller = TopicViewController(topic: topic)
                    self.navigationController?.presentViewController(controller, animated: true, completion: nil)
                }
            }
        }
    }
    
    func constrainTopicButtons(interfaceOrientation: UIInterfaceOrientation) {
        var previousButton: TopicButton?
        let middleIndex = Double(self.topicButtons.count)/2.0
        for (i, (button, constraints)) in enumerate(self.topicButtons) {
            
            var newConstraints: ConstraintGroup?
            if interfaceOrientation.isPortrait {
                let upperView = previousButton ?? self.avatarButton
                
                newConstraints = constrain(view, upperView, button, replace: constraints) { view, upperView, button in
                    button.centerX == view.centerX
                    button.top == upperView.bottom+50
                    button.width == view.width*0.6
                    button.height == 80
                }
            }
            else {
                
                if let previousButton = previousButton {
                    // Swift bug
                    constrain(self.view, previousButton, button, replace: constraints) { view, previousButton, button in
                        button.leading == previousButton.right+100; return
                    }
                }
                
                newConstraints = constrain(self.view, button, replace: constraints) { view, button in
                    let index = Double(i)
                    if index > middleIndex {
                        button.centerX >= view.centerX
                    }
                    else if index < middleIndex {
                        button.centerX <= view.centerX
                    }
                    else {
                        button.centerX == view.centerX
                    }
                    
                    button.bottom == view.bottom-120
                    button.width == 200
                    button.height == 130
                }
            }
            
            previousButton = button
            self.topicButtons[i] = (button, newConstraints ?? ConstraintGroup())
        }
    }
    
    // MARK: -
    
    
    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        self.constrainTopicButtons(toInterfaceOrientation)
        
        UIView.animateWithDuration(duration, delay: 0.0, options: .BeginFromCurrentState, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }

}

