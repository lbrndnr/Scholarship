//
//  BarGraph.swift
//  Scholarship
//
//  Created by Laurin Brandner on 10/02/15.
//  Copyright (c) 2015 Laurin Brandner. All rights reserved.
//

import UIKit
import Cartography

class BarGraph: UIView {

    var entries: [(String, Float)]  = [(String, Float)]() {
        didSet {
            self.reloadBars()
        }
    }
    
    var labelColor: UIColor = UIColor.blackColor() {
        didSet {
            self.reloadColors()
        }
    }
    
    var labelFont: UIFont = UIFont.systemFontOfSize(UIFont.labelFontSize()) {
        didSet {
            self.reloadColors()
        }
    }
    
    var barColor: UIColor = UIColor.blackColor() {
        didSet {
            self.reloadColors()
        }
    }
    
    private var entryViews = [(UILabel, UIView)]()
    
    // MARK: - Initialization
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // MARK: - Bars
    
    private func reloadBars() {
        for (label, bar) in self.entryViews {
            label.removeFromSuperview()
            bar.removeFromSuperview()
        }
        
        self.entryViews.removeAll(keepCapacity: false)
        
        var upperBar: UIView?
        
        for (title, progress) in self.entries {
            let label = UILabel()
            label.text = title
            self.addSubview(label)
            
            let bar = UIView()
            self.addSubview(bar)
            
            let barHeight = 24.0
            
            // Swift bug
            if let upperBar = upperBar {
                constrain(upperBar, bar) { upperBar, bar in
                    bar.top == upperBar.bottom+(barHeight/2.0); return
                }
            }
            else {
                constrain(self, bar) { view, bar in
                    bar.top == view.top; return
                }
            }
            
            constrain(self, label, bar, { view, label, bar in
                bar.height == barHeight
                bar.width == (view.width/2.0)*progress
                bar.leading == view.left+100
                
                label.centerY == bar.centerY
                label.trailing == bar.left-barHeight
            })
            
            let views = (label, bar)
            self.entryViews.append(views)
            upperBar = bar
        }
        
        self.reloadColors()
    }
    
    private func reloadColors() {
        for (label, bar) in self.entryViews {
            label.textColor = self.labelColor
            label.font = self.labelFont
            bar.backgroundColor = self.barColor
        }
    }
    
    // MARK: -
    
}
