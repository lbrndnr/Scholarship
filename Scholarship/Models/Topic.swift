//
//  Topic.swift
//  Scholarship
//
//  Created by Laurin Brandner on 12/02/15.
//  Copyright (c) 2015 Laurin Brandner. All rights reserved.
//

import UIKit

struct Topic {
    
    let headerImage: UIImage
    let title: String
    let paragraphs: [Paragraph]
    
    init(headerImageName: String, title: String, paragraphs: [Paragraph]) {
        let headerImage = UIImage(named: headerImageName)
        precondition(headerImage != nil, "Couldn't load header image")
        
        self.headerImage = headerImage!
        self.title = title
        self.paragraphs = paragraphs
    }
    
    static func aboutTopic() -> Topic {
        let aboutMeParagraph = Paragraph(title: NSLocalizedString("About Me", comment: "About Me"),
                                          text: NSLocalizedString("My name is Laurin Brandner. When my dad bought our first iMac, I was 14 at that time, I became interested in developing Mac apps. With 15 I developed my first Mac and iOS application. Since then there’s scarcely a day I don’t code anymore. By reading blogs and books I have learnt a handful of programming languages including: Objective-C, C, Python, Ruby and Swift. During my last year of high school I was also working part time at Ubique, a software agency based in Zurich.", comment: "About Me Text"))
        let educationParagraph = Paragraph(title: NSLocalizedString("Education", comment: "Education"),
                                            text: NSLocalizedString("I graduated from the Alte Kantonsschule Aarau in 2014 and will begin my studies at the Swiss Federal Institute of Technology (ETH) in Zurich this year. I’m planning on pursuing a Master degree in Computer Science.", comment: "Education Text"))
        let futureParagraph = Paragraph(title: NSLocalizedString("Future", comment: "Future"),
                                         text: NSLocalizedString("I don’t really know what company I want to work for in the future. In fact, I don’t even know what exactly I want to work on. I could be developing apps for mobile devices just as much as I could be working in a lab at a university. What I do know is that I want to work abroad for a certain period of time after university.", comment: "Future Text"))
        
        return Topic(headerImageName: "About", title: NSLocalizedString("About Me", comment: "About Me"), paragraphs: [aboutMeParagraph, educationParagraph, futureParagraph])
    }
    
    static func projectsTopic() -> Topic {
        let crimsonParagraph: Paragraph = {
            var paragraph = Paragraph(title: "Crimson",
                                       text: NSLocalizedString("Crimson is an iOS keyboard extension I developed in 2014. It shows suggestions above the keys the user is likey to tap next. Swiping up on a key inserts the suggestion. It learns new words as the user types and adapts to the general writing style too. The native design is refined and improved with delightful animations and a clearer shift key. Additionally, the spacebar splits to make it easy to insert a comma or period.", comment: "Crimson Text"))
            paragraph.source = .AppStore("918925779")
            paragraph.mainImage = UIImage(named: "Crimson-Icon")
            
            paragraph.images = [(UIImage(named: "Crimson-Video-Thumbnail")!, NSBundle.mainBundle().URLForResource("Crimson-Video", withExtension: "mp4")),
                          (UIImage(named: "Crimson-Banner-1")!, nil),
                          (UIImage(named: "Crimson-Banner-2")!, nil),]
            
            return paragraph
        }()
        
        let whistlesParagraph: Paragraph = {
            var paragraph = Paragraph(title: "Whistles",
                                       text: NSLocalizedString("Whistles is an iPhone app that identifies birds by their whistling. I developed an audio fingerprinting algorithm that consists of multiple algorithms including the Fast Fourier Transform and the Haar-Wavelet Transform. To store the fingerprints of the birds and match them I have also developed a Ruby on Rails server. I won the \"Best Computer Science Graduation Project of the Year 2014\" award with it.", comment: "Crimson Text"))
            if let URL = NSURL(string: "https://github.com/larcus94/LBAudioDetective") {
                paragraph.source = .GitHub(URL)
            }
            paragraph.mainImage = UIImage(named: "Whistles-Icon")
            
            paragraph.images = [(UIImage(named: "Whistles-Video-Thumbnail")!, NSBundle.mainBundle().URLForResource("Whistles-Video", withExtension: "mp4")),
                        (UIImage(named: "Whistles-ETH")!, nil)]
            
            return paragraph
        }()
        
        return Topic(headerImageName: "Projects", title: NSLocalizedString("Projects", comment: "Projects"), paragraphs: [crimsonParagraph, whistlesParagraph])
    }
    
    static func interestsTopic() -> Topic {
        let crimsonParagraph: Paragraph = {
            var paragraph = Paragraph(title: "Crimson",
                text: NSLocalizedString("As you type, Crimson gives suggestions on the next word it thinks you’ll pick directly above the letter. The same autocorrect style can be found on BlackBerry 10’s virtual keyboard; it’s an awesome way to present a number of options on screen, without taking up more space above the keyboard.", comment: "Crimson Text"))
            paragraph.source = .AppStore("918925779")
            paragraph.mainImage = UIImage(named: "Crimson-Icon")
            
            return paragraph
        }()
        
        return Topic(headerImageName: "Interests", title: NSLocalizedString("Interests", comment: "Interests"), paragraphs: [crimsonParagraph])
    }
}
