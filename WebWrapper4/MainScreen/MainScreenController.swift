//
//  MainScreenController.swift
//  WebWrapper4
//
//  Created by Yahor Yauseyenka on 16.02.21.
//

import Cocoa
import WebKit

    //MARK: - PrivateEnum

private enum Constants {
    static let deadLine: CGFloat = 0.5
}

class MainScreenController: NSViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var boxView: NSBox!
    @IBOutlet weak var webView: WKWebView!
    
    //MARK: - PrivateProperties
    
    private let backButton : NSButton = {
        let backButton = NSButton()
        backButton.createAdultButton(with: ButtonConstants.pinkColor, radius: ButtonConstants.cornerRadius)
        backButton.setAccessibilityIdentifier(WebButton.back.rawValue)
        backButton.title = .localized.backButton
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.action = #selector(backButtonClicked)
        backButton.layer?.backgroundColor = NSColor.brown.cgColor
        return backButton
    }()
    
    private let forwardButton: NSButton = {
        let forwardButton = NSButton()
        forwardButton.createAdultButton(with: ButtonConstants.pinkColor, radius: ButtonConstants.cornerRadius)
        forwardButton.setAccessibilityIdentifier(WebButton.forward.rawValue)
        forwardButton.title = .localized.forwardButton
        forwardButton.translatesAutoresizingMaskIntoConstraints = false
        forwardButton.action = #selector(forwardButtonClicked)
        forwardButton.layer?.backgroundColor = NSColor.brown.cgColor
        return forwardButton
    }()
    
    private let homeButton: NSButton = {
        let homeButton = NSButton()
        homeButton.createAdultButton(with: ButtonConstants.pinkColor, radius: ButtonConstants.cornerRadius)
        homeButton.setAccessibilityIdentifier(WebButton.home.rawValue)
        homeButton.title = .localized.homeButton
        homeButton.translatesAutoresizingMaskIntoConstraints = false
        homeButton.action = #selector(homeButtonClicked)
        homeButton.layer?.backgroundColor = NSColor.brown.cgColor
        return homeButton
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        webView.uiDelegate = self
        
        setupView()
        setupWebView()
    }
    
    //MARK: - PublicFunctions
    
    private func setupWebView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.deadLine) {
            if let url = URLConstants.baseURL {
                self.webView.load(URLRequest(url: url))
            }
        }
    }
    
    private func setupView() {
        boxView.fillColor = .windowBackgroundColor
        boxView.cornerRadius = .zero
        
        self.configureConstrainsForButtons()
        
        if webView.backForwardList.backList.isEmpty {
            backButton.isEnabled = false
        }
        if webView.backForwardList.forwardList.isEmpty {
            forwardButton.isEnabled = false
        }
    }
    
    //MARK: - SetupConstrains
    
    private func configureConstrainsForButtons() {
        self.boxView.addSubview(backButton)
        self.boxView.addSubview(homeButton)
        self.boxView.addSubview(forwardButton)
        
        NSLayoutConstraint.activate(
            [
                self.backButton.widthAnchor.constraint(equalToConstant: ConstraintConstants.backButtonWidth),
                self.backButton.topAnchor.constraint(equalTo: self.boxView.topAnchor, constant: ButtonConstants.backForwardInsets.top),
                self.backButton.leadingAnchor.constraint(equalTo: self.boxView.leadingAnchor, constant: ButtonConstants.backForwardInsets.left),
                self.backButton.bottomAnchor.constraint(equalTo: self.boxView.bottomAnchor, constant: ButtonConstants.backForwardInsets.bottom),
                
                self.homeButton.widthAnchor.constraint(equalToConstant: ConstraintConstants.homeButtonWidth),
                self.homeButton.centerXAnchor.constraint(equalTo: self.boxView.centerXAnchor),
                self.homeButton.topAnchor.constraint(equalTo: self.boxView.topAnchor, constant: ButtonConstants.backForwardInsets.top),
                self.homeButton.bottomAnchor.constraint(equalTo: self.boxView.bottomAnchor, constant: ButtonConstants.backForwardInsets.bottom),
                
                self.forwardButton.widthAnchor.constraint(equalToConstant: ConstraintConstants.forwardButtonWidth),
                self.forwardButton.topAnchor.constraint(equalTo: self.boxView.topAnchor, constant: ButtonConstants.backForwardInsets.top),
                self.forwardButton.trailingAnchor.constraint(equalTo: self.boxView.trailingAnchor, constant: ButtonConstants.backForwardInsets.right),
                self.forwardButton.bottomAnchor.constraint(equalTo: self.boxView.bottomAnchor, constant: ButtonConstants.backForwardInsets.bottom)
            ]
        )
    }
    
    //MARK: - ButtonSelectors
    
    @objc private func backButtonClicked() {
        guard let button = self.boxView.subviews.last?.subviews.first(where: { $0.accessibilityIdentifier() == WebButton.back.rawValue }),
              let backButton = button as? NSButton else { return }
        if backButton.isEnabled == true {
            webView.goBack()
        }
    }
    
    @objc private func forwardButtonClicked() {
        guard let button = self.boxView.subviews.last?.subviews.first(where: { $0.accessibilityIdentifier() == WebButton.forward.rawValue }),
              let forwardButton = button as? NSButton else { return }
        if forwardButton.isEnabled == true {
            webView.goForward()
        }
    }
    
    @objc private func homeButtonClicked() {
        guard let url = URLConstants.baseURL else { return }
        self.webView.load(URLRequest(url: url))
    }
}
