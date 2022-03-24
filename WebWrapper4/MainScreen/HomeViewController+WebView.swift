import Cocoa
import WebKit

//MARK: - WKNavigationDelegate

extension HomeViewController: WKNavigationDelegate {
    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationAction: WKNavigationAction,
        decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
    ) {
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        guard
            let backButtonView = boxView.subviews.last?.subviews.first(where: {
                $0.accessibilityIdentifier() == ScreenButton.back.rawValue }),
            let secondaryButtonView = boxView.subviews.last?.subviews.first(where: {
                $0.accessibilityIdentifier() == ScreenButton.secondary.rawValue }),
            let backButton = backButtonView as? NSButton,
            let secondaryButton = secondaryButtonView as? NSButton
        else { return }
        
        backButton.isEnabled = !webView.backForwardList.backList.isEmpty
        secondaryButton.isEnabled = !webView.backForwardList.forwardList.isEmpty
    }
}

//MARK: - WKUIDelegate

extension HomeViewController: WKUIDelegate {
    func webView(
        _ webView: WKWebView,
        createWebViewWith configuration: WKWebViewConfiguration,
        for navigationAction: WKNavigationAction,
        windowFeatures: WKWindowFeatures
    ) -> WKWebView? {
        if navigationAction.targetFrame?.isMainFrame == false || navigationAction.targetFrame == nil {
            if let url = navigationAction.request.url {
                self.webView.load(URLRequest(url: url))
            }
        }
        return nil
    }
}
