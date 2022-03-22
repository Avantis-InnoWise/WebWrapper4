//
//  AppDelegate.swift
//  WebWrapper4
//
//  Created by Yahor Yauseyenka on 16.02.22.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet var window: NSWindow!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        self.window = NSWindow(contentRect: NSScreen.main?.frame ?? NSRect(),
                               styleMask: [.miniaturizable, .closable, .resizable, .titled],
                               backing: .buffered,
                               defer: false)
        self.window?.title = Bundle.main.displayTitle ?? GeneralConstants.WebWrapper4
        self.window?.contentViewController = MainController()
        self.window?.makeKeyAndOrderFront(nil)
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
}
