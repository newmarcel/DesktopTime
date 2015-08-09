//
//  AppDelegate.swift
//  DesktopTime
//
//  Created by Marcel Dierkes on 09.08.15.
//  Copyright © 2015 Marcel Dierkes. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!


    func applicationDidFinishLaunching(aNotification: NSNotification) {
    }

    func applicationWillTerminate(aNotification: NSNotification) {
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(sender: NSApplication) -> Bool {
        return true
    }
    
    func applicationShouldHandleReopen(sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        // Quit the app on a reopen request
        NSApplication.sharedApplication().terminate(self)
        
        return false
    }
    
}

