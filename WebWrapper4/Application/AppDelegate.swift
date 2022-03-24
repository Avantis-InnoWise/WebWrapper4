import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet var window: NSWindow!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        window = NSWindow(contentRect: NSScreen.main?.frame ?? NSRect(),
                          styleMask: [.miniaturizable, .closable, .resizable, .titled],
                          backing: .buffered,
                          defer: false)
        window?.title = Bundle.main.displayTitle ?? GeneralConstants.WebWrapper4
        window?.contentViewController = HomeViewController()
        window?.makeKeyAndOrderFront(nil)
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
    
    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
}
