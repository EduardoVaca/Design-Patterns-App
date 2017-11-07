//
//  TimerViewController.swift
//  ToDoNow
//
//  Created by Eduardo Vaca on 01/11/17.
//  Copyright © 2017 Vaca. All rights reserved.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let item = item {
            hoursTextField.isEnabled = false
            minutesTextField.isEnabled = false
            secondsTextField.isEnabled = false
            seconds = item.seconds
            let timeValues = Utils.timeValues(seconds: seconds)
            hoursTextField.text = "\(timeValues.0)"
            minutesTextField.text = "\(timeValues.1)"
            secondsTextField.text = "\(timeValues.2)"
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let item = item {
            item.timeSpent += (item.seconds - seconds - 1)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdateTable"), object: nil)
        }
    }
    
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
    
    func runTimer() {
        isTimerRunning = true
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(TimerViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if seconds < 0 {
            timer.invalidate()
            // SEND NOTIFICATION OF STOP
        } else {
            timerLabel.text = Utils.timeString(time: TimeInterval(seconds))
            seconds -= 1
        }        
    }

    @IBAction func start(_ sender: Any) {
        if !isTimerRunning && setTotalSeconds(){
            runTimer()
        }
    }
    
    @IBAction func pausePressed(_ sender: Any) {
        if !resumeTapped {
            timer.invalidate()
            resumeTapped = true
        } else {
            runTimer()
            resumeTapped = false
        }
    }
    
    @IBAction func resetPressed(_ sender: Any) {
        timer.invalidate()
        if setTotalSeconds() {
            isTimerRunning = false
            timerLabel.text = Utils.timeString(time: TimeInterval(seconds))
        }
    }
    
}
