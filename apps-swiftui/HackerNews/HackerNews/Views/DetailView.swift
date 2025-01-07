//
//  DetailView.swift
//  HackerNews
//
//  Created by Mainul Dip on 8/18/23.
//

import SwiftUI
import WebKit

struct DetailView: View {
    let url: String?
    var body: some View {
        if let url_S = url {
            WebView(urlStirg: url)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(url: "https://www.websolverpro.com")
    }
}

struct WebView: UIViewRepresentable {
    
//    typealias UIViewType = WKWebView
    let urlStirg: String?
    
    func makeUIView(context: Context) -> WKWebView {
        WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url_s = urlStirg {
            if let url = URL(string: url_s) {
                let request = URLRequest(url: url)
                uiView.load(request)
            }
        }
    }
}
