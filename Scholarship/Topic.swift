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
        let image: UIImage?
        
    }
    
    let headerImage: UIImage
    let title: String
    let paragraphs: [Paragraph]
    
}
