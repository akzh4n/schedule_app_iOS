//
//  DayTableViewCell.swift
//  schedule_app
//
//  Created by Акжан Калиматов on 02.01.2023.
//

import UIKit
import Firebase
import FirebaseStorage

class DayTableViewCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource {
    
    let db = Firestore.firestore()
    let date = Date()
    let formatter = DateFormatter()
  
    
    
    
    var dayObjects = [
        CurrentDateFormatter().setCurrentData(currentDateInt: 0),
        CurrentDateFormatter().setCurrentData(currentDateInt: 1),
        CurrentDateFormatter().setCurrentData(currentDateInt: 2)
        ]
                      
    

    var dayInfo = [DayModel]()
    var dayInfoObjects = [DayInfoModel]()
    @IBOutlet weak var dayInfoTableView: UITableView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weekDayLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dayInfoTableView.delegate = self
        dayInfoTableView.dataSource = self
        
       
        fetchData(dayWeek: dayObjects[0])
    }
    

    
    func fetchData(dayWeek: String) {
        db.collection("SE-2109").document(dayWeek).getDocument { [self] snapshot, error in
            if error != nil {
                print("Error")
            }
            else {
                print(snapshot!.data())
                
                let data = snapshot!.data()
                let teacherArray = data!["teacher"] as! [String]
                let subjectArray = data!["subject"] as! [String]
                let placeArray = data!["place"] as! [String]
                let lessonTypeArray = data!["type"] as! [String]
                let firstTimeArray = data!["startTime"] as! [String]
                let secondTimeArray = data!["endTime"] as! [String]
                
                for i in 0..<teacherArray.count {
                    let scheduleItem = DayInfoModel(teacher: [teacherArray[i]], subject: [subjectArray[i]], place: [placeArray[i]], lessonType: [lessonTypeArray[i]], firstTime: [firstTimeArray[i]], secondTime: [secondTimeArray[i]])
                    self.dayInfoObjects.append(scheduleItem)
                }
                print(dayInfoObjects)
                dayInfoTableView.updateConstraints()
                dayInfoTableView.reloadData()
            }
        }
    }
    
    
    func set(object: DayModel) {
        self.dateLabel.text = object.date
        self.weekDayLabel.text = object.weekDay
    }
    
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//           switch section {
//           case 0:
//               return "Monday"
//           case 1:
//               return "Tuesday"
//           case 2:
//               return "Wednesday"
//           case 3:
//               return "Thursday"
//           case 4:
//               return "Friday"
//           default:
//               return ""
//           }
//       }
//    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 4
//    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dayInfoObjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dayInfoCell", for: indexPath) as! DayInfoTableViewCell
        let object = dayInfoObjects[indexPath.row]
        print(object)
        cell.set(object: object)
        
        return cell
        
    }
    
}
