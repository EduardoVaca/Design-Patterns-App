//
//  ToDoDataSource.swift
//  ToDoNow
//
//  Created by Eduardo Vaca on 01/11/17.
//  Copyright © 2017 Vaca. All rights reserved.
//

import UIKit

class ToDoDataSource: NSObject, UITableViewDataSource {
    
    let itemManager = ItemManager()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemManager.itemsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemTableViewCell
        let item = itemManager.item(at: indexPath.row)
        cell.configure(with: item)
        return cell
    }
    
    func updateData() {
        itemManager.sortByPriority()
    }
}
