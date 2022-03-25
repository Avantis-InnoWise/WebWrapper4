import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet var window: NSWindow!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        guard let url = URLConstants.baseURL else { return }
        let homeInput = HomeInput(url: url)
        let assembly = HomeAssembly.assembly(withInput: homeInput)
        
        window = NSWindow(contentRect: NSScreen.main?.frame ?? NSRect(),
                          styleMask: [.miniaturizable,
                                      .closable,
                                      .resizable,
                                      .titled],
                          backing: .buffered,
                          defer: false)
        window?.title = Bundle.main.bundleDisplayName ?? GeneralConstants.WebWrapper4
        window?.contentViewController = assembly.viewController
        window?.makeKeyAndOrderFront(nil)
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
    
    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
}
