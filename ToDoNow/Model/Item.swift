//
//  Item.swift
//  ToDoNow
//
//  Created by Eduardo Vaca on 01/11/17.
//  Copyright © 2017 Vaca. All rights reserved.
//

import Foundation

enum Priority {
    case high
    case medium
    case low
}

enum Status {
    case completed
    case incompleted
}

public class Item {
    
    var name: String
    var seconds: Int
    var timeSpent: Int
    var priority: Priority
    var status: Status
    
    init(name: String, seconds: Int, minutes: Int, priority: Priority) {
        self.name = name
        self.seconds = seconds
        self.priority = priority
        self.status = Status.incompleted
        self.timeSpent = 0
    }
}
