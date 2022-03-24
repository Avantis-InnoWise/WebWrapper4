import Cocoa

extension NSButton {
    func settingsButton(with color: NSColor, radius: CGFloat) {
        bezelStyle = .texturedSquare
        wantsLayer = true
        isBordered = false
        layer?.backgroundColor = color.cgColor
        layer?.masksToBounds = true
        layer?.cornerRadius = radius
    }
}
