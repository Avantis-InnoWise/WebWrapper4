import Cocoa

extension NSButton {
    func settingsButton(_ color: NSColor, title: String, radius: CGFloat) {
        self.title = title
        wantsLayer = true
        isBordered = false
        bezelStyle = .texturedSquare
        layer?.backgroundColor = color.cgColor
        layer?.cornerRadius = radius
        layer?.masksToBounds = true
    }
}
