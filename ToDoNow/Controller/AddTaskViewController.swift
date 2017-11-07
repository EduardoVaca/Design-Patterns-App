//
//  AddTaskViewController.swift
//  ToDoNow
//
//  Created by Eduardo Vaca on 06/11/17.
//  Copyright © 2017 Vaca. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timerButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var hoursTextField: UITextField!
    @IBOutlet weak var minutesTextField: UITextField!
    @IBOutlet weak var secondsTextField: UITextField!
    @IBOutlet weak var priorityPicker: UIPickerView!
    
    let priorities = [Priority.high.rawValue, Priority.medium.rawValue, Priority.low.rawValue]
    
    var item: Item?
    var memento: Memento?
    var savedItem: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        priorityPicker.delegate = self
        priorityPicker.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customViewBasedOnMode()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if !savedItem {
            if let memento = memento,
                let priority = Priority(rawValue: priorities[priorityPicker.selectedRow(inComponent: 0)]) {
                memento.saveStateToMemento(name: nameTextField.text,
                                           hours: hoursTextField.text,
                                           minutes: minutesTextField.text,
                                           seconds: secondsTextField.text,
                                           priority: priority)
            }
        }
    }
    
    func customViewBasedOnMode() {
        if let item = item {
            titleLabel.text = item.name
            timerButton.isHidden = false
            addButton.setTitle("Save", for: .normal)
            nameTextField.text = item.name
            var timeValues = Utils.timeValues(seconds: item.seconds)
            hoursTextField.text = "\(timeValues.0)"
            minutesTextField.text = "\(timeValues.1)"
            secondsTextField.text = "\(timeValues.2)"
            if let priorityIndex = priorities.index(of: item.priority.rawValue) {
                priorityPicker.selectRow(priorityIndex, inComponent: 0, animated: true)
            }
        } else {
            if let memento = memento {
                nameTextField.text = memento.name
                hoursTextField.text = memento.hours
                minutesTextField.text = memento.minutes
                secondsTextField.text = memento.seconds
                if let priorityIndex = priorities.index(of: memento.priority.rawValue) {
                    priorityPicker.selectRow(priorityIndex, inComponent: 0, animated: true)
                }
            }
            timerButton.isHidden = true
            addButton.setTitle("Add", for: .normal)
        }
    }
    
    @IBAction func addTask(_ sender: Any) {
        if let name = nameTextField.text,
            let hours = hoursTextField.text,
            let hours_int = Int(hours),
            let minutes = minutesTextField.text,
            let minutes_int = Int(minutes),
            let seconds = secondsTextField.text,
            let seconds_int = Int(seconds),
            let priority = Priority(rawValue: priorities[priorityPicker.selectedRow(inComponent: 0)]) {
            if let item = item {
                item.name = name
                item.seconds = seconds_int + (minutes_int * 60) + (hours_int * 3600)
                item.priority = priority
            } else {
                ItemManager.getInstance().addTask(name: name, hours: hours_int, minutes: minutes_int, seconds: seconds_int, priority: priority)
            }
            if let memento = memento {
                memento.cleanMemento()
            }
            savedItem = true
            NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdateTable"), object: nil)
            self.navigationController?.popViewController(animated: true)
        } else {
            Utils.presentAlert(vc: self, title: "Alert", message: "Fields incorrect")
        }
    }
    
    @IBAction func goToTimer(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let timerVC = storyBoard.instantiateViewController(withIdentifier: "TimerViewController") as! TimerViewController
        timerVC.item = item
        self.navigationController?.pushViewController(timerVC, animated: true)
    }
    
}

extension AddTaskViewController: UIPickerViewDataSource,UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return priorities.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return priorities[row]
    }
}
