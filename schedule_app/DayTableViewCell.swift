//
//  DayTableViewCell.swift
//  schedule_app
//
//  Created by Акжан Калиматов on 02.01.2023.
//

import UIKit

class DayTableViewCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource {
   
    
    
    var objects = [
        DayInfoModel(teacher: "Askar Sharipov", subject: "Russian Language 2", place: "C1.3.259", lessonType: "Lecture", firstTime: "9:30", secondTime: "10:30"),
        DayInfoModel(teacher: "Akzhan Kalimatov", subject: "Calculus 2", place: "C1.3.259", lessonType: "Practice", firstTime: "11:30", secondTime: "12:30"),
        DayInfoModel(teacher: "Zaur Berdibekov", subject: "NOSQL Database", place: "C1.3.259", lessonType: "Practice", firstTime: "13:30", secondTime: "15:00"),
        DayInfoModel(teacher: "Umar Mussa", subject: "Mobile Development", place: "C1.3.259", lessonType: "Lecture", firstTime: "14:00", secondTime: "14:30"),
        DayInfoModel(teacher: "Aibek Raushanov", subject: "Computer Organization Architecture", place: "Online", lessonType: "Lecture", firstTime: "16:30", secondTime: "18:30")
    ]
    @IBOutlet weak var dayInfoTableView: UITableView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weekDayLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        dayInfoTableView.delegate = self
        dayInfoTableView.dataSource = self
    }
    
    
    func set(object: DayModel) {
        self.dateLabel.text = object.date
        self.weekDayLabel.text = object.weekDay
    }


    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "dayInfoCell", for: indexPath) as! DayInfoTableViewCell
            let object = objects[indexPath.row]
            cell.set(object: object)
            return cell
    }

}
