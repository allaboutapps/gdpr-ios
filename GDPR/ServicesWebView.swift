//
//  ServicesWebController.swift
//  GDPR
//
//  Created by Lyn Almasri on 19.08.20.
//  Copyright © 2020 All About Apps. All rights reserved.
//

import WebKit
import SwiftUI

struct ServiceWebView: UIViewRepresentable {
    typealias UIViewType = WKWebView
    
    var url: URL?
    
    init(url: URL?) {
        self.url = url
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        if let url = url {
            webView.load(URLRequest(url: url))
            webView.allowsBackForwardNavigationGestures = true
        }
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        if let url = url {
            webView.load(URLRequest(url: url))
            webView.allowsBackForwardNavigationGestures = true
        }
        
    }
}

struct ServiceWebView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceWebView(url: URL(string: "https://www.google.com")!)
    }
}
