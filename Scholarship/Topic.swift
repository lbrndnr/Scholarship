//
//  Topic.swift
//  Scholarship
//
//  Created by Laurin Brandner on 12/02/15.
//  Copyright (c) 2015 Laurin Brandner. All rights reserved.
//

import UIKit

struct Topic {
    
    struct Paragraph {
        
        let title: String
        let text: NSAttributedString
        let mainImage: UIImage?
        let images: [UIImage]?
        
        init(title: String, text: String, mainImageName: String? = nil, imageNames: [String]? = nil) {
            self.title = title
            let data = text.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
            self.text = NSAttributedString(data: data!, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil, error: nil)!
            
            if let mainImageName = mainImageName {
                self.mainImage = UIImage(named: mainImageName)
            }
            
            self.images = imageNames?.map { name in
                let image = UIImage(named: name)
                precondition(image != nil, "Couldn't load paragraph image")
                
                return image!
            }
        }
        
    }
    
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
    
}
