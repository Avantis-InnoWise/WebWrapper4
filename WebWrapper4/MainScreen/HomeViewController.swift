import Cocoa
import WebKit

    //MARK: - Constants

private enum Dimensions {
    static let deadLine: CGFloat = 0.5
    static let generalButton: CGFloat = 120
    static let backButtonWidth: CGFloat = 80
    static let secondaryButtonWidth: CGFloat = 80
    static let backForwardInsets: NSEdgeInsets = NSEdgeInsets(top: 20, left: 30,  bottom: -20, right: -30)
    static let pinkColor: NSColor = .systemPurple
    static let cornerRadius: CGFloat = 10
}

class HomeViewController: NSViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var boxView: NSBox!
    @IBOutlet weak var webView: WKWebView!
    
    //MARK: - PublicProperties

    private var viewModel: HomeViewModelProtocol
    
    //MARK: - PrivateProperties
    
    private let backButton : NSButton = {
        let backButton = NSButton()
        backButton.settingsButton(Dimensions.pinkColor, title: .localized.backButton, radius: Dimensions.cornerRadius)
        backButton.setAccessibilityIdentifier(ScreenButton.back.rawValue)
        backButton.action = #selector(backClicked)
        return backButton
    }()
    
    private let secondaryButton: NSButton = {
        let secondaryButton = NSButton()
        secondaryButton.settingsButton(Dimensions.pinkColor, title: .localized.secondaryButton, radius: Dimensions.cornerRadius)
        secondaryButton.setAccessibilityIdentifier(ScreenButton.secondary.rawValue)
        secondaryButton.action = #selector(secondaryClicked)
        return secondaryButton
    }()
    
    private let generalButton: NSButton = {
        let generalButton = NSButton()
        generalButton.settingsButton(Dimensions.pinkColor, title: .localized.generalButton, radius: Dimensions.cornerRadius)
        generalButton.setAccessibilityIdentifier(ScreenButton.general.rawValue)
        generalButton.action = #selector(generalCliked)
        return generalButton
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        webView.uiDelegate = self
        addSubViews()
        setupView()
        webViewDelay()
    }
    
    init(with viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - ButtonSelectors
    
    @IBAction private func backClicked(sender: NSButton) {
        guard let button = boxView.subviews.last?.subviews.first(where: {
            $0.accessibilityIdentifier() == ScreenButton.back.rawValue
        }),
              let backButton = button as? NSButton else { return }
        if backButton.isEnabled == true {
            webView.goBack()
        }
    }
    
    @IBAction private func secondaryClicked(sender: NSButton) {
        guard let button = boxView.subviews.last?.subviews.first(where: {
            $0.accessibilityIdentifier() == ScreenButton.secondary.rawValue
        }),
              let forwardButton = button as? NSButton else { return }
        if forwardButton.isEnabled == true {
            webView.goForward()
        }
    }
    
    @IBAction private func generalCliked(sender: NSButton) {
        viewModel.downloadingWeb { request in
            webView.load(request)
        }
    }
}

//MARK: - PrivateExtension

private extension HomeViewController {
    
    func webViewDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + Dimensions.deadLine) { [weak self] in
            self?.viewModel.downloadingWeb(with: { request in
                self?.webView.load(request)
            })
        }
    }
    
    func addSubViews() {
        boxView.addSubview(backButton)
        boxView.addSubview(generalButton)
        boxView.addSubview(secondaryButton)
    }
    
    func setupView() {
        boxView.cornerRadius = .zero
        boxView.fillColor = .windowBackgroundColor
        constrainsButtons()
        
        guard !webView.backForwardList.backList.isEmpty
        else {
            backButton.isEnabled = false
            return
        }
        guard !webView.backForwardList.forwardList.isEmpty
        else {
            secondaryButton.isEnabled = false
            return
        }
    }
    
    //MARK: - SetupConstrains
    
    func constrainsButtons() {
        backButton.translatesAutoresizingMaskIntoConstraints = false
        secondaryButton.translatesAutoresizingMaskIntoConstraints = false
        generalButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                backButton.widthAnchor.constraint(equalToConstant: Dimensions.backButtonWidth),
                backButton.topAnchor.constraint(equalTo: boxView.topAnchor,
                                                constant: Dimensions.backForwardInsets.top),
                backButton.leadingAnchor.constraint(equalTo: boxView.leadingAnchor,
                                                    constant: Dimensions.backForwardInsets.left),
                backButton.bottomAnchor.constraint(equalTo: boxView.bottomAnchor,
                                                   constant: Dimensions.backForwardInsets.bottom),
                
                generalButton.widthAnchor.constraint(equalToConstant: Dimensions.generalButton),
                generalButton.centerXAnchor.constraint(equalTo: boxView.centerXAnchor),
                generalButton.topAnchor.constraint(equalTo: boxView.topAnchor,
                                                constant: Dimensions.backForwardInsets.top),
                generalButton.bottomAnchor.constraint(equalTo: boxView.bottomAnchor,
                                                   constant: Dimensions.backForwardInsets.bottom),
                
                secondaryButton.widthAnchor.constraint(equalToConstant: Dimensions.secondaryButtonWidth),
                secondaryButton.topAnchor.constraint(equalTo: boxView.topAnchor,
                                                   constant: Dimensions.backForwardInsets.top),
                secondaryButton.trailingAnchor.constraint(equalTo: boxView.trailingAnchor,
                                                        constant: Dimensions.backForwardInsets.right),
                secondaryButton.bottomAnchor.constraint(equalTo: boxView.bottomAnchor,
                                                      constant: Dimensions.backForwardInsets.bottom)
            ]
        )
    }
}

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
