//
//  Memento.swift
//  ToDoNow
//
//  Created by Eduardo Vaca on 07/11/17.
//  Copyright © 2017 Vaca. All rights reserved.
//

import Foundation

/**
 Class responsible for creating an unsubmitted version of an Item
 Follows Memento Pattern
 */
class Memento {
    
    var name: String?
    var hours: String?
    var minutes: String?
    var seconds: String?
    var priority: Priority = .high
    
    /**
     Saves the state of the version of an Item as a memento
     - Parameter name: Name of item
     - Parameter hours: Hourse of item
     - Parameter minutes: Minutes of item
     - Parameter seconds: Seconds of item
     - Parameter priority: Priority of item
     */
    func saveStateToMemento(name: String?, hours: String?, minutes: String?, seconds: String?, priority: Priority) {
        self.name = name
        self.minutes = minutes
        self.hours = hours
        self.seconds = seconds
        self.priority = priority
    }
    
    /**
     Delete and clean info of memento item's version
     */
    func cleanMemento() {
        name = nil
        hours = nil
        minutes = nil
        seconds = nil
        priority = .high
    }
}
