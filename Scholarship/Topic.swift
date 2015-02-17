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
        let text: String
        let mainImage: UIImage?
        let images: [UIImage]?
        
        init(title: String, text: String, mainImage: UIImage? = nil, images: [UIImage]? = nil) {
            self.title = title
            self.text = text
            self.mainImage = mainImage
            self.images = images
        }
        
    }
    
    let headerImage: UIImage
    let title: String
    let paragraphs: [Paragraph]
    
}
