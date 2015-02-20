//
//  TopicParser.swift
//  Scholarship
//
//  Created by Laurin Brandner on 20/02/15.
//  Copyright (c) 2015 Laurin Brandner. All rights reserved.
//

import UIKit

struct TopicParser {
    
    let path: String
    
    // MARK: - Initialization
    
    init(path: String) {
        self.path = path
    }
    
    // MARK: - Parsing
    
    func parse() -> [Topic]? {
        let data = NSData(contentsOfFile: self.path)
        if let data = data {
            let payload: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil)
            if let payload = payload as? [[String: AnyObject]] {
                var topics = [Topic]()
                
                for rawTopic in payload {
                    let title = rawTopic["title"] as? String
                    let headerImageName = rawTopic["headerImage"] as? String
                    
                    let rawParagraphs = rawTopic["paragraphs"] as? [[String: String]]
                    let paragraphs: [Topic.Paragraph]? = rawParagraphs?.map { rawParagraph in
                        let title = rawParagraph["title"]
                        let text = rawParagraph["text"]
                        
                        return Topic.Paragraph(title: title!, text: text!, mainImageName: nil, imageNames: nil)
                    }
                    
                    if let paragraphs = paragraphs {
                        if let title = title {
                            if let headerImageName = headerImageName {
                                let topic = Topic(headerImageName: headerImageName, title: title, paragraphs: paragraphs)
                                topics.append(topic)
                            }
                        }
                    }
                }
                
                return topics
            }
        }
        
        return nil
    }
    
    // MARK: -
    
}