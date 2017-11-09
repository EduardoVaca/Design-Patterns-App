//
//  ItemManager.swift
//  ToDoNow
//
//  Created by Eduardo Vaca on 02/11/17.
//  Copyright © 2017 Vaca. All rights reserved.
//

import UIKit

protocol Stored {
    
    func store()
}

class ItemManager: NSObject, Stored {
    
    private static let instance = ItemManager()
    private var items: [Item]
    
    var itemsCount: Int { return items.count }
    
    private override init() {
        if let encodedItems = UserDefaults.standard.object(forKey: "items") as? Data,
            let items = NSKeyedUnarchiver.unarchiveObject(with: encodedItems) as? [Item] {
            self.items = items
        }
        else {
            self.items = []
        }
    }
    
    static func getInstance() -> ItemManager{
        return instance
    }
    
    func item(at index: Int) -> Item {
        return items[index]
    }
    
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
    
    func addTask(name: String, hours: Int, minutes: Int, seconds: Int, priority: Priority) {
        items.append(Item(name: name, seconds: seconds + (minutes * 60) + (hours * 3600), priority: priority))
    }
    
    func addTask(item: Item) {
        items.append(item)
    }
    
    func removeTask(at index: Int) {
        items.remove(at: index)
    }
    
    func store() {
        print("DYING2")
        let userDefaults = UserDefaults.standard
        let encodedItems: Data = NSKeyedArchiver.archivedData(withRootObject: items)
        userDefaults.set(encodedItems, forKey: "items")
        userDefaults.synchronize()
    }
}
