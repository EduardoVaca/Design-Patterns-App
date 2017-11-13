//
//  Strategy.swift
//  ToDoNow
//
//  Created by Eduardo Vaca on 06/11/17.
//  Copyright © 2017 Vaca. All rights reserved.
//

import Foundation

/**
 Protocol following Strategy Patter
 */
protocol Strategy {
    /**
     Method for doing an operation on an item
     - Parameter item: Item to use
     */
    func doOperation(on item: Item)
}

/**
 Operation to restore an item in ToDoList
 Implements Strategy
 */
class OperationRestore: Strategy {
    
    func doOperation(on item: Item) {
        item.status = .incompleted
    }
}

/**
 Operation to complete an item in ToDoList
 Implements Strategy
 */
class OperationComplete: Strategy {
    
    func doOperation(on item: Item) {
        item.status = .completed
    }
}
