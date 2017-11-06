//
//  AddTaskViewController.swift
//  ToDoNow
//
//  Created by Eduardo Vaca on 06/11/17.
//  Copyright © 2017 Vaca. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var hoursTextField: UITextField!
    @IBOutlet weak var minutesTextField: UITextField!
    @IBOutlet weak var secondsTextField: UITextField!
    @IBOutlet weak var priorityPicker: UIPickerView!
    
    let priorities = [Priority.high.rawValue, Priority.medium.rawValue, Priority.low.rawValue]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        priorityPicker.delegate = self
        priorityPicker.dataSource = self
    }
    
    func areFieldsValid() -> Bool {
        if let _ = nameTextField.text,
            let hours = hoursTextField.text,
            let _ = Int(hours),
            let minutes = minutesTextField.text,
            let _ = Int(minutes),
            let seconds = secondsTextField.text,
            let _ = Int(seconds) {
            return true
        }
        return false
    }
    
    @IBAction func addTask(_ sender: Any) {
        if areFieldsValid() {
            print(priorityPicker.selectedRow(inComponent: 0))
        } else {
            let alert = UIAlertController(title: "Alert", message: "Fields incorrect", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
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
