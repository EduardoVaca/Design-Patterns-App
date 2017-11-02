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
    
    func item(at index: Int) -> Item {
        return items[index]
    }
}
