import Cocoa

extension Bundle {
    var bundleDisplayName: String? {
        object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
    }
}
