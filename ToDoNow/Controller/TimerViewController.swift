//
//  TimerViewController.swift
//  ToDoNow
//
//  Created by Eduardo Vaca on 01/11/17.
//  Copyright © 2017 Vaca. All rights reserved.
//

import UIKit

/**
 Controller responsible for StopWatch functionality
 Listen to UI events and refresh UI based upon them
 Two cases:
     - Just timer
     - Timer with a ToDo Item
 */
class TimerViewController: UIViewController {

    @IBOutlet weak var hoursTextField: UITextField!
    @IBOutlet weak var minutesTextField: UITextField!
    @IBOutlet weak var secondsTextField: UITextField!
    @IBOutlet weak var timerLabel: UILabel!
    
    var timer = Timer()
    var seconds = 0
    var isTimerRunning = false
    var resumeTapped = false
    var item: Item?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customView()
    }
    
    /**
     Customs UI based on the existance of a ToDo Item
     */
    func customView() {
        if let item = item {
            hoursTextField.isEnabled = false
            minutesTextField.isEnabled = false
            secondsTextField.isEnabled = false
            seconds = item.seconds
            let timeValues = Utils.timeValues(seconds: seconds)
            hoursTextField.text = "\(timeValues.0)"
            minutesTextField.text = "\(timeValues.1)"
            secondsTextField.text = "\(timeValues.2)"
            timerLabel.text = Utils.timeString(time: TimeInterval(seconds))
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let item = item {
            item.timeSpent += (item.seconds - seconds)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdateTable"), object: nil)
        }
    }
    
    /**
     Method that set the total of seconds based on hours, minutes and seconds inserted
     - Returns: true if fields are valid, false if not
     */
    func setTotalSeconds() -> Bool {
        if let seconds = secondsTextField.text,
            let secondsValue = Int(seconds),
            let minutes = minutesTextField.text,
            let minutesValue = Int(minutes),
            let hours = hoursTextField.text,
            let hoursValue = Int(hours) {
            self.seconds = secondsValue + (minutesValue * 60) + (hoursValue * 3600)
            return true
        }
        return false
    }
    
    /**
     Runs timer scheduling a func to run every second
     */
    func runTimer() {
        isTimerRunning = true
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(TimerViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    /**
     Function to be called by timer to update UI or present alert if time is up
     */
    @objc func updateTimer() {
        if seconds < 0 {
            timer.invalidate()
            if let item = item {
                Utils.presentAlert(vc: self, title: "Time's up!", message: "No more time for: \(item.name)")
            } else {
                Utils.presentAlert(vc: self, title: "Time's up!", message: "No more time left")
            }
        } else {
            timerLabel.text = Utils.timeString(time: TimeInterval(seconds))
            seconds -= 1
        }        
    }
    
    /**
     Method that listens to the pressing of the start button
     */
    @IBAction func start(_ sender: Any) {
        if !isTimerRunning && setTotalSeconds(){
            runTimer()
        }
    }
    
    /**
     Method that listens to the pressing of the pause button
     */
    @IBAction func pausePressed(_ sender: Any) {
        if !resumeTapped {
            timer.invalidate()
            resumeTapped = true
        } else {
            runTimer()
            resumeTapped = false
        }
    }
    
    /**
     Method that listens to the pressing of the reset button
     */
    @IBAction func resetPressed(_ sender: Any) {
        timer.invalidate()
        if setTotalSeconds() {
            isTimerRunning = false
            timerLabel.text = Utils.timeString(time: TimeInterval(seconds))
        }
    }
    
}
