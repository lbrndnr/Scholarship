//
//  WebViewController.swift
//  Scholarship
//
//  Created by Laurin Brandner on 20/02/15.
//  Copyright (c) 2015 Laurin Brandner. All rights reserved.
//

import UIKit
import Cartography

class WebViewController: UIViewController {
    
    lazy var webView: UIWebView = {
        let webView = UIWebView()
        webView.scalesPageToFit = true
        
        return webView
    }()
    
    // MARK: - View Lifecycle
    
    override func loadView() {
        super.loadView()
        
        self.view.addSubview(self.webView)
        constrain(self.view, self.webView) { view, webView in
            webView.edges == view.edges
        }
    }
    
}
