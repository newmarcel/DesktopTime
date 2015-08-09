//
//  TimeWindow.swift
//  DesktopTime
//
//  Created by Marcel Dierkes on 09.08.15.
//  Copyright © 2015 Marcel Dierkes. All rights reserved.
//

import Cocoa
import CoreImage

class TimeWindow: NSWindow {
    @IBOutlet weak var timeLabel: NSTextField!
    
    private weak var timer: NSTimer!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Configure window
        self.level = Int(CGWindowLevelForKey(CGWindowLevelKey.FloatingWindowLevelKey))
        self.ignoresMouseEvents = true
        self.backgroundColor = NSColor.clearColor()
        
        // Configure time label
        self.timeLabel.layer?.shadowRadius = 0.6
        
        // Setup timer
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("tick:"), userInfo: nil, repeats: true)
    }
    
    private var dateFormatter: NSDateFormatter = {
        let df = NSDateFormatter()
        df.dateFormat = NSDateFormatter.dateFormatFromTemplate("edMHHmm", options: 0, locale: NSLocale.currentLocale())
        
        return df
    }()
    
    private dynamic func tick(timer: NSTimer) {
        let time = NSDate()
        
        self.timeLabel.stringValue = dateFormatter.stringFromDate(time)
    }
}
