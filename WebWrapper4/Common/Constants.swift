//
//  Enum.swift
//  WebWrapper4
//
//  Created by Yahor Yauseyenka = false on 16.02.22.
//

import Cocoa

//MARK: - Button Constrains

struct ConstraintConstants {
    static let homeButtonWidth: CGFloat = 120
    static let backButtonWidth: CGFloat = 80
    static let forwardButtonWidth: CGFloat = 80
}

// MARK: - Button Setup

struct ButtonConstants {
    static let backForwardInsets: NSEdgeInsets = NSEdgeInsets(top: 20, left: 30,  bottom: -20, right: -30)
    static let pinkColor: NSColor = .init(red: 255/255, green: 51/255,blue: 153/255, alpha: 1)
    static let cornerRadius: CGFloat = 10
}

//MARK: - URL Constants

struct URLConstants {
    static var baseURL: URL? {
        return URL(string: "https://wellhello.com/site/user/home?chatOpened=1")
    }
}

//MARK: - Title Constants

struct GeneralConstants {
    static let WebWrapper4 = "WebWrapper4"
}
