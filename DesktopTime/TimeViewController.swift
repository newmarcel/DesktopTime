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
    
    private weak var timer: Timer!
    private var dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = DateFormatter.dateFormat(fromTemplate: "edMHHmm", options: 0, locale: .current)
        return df
    }()
    
    private let batteryStatus = BatteryStatus()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup timer
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(tick(_:)), userInfo: nil, repeats: true)
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
            
            updatePosition(of: window)
        }
    }
    
    // MARK: - Actions
    @objc private dynamic func tick(_ timer: Timer) {
        let time = Date()
        var outputString = dateFormatter.string(from: time)
        if let capacity = batteryStatus.currentCapacity {
            outputString += " — \(capacity) %"
        }
        self.timeLabel.stringValue = outputString
        
        if let window = self.view.window {
            updatePosition(of: window)
        }
    }
    
    // MARK: -
    private func updatePosition(of window: NSWindow) {
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
    func windowDidChangeScreen(_ notification: Notification) {
        if let window = notification.object as? NSWindow {
            NSLog("Window did change screen %@", window)
            updatePosition(of: window)
        }
    }
}
