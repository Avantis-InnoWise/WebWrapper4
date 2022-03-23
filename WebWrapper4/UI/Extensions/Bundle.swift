import Cocoa

extension Bundle {
    var displayTitle: String? {
        return object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
    }
}
