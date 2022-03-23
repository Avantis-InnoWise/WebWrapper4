import Cocoa
import WebKit

    //MARK: - Constants

private enum Constant {
    static let deadLine: CGFloat = 0.5
    static let backButtonBackgroundColor = NSColor.brown.cgColor
    static let forwardButtonBackgroundColor = NSColor.brown.cgColor
    static let homeButtonBackgroundColor = NSColor.brown.cgColor
}

class HomeViewController: NSViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var boxView: NSBox!
    @IBOutlet weak var webView: WKWebView!
    
    //MARK: - PrivateProperties
    
    private let backButton : NSButton = {
        let backButton = NSButton()
        backButton.settingsButton(with: ButtonConstants.pinkColor, radius: ButtonConstants.cornerRadius)
        backButton.setAccessibilityIdentifier(ScreenButton.back.rawValue)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.layer?.backgroundColor = Constant.backButtonBackgroundColor
        backButton.action = #selector(backClicked)
        backButton.title = .localized.backButton
        return backButton
    }()
    
    private let forwardButton: NSButton = {
        let forwardButton = NSButton()
        forwardButton.settingsButton(with: ButtonConstants.pinkColor, radius: ButtonConstants.cornerRadius)
        forwardButton.setAccessibilityIdentifier(ScreenButton.forward.rawValue)
        forwardButton.translatesAutoresizingMaskIntoConstraints = false
        forwardButton.layer?.backgroundColor = Constant.forwardButtonBackgroundColor
        forwardButton.action = #selector(forwardClicked)
        forwardButton.title = .localized.forwardButton
        return forwardButton
    }()
    
    private let homeButton: NSButton = {
        let homeButton = NSButton()
        homeButton.settingsButton(with: ButtonConstants.pinkColor, radius: ButtonConstants.cornerRadius)
        homeButton.setAccessibilityIdentifier(ScreenButton.home.rawValue)
        homeButton.translatesAutoresizingMaskIntoConstraints = false
        homeButton.layer?.backgroundColor = Constant.homeButtonBackgroundColor
        homeButton.action = #selector(homeClicked)
        homeButton.title = .localized.homeButton
        return homeButton
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        webView.uiDelegate = self
        
        setupView()
        webViewDelay()
    }
    
    //MARK: - PrivateFunctions
    
    private func webViewDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + Constant.deadLine) { [weak self] in
            if let url = URLConstants.baseURL {
                self?.webView.load(URLRequest(url: url))
            }
        }
    }
    
    private func setupView() {
        boxView.fillColor = .windowBackgroundColor
        boxView.cornerRadius = .zero
        
        self.constrainsButtons()
        
        if webView.backForwardList.backList.isEmpty {
            backButton.isEnabled = false
        }
        if webView.backForwardList.forwardList.isEmpty {
            forwardButton.isEnabled = false
        }
    }
    
    //MARK: - SetupConstrains
    
    private func constrainsButtons() {
        boxView.addSubview(backButton)
        boxView.addSubview(homeButton)
        boxView.addSubview(forwardButton)
        
        NSLayoutConstraint.activate(
            [
                backButton.widthAnchor.constraint(equalToConstant: ConstraintConstants.backButtonWidth),
                backButton.topAnchor.constraint(equalTo: boxView.topAnchor,
                                                constant: ButtonConstants.backForwardInsets.top),
                backButton.leadingAnchor.constraint(equalTo: boxView.leadingAnchor,
                                                    constant: ButtonConstants.backForwardInsets.left),
                backButton.bottomAnchor.constraint(equalTo: boxView.bottomAnchor,
                                                   constant: ButtonConstants.backForwardInsets.bottom),
                
                homeButton.widthAnchor.constraint(equalToConstant: ConstraintConstants.homeButtonWidth),
                homeButton.centerXAnchor.constraint(equalTo: boxView.centerXAnchor),
                homeButton.topAnchor.constraint(equalTo: boxView.topAnchor,
                                                constant: ButtonConstants.backForwardInsets.top),
                homeButton.bottomAnchor.constraint(equalTo: boxView.bottomAnchor,
                                                   constant: ButtonConstants.backForwardInsets.bottom),
                
                forwardButton.widthAnchor.constraint(equalToConstant: ConstraintConstants.forwardButtonWidth),
                forwardButton.topAnchor.constraint(equalTo: boxView.topAnchor,
                                                   constant: ButtonConstants.backForwardInsets.top),
                forwardButton.trailingAnchor.constraint(equalTo: boxView.trailingAnchor,
                                                        constant: ButtonConstants.backForwardInsets.right),
                forwardButton.bottomAnchor.constraint(equalTo: boxView.bottomAnchor,
                                                      constant: ButtonConstants.backForwardInsets.bottom)
            ]
        )
    }
    
    //MARK: - ButtonSelectors
    
    @objc private func backClicked() {
        guard let button = boxView.subviews.last?.subviews.first(where: {
            $0.accessibilityIdentifier() == ScreenButton.back.rawValue
        }),
              let backButton = button as? NSButton else { return }
        if backButton.isEnabled == true {
            webView.goBack()
        }
    }
    
    @objc private func forwardClicked() {
        guard let button = boxView.subviews.last?.subviews.first(where: {
            $0.accessibilityIdentifier() == ScreenButton.forward.rawValue
        }),
              let forwardButton = button as? NSButton else { return }
        if forwardButton.isEnabled == true {
            webView.goForward()
        }
    }
    
    @objc private func homeClicked() {
        guard let url = URLConstants.baseURL else { return }
        webView.load(URLRequest(url: url))
    }
}
