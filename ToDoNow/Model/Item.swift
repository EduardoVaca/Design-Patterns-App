//
//  Item.swift
//  ToDoNow
//
//  Created by Eduardo Vaca on 01/11/17.
//  Copyright © 2017 Vaca. All rights reserved.
//

import Foundation

/**
 Represents the priority of an item
 ```
 case high
 case medium
 case low
 ```
 */
enum Priority: String {
    /// Item has high priority
    case high = "High"
    
    /// Item has medium priority
    case medium = "Medium"
    
    /// Item has low priority
    case low = "Low"
}

/**
 Represents the status of an item
 ```
 case completed
 case incompleted
 ```
 */
enum Status: Int {
    /// Item already completed
    case completed
    
    /// Item to be completed
    case incompleted
}

/**
 Item for ToDoList
 Conforms NSObject and NSCoding to be encoded when app terminating and to be decoded when app launches
 */
class Item: NSObject, NSCoding {
    
    var name: String
    var seconds: Int
    var timeSpent: Int
    var priority: Priority
    var status: Status
    
    /**
     Item initializer
     - Parameter name: Item name
     - Parameter seconds: Item duration in seconds
     - Parameter priority: Item Priority
     - Parameter timeSpent: Time already spent on item
     - Parameter status: Item status
     */
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
