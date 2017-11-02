//
//  StopWatchViewController.swift
//  ToDoNow
//
//  Created by Eduardo Vaca on 02/11/17.
//  Copyright © 2017 Vaca. All rights reserved.
//

import UIKit

class StopWatchViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    
    var timer = Timer()
    var seconds = 0
    var isTimerRunning = false
    var resumeTapped = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func runStopWatch() {
        isTimerRunning = true
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(StopWatchViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        seconds += 1
        timeLabel.text = timeString(time: TimeInterval(seconds))
    }
    
    @IBAction func startPressed(_ sender: Any) {
        if !isTimerRunning {
            runStopWatch()
        }
    }
    
    @IBAction func resetPressed(_ sender: Any) {
        timer.invalidate()
        seconds = 0
        timeLabel.text = timeString(time: TimeInterval(seconds))
        isTimerRunning = false
    }
    
    @IBAction func pausedPressed(_ sender: Any) {
        if !resumeTapped {
            timer.invalidate()
            resumeTapped = true
        } else {
            runStopWatch()
            resumeTapped = false
        }
    }
    
    func timeString(time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i:%02i", arguments: [hours, minutes, seconds])
    }
}
