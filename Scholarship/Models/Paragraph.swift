//
//  Paragraph.swift
//  Scholarship
//
//  Created by Laurin Brandner on 25/02/15.
//  Copyright (c) 2015 Laurin Brandner. All rights reserved.
//

import Foundation

enum Source {
    case AppStore(String)
    case GitHub(NSURL)
}

struct Paragraph {
    
    var title: String
    var text: String
    var mainImage: UIImage?
    var images: [(UIImage, NSURL?)]?
    var source: Source?
    
    init(title: String, text: String) {
        self.title = title
        self.text = text
    }
    
}