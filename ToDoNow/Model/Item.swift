//
//  Item.swift
//  ToDoNow
//
//  Created by Eduardo Vaca on 01/11/17.
//  Copyright © 2017 Vaca. All rights reserved.
//

import Foundation

enum Priority: String {
    case high = "High"
    case medium = "Medium"
    case low = "Low"
}

enum Status: Int {
    case completed
    case incompleted
}

class Item: NSObject, NSCoding {
    
    var name: String
    var seconds: Int
    var timeSpent: Int
    var priority: Priority
    var status: Status
    
    init(name: String, seconds: Int, priority: Priority, timeSpent: Int = 0, status: Status = .incompleted) {
        self.name = name
        self.seconds = seconds
        self.priority = priority
        self.status = status
        self.timeSpent = timeSpent
    }
    
    convenience required init(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let seconds = aDecoder.decodeInteger(forKey: "seconds")
        let timeSpent = aDecoder.decodeInteger(forKey: "timeSpent")
        let priority_str = aDecoder.decodeObject(forKey: "priority") as! String
        let status_int = aDecoder.decodeInteger(forKey: "status")
        let priority = Priority(rawValue: priority_str) ?? .high
        let status = Status(rawValue: status_int) ?? .incompleted
        self.init(name: name, seconds: seconds, priority: priority, timeSpent: timeSpent, status: status)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.seconds, forKey: "seconds")
        aCoder.encode(self.timeSpent, forKey: "timeSpent")
        aCoder.encode(self.priority.rawValue, forKey: "priority")
        aCoder.encode(self.status.rawValue, forKey: "status")
    }
    
}
