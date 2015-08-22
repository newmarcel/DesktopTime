//
//  TimeViewController.swift
//  DesktopTime
//
//  Created by Marcel Dierkes on 18.08.15.
//  Copyright © 2015 Marcel Dierkes. All rights reserved.
//

import Cocoa

class TimeViewController: NSViewController {
    
    // MARK: - Properties
    @IBOutlet weak var timeLabel: NSTextField!
    
    private weak var timer: NSTimer!
    private var dateFormatter: NSDateFormatter = {
        let df = NSDateFormatter()
        df.dateFormat = NSDateFormatter.dateFormatFromTemplate("edMHHmm", options: 0, locale: NSLocale.currentLocale())
        
        return df
    }()
    
    private let batteryStatus = BatteryStatus()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup timer
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("tick:"), userInfo: nil, repeats: true)
        tick(timer)  // initial tick:
    }
    
    deinit {
        if let timer = self.timer {
            timer.invalidate()
        }
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        if let window = self.view.window {
            window.delegate = self
            
            updatePositionOfWindow(window)
        }
    }
    
    // MARK: - Actions
    private dynamic func tick(timer: NSTimer) {
        let time = NSDate()
        
        self.timeLabel.stringValue = dateFormatter.stringFromDate(time) + " — \(batteryStatus.currentCapacity) %"
        
        if let window = self.view.window {
            updatePositionOfWindow(window)
        }
    }
    
    // MARK: -
    private func updatePositionOfWindow(window: NSWindow) {
        var frame = window.frame
        if let screen = window.screen {
            frame.origin.y = ceil(screen.frame.size.height - frame.size.height)
            
            // Constrain size
            frame.size.width = self.timeLabel.intrinsicContentSize.width + 16.0  // + padding
            frame.origin.x = floor((screen.frame.size.width/2.0) - (frame.size.width/2.0))
        }
        window.setFrame(frame, display: true)
    }
}

extension TimeViewController: NSWindowDelegate {
    func windowDidChangeScreen(notification: NSNotification) {
        if let window = notification.object as? NSWindow {
            NSLog("Window did change screen %@", window)
            updatePositionOfWindow(window)
        }
    }
}
