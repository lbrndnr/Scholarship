//
//  Extension.swift
//  Scholarship
//
//  Created by Laurin Brandner on 11/02/15.
//  Copyright (c) 2015 Laurin Brandner. All rights reserved.
//

import UIKit

// MARK: - NSAttributedString

infix operator + { associativity left precedence 160 }

func + (left: NSAttributedString, right: NSAttributedString) -> NSAttributedString {
    let string = NSMutableAttributedString(attributedString: left)
    string.appendAttributedString(right)
    
    return string
}

// MARK: - UIEdgeInsets

extension UIEdgeInsets {
    
    var horizontal: CGFloat {
        return self.left+self.right
    }
    
    var vertical: CGFloat {
        return self.top+self.bottom
    }
    
}

// MARK: - CGRect {

extension CGRect {
    
    init(center: CGPoint, size: CGSize) {
        let origin = CGPoint(x: center.x-size.width/2.0, y: center.y-size.height/2.0)
        self.init(origin: origin, size:size)
    }
    
}

// MARK: -
