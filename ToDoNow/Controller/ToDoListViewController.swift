//
//  ToDoListViewController.swift
//  ToDoNow
//
//  Created by Eduardo Vaca on 01/11/17.
//  Copyright © 2017 Vaca. All rights reserved.
//

import UIKit

class ToDoListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var dataSource = ToDoDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
        tableView.rowHeight = 100
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc func goToTimer(_ sender: UIButton) {
        print("Hello");
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let timerVC = storyBoard.instantiateViewController(withIdentifier: "TimerViewController") as! TimerViewController
        self.navigationController?.pushViewController(timerVC, animated: true)
    }

}

extension ToDoListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
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
}