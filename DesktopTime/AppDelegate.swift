//
//  AppDelegate.swift
//  DesktopTime
//
//  Created by Marcel Dierkes on 09.08.15.
//  Copyright © 2015 Marcel Dierkes. All rights reserved.
//

import Cocoa

@NSApplicationMain
final class AppDelegate: NSObject, NSApplicationDelegate {
    @IBOutlet weak var window: NSWindow!
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
    
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        // Quit the app on a reopen request
        NSApplication.shared.terminate(self)
        return false
    }
}

