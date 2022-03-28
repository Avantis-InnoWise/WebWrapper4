import Cocoa

public struct Localization {
    
    var appTitle: String {
        NSLocalizedString(
            "app.title",
            tableName: nil,
            bundle: .main,
            value: "App Title",
            comment: "App Title"
        )
    }
    
    var backButton: String {
        NSLocalizedString(
            "back.button",
            tableName: nil,
            bundle: .main,
            value: "Back",
            comment: "Back Button Title"
        )
    }
    
    var generalButton: String {
        NSLocalizedString(
            "home.button",
            tableName: nil,
            bundle: .main,
            value: "Homepage",
            comment: "Home Button Title"
        )
    }
    
    var secondaryButton: String {
        NSLocalizedString(
            "forward.button",
            tableName: nil,
            bundle: .main,
            value: "Forward",
            comment: "Forward Button Title"
        )
    }
}

//MARK: - Extensions

public extension String {
    static var localized = Localization()
}
