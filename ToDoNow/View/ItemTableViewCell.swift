//
//  ItemTableViewCell.swift
//  ToDoNow
//
//  Created by Eduardo Vaca on 02/11/17.
//  Copyright © 2017 Vaca. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemDurationLabel: UILabel!
    @IBOutlet weak var itemTimeSpentLabel: UILabel!
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var itemPriorityLabel: UILabel!
    
    private var item: Item?
    private var strategy: Strategy?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        completeButton.addTarget(self, action: #selector(ItemTableViewCell.completeItem(_:)), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with item: Item) {
        itemNameLabel.text = item.name
        itemDurationLabel.text = "Duration: \(Utils.timeString(time: TimeInterval(item.seconds)))"
        itemTimeSpentLabel.text = "Time spent: \(Utils.timeString(time: TimeInterval(item.timeSpent)))"
        itemPriorityLabel.text = item.priority.rawValue
        completeButton.setTitle(item.status == .incompleted ? "Complete"  : "Restore", for: .normal)
        self.item = item
    }
    
    @objc func completeItem(_ sender: UIButton) {
        if let item = item {
            if item.status == .incompleted {
                strategy = OperationComplete()
            } else {
                strategy = OperationRestore()
            }
            strategy?.doOperation(on: item)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "UpdateTable"), object: nil)
        }
    }

}
