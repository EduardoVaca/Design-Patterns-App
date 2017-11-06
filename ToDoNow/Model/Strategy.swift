//
//  Strategy.swift
//  ToDoNow
//
//  Created by Eduardo Vaca on 06/11/17.
//  Copyright © 2017 Vaca. All rights reserved.
//

import Foundation

protocol Strategy {
    func doOperation(on item: Item)
}

class OperationRestore: Strategy {
    
    func doOperation(on item: Item) {
        item.status = .incompleted
    }
}

class OperationComplete: Strategy {
    
    func doOperation(on item: Item) {
        item.status = .completed
    }
}
