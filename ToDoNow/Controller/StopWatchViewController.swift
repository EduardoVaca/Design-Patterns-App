//
//  StopWatchViewController.swift
//  ToDoNow
//
//  Created by Eduardo Vaca on 02/11/17.
//  Copyright © 2017 Vaca. All rights reserved.
//

import UIKit

/**
 Controller responsible for StopWatch functionality
 Listen to UI events and refresh UI based upon them
 */
class StopWatchViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    
    var timer = Timer()
    var seconds = 0
    var isTimerRunning = false
    var resumeTapped = false
    
    /**
     Runs the stopwatch initializing a timer to update UI
     */
    func runStopWatch() {
        isTimerRunning = true
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(StopWatchViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    /**
     Method that updates the UI every second
     */
    @objc func updateTimer() {
        seconds += 1
        timeLabel.text = Utils.timeString(time: TimeInterval(seconds))
    }
    
    /**
     Method that listens to the pressing of the start button
     */
    @IBAction func startPressed(_ sender: Any) {
        if !isTimerRunning {
            runStopWatch()
        }
    }
    
    /**
     Method that listens to the pressing of the reset button
     */
    @IBAction func resetPressed(_ sender: Any) {
        timer.invalidate()
        seconds = 0
        timeLabel.text = Utils.timeString(time: TimeInterval(seconds))
        isTimerRunning = false
    }
    
    /**
     Method that listens to the pressing of the pause button
     */
    @IBAction func pausedPressed(_ sender: Any) {
        if !resumeTapped {
            timer.invalidate()
            resumeTapped = true
        } else {
            runStopWatch()
            resumeTapped = false
        }
    }
    
}
