import Foundation


enum AvailableScreens {
    case MENU
    case LOADING
    case SETTINGS
    case STYLE
    case ACHIVE
    case GAME
    case LEVELS
    case SHOP
    case BONUS
    case RULES
    case PLEASURE
}

class NavGuard: ObservableObject {
    @Published var currentScreen: AvailableScreens = .LOADING
    static var shared: NavGuard = .init()
}
