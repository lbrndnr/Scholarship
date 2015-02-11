//
//  Extension.swift
//  Scholarship
//
//  Created by Laurin Brandner on 11/02/15.
//  Copyright (c) 2015 Laurin Brandner. All rights reserved.
//

import Foundation

// MARK: - NSAttributedString

infix operator + { associativity left precedence 160 }

func + (left: NSAttributedString, right: NSAttributedString) -> NSAttributedString {
    let string = NSMutableAttributedString(attributedString: left)
    string.appendAttributedString(right)
    
    return string
}

// MARK: -
