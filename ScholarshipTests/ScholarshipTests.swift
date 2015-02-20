//
//  ScholarshipTests.swift
//  ScholarshipTests
//
//  Created by Laurin Brandner on 06/02/15.
//  Copyright (c) 2015 Laurin Brandner. All rights reserved.
//

import UIKit
import XCTest

class ScholarshipTests: XCTestCase {
    
    func testParsing() {
        let path = NSBundle(forClass: self.dynamicType).pathForResource("Topics", ofType: "json")
        XCTAssertFalse(path == nil, "Couldn't retrieve topics file")
        
        let parser = TopicParser(path: path!)
        let topics = parser.parse()
        XCTAssertFalse(topics == nil, "Failed to parse topics")
        XCTAssertTrue(topics!.count > 0, "Failed to parse topics")
    }
    
}
