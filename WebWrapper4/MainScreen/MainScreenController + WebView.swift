//
//  MainScreenController + WebView.swift
//  WebWrapper4
//
//  Created by Yahor Yauseyenka on 16.02.22.
//

import Cocoa
import WebKit

//MARK: - WKNavigationDelegate

extension MainScreenController: WKNavigationDelegate {
    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationAction: WKNavigationAction,
        decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
    ) {
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        guard
            let backButtonView = self.boxView.subviews.last?.subviews.first(where: {
                $0.accessibilityIdentifier() == WebButton.back.rawValue }),
            let forwardButtonView = self.boxView.subviews.last?.subviews.first(where: {
                $0.accessibilityIdentifier() == WebButton.forward.rawValue }),
            let backButton = backButtonView as? NSButton,
            let forwardButton = forwardButtonView as? NSButton
        else { return }
        
        backButton.isEnabled = !webView.backForwardList.backList.isEmpty
        forwardButton.isEnabled = !webView.backForwardList.forwardList.isEmpty
    }
}

//MARK: - WKUIDelegate

extension MainScreenController: WKUIDelegate {
    func webView(
        _ webView: WKWebView,
        createWebViewWith configuration: WKWebViewConfiguration,
        for navigationAction: WKNavigationAction,
        windowFeatures: WKWindowFeatures
    ) -> WKWebView? {
        if navigationAction.targetFrame == nil || navigationAction.targetFrame?.isMainFrame == false {
            if let url = navigationAction.request.url {
                self.webView.load(URLRequest(url: url))
            }
        }
        return nil
    }
}
