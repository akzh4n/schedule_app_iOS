//
//  SecondTableViewCell.swift
//  schedule_app
//
//  Created by Акжан Калиматов on 11.01.2023.
//

import UIKit
import Firebase
import FirebaseStorage

class SecondTableViewCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource {
 
    

    let db = Firestore.firestore()
    
    
    
    @IBOutlet weak var secondDayInfoTableView: UITableView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weekDayLabel: UILabel!
    
    
    
    var currentDay = CurrentDateFormatter().setCurrentData(currentDateInt: 1)
    var secondDayInfoObjects = [DayInfoModel]()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        secondDayInfoTableView.delegate = self
        secondDayInfoTableView.dataSource = self
        secondDayInfoTableView.register(UITableViewCell.self, forCellReuseIdentifier: "defaultCell")
        weekDayLabel.text = CurrentDateFormatter().setCurrentData(currentDateInt: 1)
        dateLabel.text = CurrentDateFormatter().setCurrentDataNumber(currentDateInt: 1)
        
        fetchData(dayWeek: currentDay)
        
    }
    
    
    func fetchData(dayWeek: String) {
           db.collection("SE-2109").document(dayWeek).getDocument { [self] snapshot, error in
               if error != nil {
                   print("Error")
               }
               else {
                  
                   
                   let data = snapshot!.data()
                   let teacherArray = data!["teacher"] as! [String]
                   let subjectArray = data!["subject"] as! [String]
                   let placeArray = data!["place"] as! [String]
                   let lessonTypeArray = data!["type"] as! [String]
                   let firstTimeArray = data!["startTime"] as! [String]
                   let secondTimeArray = data!["endTime"] as! [String]
                   
                   for i in 0..<teacherArray.count {
                       let scheduleItem = DayInfoModel(teacher: [teacherArray[i]], subject: [subjectArray[i]], place: [placeArray[i]], lessonType: [lessonTypeArray[i]], firstTime: [firstTimeArray[i]], secondTime: [secondTimeArray[i]])
                       self.secondDayInfoObjects.append(scheduleItem)

                   }
                   
                   
                 
                   secondDayInfoTableView.updateConstraints()
                   secondDayInfoTableView.reloadData()
               }
           }
       }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return secondDayInfoObjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "secondDayInfoCell", for: indexPath) as! SecondDayTableViewCell
        let object = secondDayInfoObjects[indexPath.row]
    
        cell.set(object: object)
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    

}
