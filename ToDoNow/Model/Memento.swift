//
//  Memento.swift
//  ToDoNow
//
//  Created by Eduardo Vaca on 07/11/17.
//  Copyright © 2017 Vaca. All rights reserved.
//

import Foundation

class Memento {
    
    var name: String?
    var hours: String?
    var minutes: String?
    var seconds: String?
    var priority: Priority = .high
    
    func saveStateToMemento(name: String?, hours: String?, minutes: String?, seconds: String?, priority: Priority) {
        self.name = name
        self.minutes = minutes
        self.hours = hours
        self.seconds = seconds
        self.priority = priority
    }
    
    func cleanMemento() {
        name = nil
        hours = nil
        minutes = nil
        seconds = nil
        priority = .high
    }
}
