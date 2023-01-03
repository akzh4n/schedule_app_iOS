//
//  ScheduleViewController.swift
//  schedule_app
//
//  Created by Акжан Калиматов on 02.01.2023.
//

import UIKit

class ScheduleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
  

    @IBOutlet weak var dayTableView: UITableView!
    
    
    var objects = [
        DayModel(weekDay: "Saturday", date: "23.10"),
        DayModel(weekDay: "Friday", date: "24.10"),
        DayModel(weekDay: "Monday", date: "25.10"),
        DayModel(weekDay: "Thursday", date: "26.10")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dayTableView.delegate = self
        dayTableView.dataSource = self
        
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dayCell", for: indexPath) as! DayTableViewCell
        let object = objects[indexPath.row]
        cell.set(object: object)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 350
       }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}






