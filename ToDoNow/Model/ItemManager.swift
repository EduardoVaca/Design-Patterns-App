//
//  ItemManager.swift
//  ToDoNow
//
//  Created by Eduardo Vaca on 02/11/17.
//  Copyright © 2017 Vaca. All rights reserved.
//

import UIKit

/**
 Protocol for encapsulating functionality of storing information on UserDefaults before terminating app
 This follows the Facade pattern, the caller won't know the implementation just that is stores information before killing the app
 */
protocol Stored {
    /// Store implementation of object in UserDefaults before app terminating
    func store()
}

/**
 Object responsible for managing items of the ToDoList
 Follows Mediator Pattern, it´s how the controller access the real data (items)
 Follows Singleton Pattern, there is only one instance in all the flow of the app
 */
class ItemManager: NSObject, Stored {
    /// Singleton instance
    private static let instance = ItemManager()
    /// Items of ToDoList
    private var items: [Item]
    
    var itemsCount: Int { return items.count }
    
    /**
     Initializer reading from UserDefaults and decoding items
     */
    private override init() {
        if let encodedItems = UserDefaults.standard.object(forKey: "items") as? Data,
            let items = NSKeyedUnarchiver.unarchiveObject(with: encodedItems) as? [Item] {
            self.items = items
        }
        else {
            self.items = []
        }
    }
    
    /**
     Gets Singleton instance of the manager
     */
    static func getInstance() -> ItemManager{
        return instance
    }
    
    /**
     Gets the item at a given index
     - Parameter index: Index of item
     - Returns: an item
     */
    func item(at index: Int) -> Item {
        return items[index]
    }
    
    /**
     Method that sorts the items based on priority, status and duration
     */
    func sortByPriority() {
        items.sort { (x, y) -> Bool in
            if x.status != y.status {
                return x.status == .incompleted
            }
            else if x.priority != y.priority {
                if x.priority == .high || (x.priority == .medium && y.priority == .low) {
                    return true
                } else {
                    return false
                }
            } else {
                return x.seconds < y.seconds
            }
        }
    }
    
    /**
     Adds a task to the items list following Factory Pattern
     - Parameter name: name of the item
     - Parameter hours: Hours of duration
     - Parameter minutes: Minutes of duration
     - Parameter seconds: Seconds of duration
     - Parameter priority: Item Priority
     */
    func addTask(name: String, hours: Int, minutes: Int, seconds: Int, priority: Priority) {
        items.append(Item(name: name, seconds: seconds + (minutes * 60) + (hours * 3600), priority: priority))
    }
    
    /**
     Adds a task to the items list following Factory Pattern
     - Parameter item: Item to be added
     */
    func addTask(item: Item) {
        items.append(item)
    }
    
    /**
     Removes an item
     - Parameter index: Index of the item to be removed
     */
    func removeTask(at index: Int) {
        items.remove(at: index)
    }
    
    
    func store() {        
        let userDefaults = UserDefaults.standard
        let encodedItems: Data = NSKeyedArchiver.archivedData(withRootObject: items)
        userDefaults.set(encodedItems, forKey: "items")
        userDefaults.synchronize()
    }
}
