//
//  SearchDetailViewController.swift
//  MoneyTap
//
//  Created by Garry Patel on 07/09/18.
//  Copyright © 2018 com.ways. All rights reserved.
//

import UIKit
import MBProgressHUD

class SearchDetailViewController: UIViewController{

    @IBOutlet weak var webView : UIWebView!
    var titleStr : String?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = self.titleStr ?? ""
        let url = URL(string: "https://en.wikipedia.org/wiki/\(titleStr?.replacingOccurrences(of:" ", with: "_") ?? "")")
        self.webView.loadRequest(URLRequest(url: url!))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension SearchDetailViewController : UIWebViewDelegate {
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        print("(\(#function)")
        MBProgressHUD.showAdded(to: self.view, animated: true)
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        print("(\(#function)")
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
}
