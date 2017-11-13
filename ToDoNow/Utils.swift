//
//  Utils.swift
//  ToDoNow
//
//  Created by Eduardo Vaca on 02/11/17.
//  Copyright © 2017 Vaca. All rights reserved.
//

import UIKit

/**
 Class containing shared functions used in many places
 */
class Utils {
    
    /**
     Gets the time string format of a given time
     - Parameter time: Time to obtain str
     - Returns: Time str representation
     */
    static func timeString(time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i:%02i", arguments: [hours, minutes, seconds])
    }
    
    /**
     Gets time values from a total of seconds
     - Parameter seconds: Total seconds
     - Returns: Tuple of (hours, minutes, seconds)
     */
    static func timeValues(seconds: Int) ->  (Int, Int, Int) {
        var secondsTemp = seconds
        let hours = secondsTemp/3600
        secondsTemp -= hours * 3600
        let minutes = secondsTemp/60
        secondsTemp -= minutes*60
        return (hours, minutes, secondsTemp)
    }
    
    /**
     Presents an alert in a ViewController
     - Parameter: vc: ViewController where the alert will be presented
     - Parameter title: Alert title
     - Parameter message: Alert message
     */
    static func presentAlert(vc: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
}
