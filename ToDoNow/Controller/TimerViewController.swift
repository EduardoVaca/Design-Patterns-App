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
            var secondsTemp = seconds
            let hours = secondsTemp/3600
            hoursTextField.text = "\(hours)"
            secondsTemp -= hours * 3600
            let minutes = secondsTemp/60
            minutesTextField.text = "\(minutes)"
            secondsTemp -= minutes*60
            secondsTextField.text = "\(secondsTemp)"
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
