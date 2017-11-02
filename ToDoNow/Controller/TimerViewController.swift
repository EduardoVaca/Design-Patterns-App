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
    var minutes = 0
    var hours = 0
    var isTimerRunning = false
    var resumeTapped = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func runTimer() {
        isTimerRunning = true
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(TimerViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        timerLabel.text = timeString(time: TimeInterval(seconds))
        seconds -= 1
    }

    @IBAction func start(_ sender: Any) {
        if !isTimerRunning {
            if let seconds = secondsTextField.text,
                let value = Int(seconds) {
                self.seconds = value                
                runTimer()
            }
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
        
        if let seconds = secondsTextField.text,
            let value = Int(seconds) {
            self.seconds = value
            
            isTimerRunning = false
            timerLabel.text = timeString(time: TimeInterval(seconds)!)
        }
    }
    
    func timeString(time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i:%02i", arguments: [hours, minutes, seconds])
    }
    
}
