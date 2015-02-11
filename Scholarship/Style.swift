//
//  Style.swift
//  Scholarship
//
//  Created by Laurin Brandner on 10/02/15.
//  Copyright (c) 2015 Laurin Brandner. All rights reserved.
//

import UIKit

extension UIFont {
    
    class func lightHelveticaNeueWithSize(fontSize: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Light", size: fontSize)!
    }
    
}

extension UIColor {
    
    class func brandnerColor() -> UIColor {
        return UIColor(red: 58.0/255.0, green: 161.0/255.0, blue: 83.0/255.0, alpha: 1.0)
    }
    
    class func darkBrandnerColor() -> UIColor {
        return UIColor(red: 55.0/255.0, green: 84.0/255.0, blue: 62.0/255.0, alpha: 1.0)
    }
    
}