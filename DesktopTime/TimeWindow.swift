//
//  TimeWindow.swift
//  DesktopTime
//
//  Created by Marcel Dierkes on 09.08.15.
//  Copyright © 2015 Marcel Dierkes. All rights reserved.
//

import Cocoa

class TimeWindow: NSWindow {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Configure window
        self.level = Int(CGWindowLevelForKey(CGWindowLevelKey.FloatingWindowLevelKey))
        self.ignoresMouseEvents = true
        self.backgroundColor = NSColor.clearColor()
    }
}
