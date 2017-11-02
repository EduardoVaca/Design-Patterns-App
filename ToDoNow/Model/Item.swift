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

public class Item {
    
    var name: String
    var seconds: Int
    var minutes: Int
    var priority: Priority
    
    init(name: String, seconds: Int, minutes: Int, priority: Priority) {
        self.name = name
        self.seconds = seconds
        self.minutes = minutes
        self.priority = priority
    }
}
