//
//  BatteryStatus.swift
//  DesktopTime
//
//  Created by Marcel Dierkes on 22.08.15.
//  Copyright © 2015 Marcel Dierkes. All rights reserved.
//

import Foundation
import IOKit.ps

public class BatteryStatus {
    
    public var currentCapacity: Int? {
        return (powerSourceInfos()?[kIOPSCurrentCapacityKey] as? Int)
    }
    
    private func powerSourceInfos() -> NSDictionary? {
        let blob = IOPSCopyPowerSourcesInfo().takeRetainedValue()
        let sourcesList: NSArray = IOPSCopyPowerSourcesList(blob).takeRetainedValue()
        if CFArrayGetCount(sourcesList) == 0 {
            return nil
        }
        
        let powerSource: NSDictionary = IOPSGetPowerSourceDescription(blob, sourcesList[0]).takeUnretainedValue()
        return powerSource
    }
}
