import Cocoa
import WebKit

    //MARK: - Constants

private enum Constant {
    static let deadLine: CGFloat = 0.5
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
        backButton.action = #selector(backClicked)
        backButton.title = .localized.backButton
        return backButton
    }()
    
    private let secondaryButton: NSButton = {
        let secondaryButton = NSButton()
        secondaryButton.settingsButton(with: ButtonConstants.pinkColor, radius: ButtonConstants.cornerRadius)
        secondaryButton.setAccessibilityIdentifier(ScreenButton.secondary.rawValue)
        secondaryButton.action = #selector(secondaryClicked)
        secondaryButton.title = .localized.secondaryButton
        return secondaryButton
    }()
    
    private let generalButton: NSButton = {
        let generalButton = NSButton()
        generalButton.settingsButton(with: ButtonConstants.pinkColor, radius: ButtonConstants.cornerRadius)
        generalButton.setAccessibilityIdentifier(ScreenButton.general.rawValue)
        generalButton.action = #selector(generalCliked)
        generalButton.title = .localized.generalButton
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
        guard let url = URLConstants.baseURL else { return }
        webView.load(URLRequest(url: url))
    }
}

//MARK: - PrivateExtension

private extension HomeViewController {
    
    func webViewDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + Constant.deadLine) { [weak self] in
            if let url = URLConstants.baseURL {
                self?.webView.load(URLRequest(url: url))
            }
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
                backButton.widthAnchor.constraint(equalToConstant: ConstraintConstants.backButtonWidth),
                backButton.topAnchor.constraint(equalTo: boxView.topAnchor,
                                                constant: ButtonConstants.backForwardInsets.top),
                backButton.leadingAnchor.constraint(equalTo: boxView.leadingAnchor,
                                                    constant: ButtonConstants.backForwardInsets.left),
                backButton.bottomAnchor.constraint(equalTo: boxView.bottomAnchor,
                                                   constant: ButtonConstants.backForwardInsets.bottom),
                
                generalButton.widthAnchor.constraint(equalToConstant: ConstraintConstants.generalButton),
                generalButton.centerXAnchor.constraint(equalTo: boxView.centerXAnchor),
                generalButton.topAnchor.constraint(equalTo: boxView.topAnchor,
                                                constant: ButtonConstants.backForwardInsets.top),
                generalButton.bottomAnchor.constraint(equalTo: boxView.bottomAnchor,
                                                   constant: ButtonConstants.backForwardInsets.bottom),
                
                secondaryButton.widthAnchor.constraint(equalToConstant: ConstraintConstants.secondaryButtonWidth),
                secondaryButton.topAnchor.constraint(equalTo: boxView.topAnchor,
                                                   constant: ButtonConstants.backForwardInsets.top),
                secondaryButton.trailingAnchor.constraint(equalTo: boxView.trailingAnchor,
                                                        constant: ButtonConstants.backForwardInsets.right),
                secondaryButton.bottomAnchor.constraint(equalTo: boxView.bottomAnchor,
                                                      constant: ButtonConstants.backForwardInsets.bottom)
            ]
        )
    }
}
