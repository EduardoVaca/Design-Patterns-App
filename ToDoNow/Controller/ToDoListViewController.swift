//
//  ToDoListViewController.swift
//  ToDoNow
//
//  Created by Eduardo Vaca on 01/11/17.
//  Copyright © 2017 Vaca. All rights reserved.
//

import UIKit

/**
 Controller responsible for managing List of ToDo items
 */
class ToDoListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!    
    
    var dataSource = ToDoDataSource()
    let memento = Memento()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
        tableView.rowHeight = 80
        dataSource.itemManager.sortByPriority()
        let leftButton = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ToDoListViewController.showEditing(_:)))
        self.navigationItem.leftBarButtonItem = leftButton
        /**
         Observer pattern, adds an observer which is listening to a notification of change and when received execute method
         */
        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "UpdateTable"), object: nil, queue: nil, using: updateTable)
    }
    
    /**
     Instantiates TimerViewController and push it into the navigation stack
     */
    @objc func goToTimer(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let timerVC = storyBoard.instantiateViewController(withIdentifier: "TimerViewController") as! TimerViewController
        self.navigationController?.pushViewController(timerVC, animated: true)
    }
    
    /**
     Instantiates StopWatchViewController and push it into the navigation stack
     */
    @objc func goToStopWatch(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let stopWatchVC = storyBoard.instantiateViewController(withIdentifier: "StopWatchViewController") as! StopWatchViewController
        self.navigationController?.pushViewController(stopWatchVC, animated: true)
    }
    
    /**
     Method called by the observer when notification of change is received
     Updates DataSource info and refresh table
     - Parameter notification: Notification received
     */
    func updateTable(notification: Notification) {
        dataSource.updateData()
        tableView.reloadData()
    }
    
    /**
     Listener for button AddTask
     Instantiates AddTaskVC and push it into the navigation stack
     */
    @IBAction func addTask(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let addVC = storyBoard.instantiateViewController(withIdentifier: "AddTaskViewController") as! AddTaskViewController
        addVC.memento = memento
        self.navigationController?.pushViewController(addVC, animated: true)
    }
    
    /**
     Listener for button Edit
     If pressed put the list on Edit mode
     Here the table view has a State Pattern based on the Edit button
     */
    @objc func showEditing(_ sender: UIBarButtonItem) {
        if(self.tableView.isEditing == true)
        {
            self.tableView.isEditing = false
            self.navigationItem.leftBarButtonItem?.title = "Edit"
        }
        else
        {
            self.tableView.isEditing = true
            self.navigationItem.leftBarButtonItem?.title = "Done"
        }
    }

}

/**
 Extension for conforming the TableView Delegate
 */
extension ToDoListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let frame: CGRect = tableView.frame
        
        let manualTimerButton: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: frame.width, height: 50))
        manualTimerButton.setTitle("Go To Timer", for: .normal)
        manualTimerButton.backgroundColor = UIColor.black
        manualTimerButton.addTarget(self, action: #selector(ToDoListViewController.goToTimer(_:)), for: .touchUpInside)
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        headerView.addSubview(manualTimerButton)
        headerView.backgroundColor = UIColor.gray
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let frame: CGRect = tableView.frame
        
        let manualTimerButton: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: frame.width, height: 50))
        manualTimerButton.setTitle("Go To Stopwatch", for: .normal)
        manualTimerButton.backgroundColor = UIColor.black
        manualTimerButton.addTarget(self, action: #selector(ToDoListViewController.goToStopWatch(_:)), for: .touchUpInside)
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        headerView.addSubview(manualTimerButton)
        headerView.backgroundColor = UIColor.gray
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let addVC = storyBoard.instantiateViewController(withIdentifier: "AddTaskViewController") as! AddTaskViewController
        addVC.item = ItemManager.getInstance().item(at: indexPath.row)
        self.navigationController?.pushViewController(addVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if ItemManager.getInstance().item(at: indexPath.row).status == .completed {
            return nil
        } else {
            return indexPath
        }
    }
}
