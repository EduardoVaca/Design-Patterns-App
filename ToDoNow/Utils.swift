//
//  Utils.swift
//  ToDoNow
//
//  Created by Eduardo Vaca on 02/11/17.
//  Copyright © 2017 Vaca. All rights reserved.
//

import Foundation

class Utils {
    
    static func timeString(time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i:%02i", arguments: [hours, minutes, seconds])
    }
    
    static func timeValues(seconds: Int) ->  (Int, Int, Int) {
        var secondsTemp = seconds
        let hours = secondsTemp/3600
        secondsTemp -= hours * 3600
        let minutes = secondsTemp/60
        secondsTemp -= minutes*60
        return (hours, minutes, secondsTemp)
    }
}
