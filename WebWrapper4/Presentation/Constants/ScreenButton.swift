import Foundation

enum ScreenButton {
    case back, general, secondary
    
    var rawValue: String {
        switch self {
        case .back:
            return "back_button"
        case .general:
            return "general_button"
        case .secondary:
            return "secondary_button"
        }
    }
}
