//
//  ItemFactory.swift
//  ToDoNow
//
//  Created by Eduardo Vaca on 13/11/17.
//  Copyright © 2017 Vaca. All rights reserved.
//

import Foundation

/**
 Class responsible of the creation of objects Item
 Follows Factory pattern
 */
class ItemFactory {
    
    /**
     Gets a new task to the items list following Factory Pattern
     - Parameter name: name of the item
     - Parameter hours: Hours of duration
     - Parameter minutes: Minutes of duration
     - Parameter seconds: Seconds of duration
     - Parameter priority: Item Priority
     */
    func getNewTask(name: String, hours: Int, minutes: Int, seconds: Int, priority: Priority) -> Item {
        return Item(name: name, seconds: seconds + (minutes * 60) + (hours * 3600), priority: priority)
    }
}
