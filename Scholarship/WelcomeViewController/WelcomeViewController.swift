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

class WelcomeViewController: UIViewController, UIViewControllerTransitioningDelegate {

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
        
        let text = NSLocalizedString("My name is Laurin Brandner. I’m a 20-year-old student living in Switzerland.\n \nTap on the topics below to learn more about me.", comment: "Introduction Text")
        let attributedText = attributedStringWithText(text, color: UIColor(white: 0.0, alpha: 0.7), font: UIFont.lightHelveticaNeueWithSize(18.0), lineSpacing: 8.0)
        
        label.attributedText = attributedTitle+attributedText
        
        return label
    }()
    
    private lazy var topicButtons: [BlurButton] = {
        func styleButton(button: UIButton) {
            button.titleLabel?.font = UIFont.systemFontOfSize(25.0)
            button.layer.cornerRadius = 5.0
            button.layer.masksToBounds = true
        }
        
        let aboutButton = BlurButton()
        aboutButton.setBackgroundImage(UIImage(named: "About"), forState: .Normal)
        aboutButton.setTitle(NSLocalizedString("About Me", comment: "About Me"), forState: .Normal)
        styleButton(aboutButton)
        
        let projectsButton = BlurButton()
        projectsButton.setBackgroundImage(UIImage(named: "Projects"), forState: .Normal)
        projectsButton.setTitle(NSLocalizedString("Projects", comment: "Projects"), forState: .Normal)
        styleButton(projectsButton)
        
        let interestsButton = BlurButton()
        interestsButton.setBackgroundImage(UIImage(named: "Interests"), forState: .Normal)
        interestsButton.setTitle(NSLocalizedString("Interests", comment: "Interests"), forState: .Normal)
        styleButton(interestsButton)
        
        return [aboutButton, projectsButton, interestsButton]
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
            textLabel.centerY == avatarButton.centerY
            textLabel.leading == view.centerX+offset
            textLabel.width == view.width*0.3
        }

        let buttonSize = CGSize(width: 200.0, height: 130.0)
        
        var previousButton: BlurButton?
        let middleIndex = Double(self.topicButtons.count)/2.0
        for (i, button) in enumerate(self.topicButtons) {
            self.view.addSubview(button)
            
            if let previousButton = previousButton {
                // Swift bug
                constrain(self.view, previousButton, button) { view, previousButton, button in
                    button.leading == previousButton.right+100; return
                }
            }
            
            constrain(self.view, button) { view, button in
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
                button.width == buttonSize.width
                button.height == buttonSize.height
            }
            
            previousButton = button
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let presentTopicViewController: () -> () = {
            let paragraph = Topic.Paragraph(title: NSLocalizedString("About Me", comment: "About Me"), text: "Yolo", images: nil)
            let image = UIImage(named: "About")!
            let topic = Topic(headerImage: image, title: NSLocalizedString("About Me", comment: "About Me"), paragraphs: [paragraph])
            
            let controller = TopicViewController(topic: topic)
//            controller.transitioningDelegate = self
//            controller.modalPresentationStyle = .Custom
            self.navigationController?.presentViewController(controller, animated: true, completion: nil)
        }
        
        // Swift bug
        self.topicButtons[0].rac_signalForControlEvents(.TouchUpInside).subscribeNext() { _ in
            presentTopicViewController(); return
        }
    }
    
    // MARK: - UIViewControllerTransitioningDelegate
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TopicTransitionAnimator(presenting: true, topicButton: self.topicButtons[0])
    }
    
    // MARK: -

}

