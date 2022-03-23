import Foundation

enum ScreenButton {
    case back, home, forward
    
    var rawValue: String {
        switch self {
        case .back:
            return "back_button"
        case .home:
            return "home_button"
        case .forward:
            return "forward_button"
        }
    }
}
