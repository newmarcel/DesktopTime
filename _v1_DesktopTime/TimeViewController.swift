//
//  TimeViewController.swift
//  DesktopTime
//
//  Created by Marcel Dierkes on 18.08.15.
//  Copyright © 2015 Marcel Dierkes. All rights reserved.
//

import Cocoa

final class TimeViewController: NSViewController {
    
    // MARK: - Properties
    @IBOutlet weak var batteryLabel: NSTextField!
    @IBOutlet weak var timeLabel: NSTextField!
    
    private weak var timer: Timer!
    private var dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .long // ignore
        df.timeStyle = .short // ignore
        df.dateFormat = DateFormatter.dateFormat(
            fromTemplate: "eddMMHHmm", options: 0, locale: .current
        )
        df.formattingContext = .standalone
        return df
    }()
    
    private let batteryStatus = BatteryStatus()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup timer
        timer = Timer.scheduledTimer(
            timeInterval: 1.0, target: self, selector: #selector(tick(_:)),
            userInfo: nil, repeats: true
        )
        tick(timer)  // initial tick:
    }
    
    deinit {
        if let timer = self.timer {
            timer.invalidate()
        }
    }
    
    // MARK: - Actions
    @objc private dynamic func tick(_ timer: Timer) {
        let time = Date()
        
        if let capacity = batteryStatus.currentCapacity {
            self.batteryLabel.stringValue = "\(capacity) %"
        } else {
            self.batteryLabel.stringValue = ""
        }
        
        self.timeLabel.stringValue = dateFormatter.string(from: time)
        
        if let window = self.view.window {
            updatePosition(of: window)
        }
    }
}
