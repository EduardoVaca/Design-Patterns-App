//
//  ToDoDataSource.swift
//  ToDoNow
//
//  Created by Eduardo Vaca on 01/11/17.
//  Copyright © 2017 Vaca. All rights reserved.
//

import UIKit

/**
 Class responsible for managing which element is displayed in which cell
 Iterator Pattern implementated in a different way via DataSource for iOS
 */
class ToDoDataSource: NSObject, UITableViewDataSource {
    
    let itemManager = ItemManager.getInstance()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemManager.itemsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemTableViewCell
        let item = itemManager.item(at: indexPath.row)
        cell.configure(with: item)
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            itemManager.removeTask(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    /**
     Updates Mediator data by calling it's method of sort
     */
    func updateData() {
        itemManager.sortByPriority()
    }
}
