//
//  ItemManager.swift
//  ToDoNow
//
//  Created by Eduardo Vaca on 02/11/17.
//  Copyright © 2017 Vaca. All rights reserved.
//

import UIKit

class ItemManager: NSObject {
    
    var itemsCount: Int { return items.count }
    private var items: [Item] = [
        Item(name: "Second", seconds: 210, priority: Priority.medium),
        Item(name: "Last", seconds: 40, priority: Priority.low),
        Item(name: "First", seconds: 30, priority: Priority.high)
    ]
    
    override init() {
        items[2].status = .completed
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
}
