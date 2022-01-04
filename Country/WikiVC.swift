//
//  WikiVC.swift
//  Country
//
//  Created by Евгений Григоренко on 3.01.22.
//

import UIKit
import WebKit

class WikiVC: UIViewController, WKNavigationDelegate {
    
    var webVC = WKWebView()
    var search = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: search)!
        webVC.load(URLRequest(url: url))
        view = webVC
    }
    
}
