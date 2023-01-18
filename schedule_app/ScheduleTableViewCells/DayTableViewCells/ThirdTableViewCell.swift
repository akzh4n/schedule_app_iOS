//
//  ThirdTableViewCell.swift
//  schedule_app
//
//  Created by Акжан Калиматов on 11.01.2023.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseFirestore


class ThirdTableViewCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource {
   
    

    let db = Firestore.firestore()
    var groupValue: String?
    
    @IBOutlet weak var thirdDayInfoTableView: UITableView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weekDayLabel: UILabel!

    
    var currentDay = CurrentDateFormatter().setCurrentData(currentDateInt: 2)
    var thirdDayInfoObjects = [DayInfoModel]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        thirdDayInfoTableView.delegate = self
        thirdDayInfoTableView.dataSource = self
        thirdDayInfoTableView.register(UITableViewCell.self, forCellReuseIdentifier: "defaultCell")
        weekDayLabel.text = CurrentDateFormatter().setCurrentData(currentDateInt: 2)
        dateLabel.text = CurrentDateFormatter().setCurrentDataNumber(currentDateInt: 2)
        
        self.fetchAllData()
        
    }
    
    func fetchAllData() {
        let userID = Auth.auth().currentUser?.uid
        if userID != nil {
            db.collection("Users").document(userID!).getDocument { [self] snapshot, error in
                if error != nil {
                    print("Error")
                }
                else {
                    let data = snapshot!.data()
                    let groupData = data!["group"] as! String
                    self.groupValue = groupData
                    
                    if currentDay == "Saturday" {
                        self.loadErrorLabel()
                    } else if currentDay == "Sunday" {
                        self.loadErrorLabel()
                    } else {
                        fetchData(groupValue: groupValue!, dayWeek: currentDay)
                    }
                }
                
            }
            
        }
    }
    
    
    func loadErrorLabel() {
        
        let message = UILabel()
        
        message.tintColor = .black
        message.translatesAutoresizingMaskIntoConstraints = false
        message.font = UIFont(name: "Montserrat-Semibold", size: 18)
        message.text = "There are no lessons"
        message.textAlignment = .center
        thirdDayInfoTableView.addSubview(message)
        
        let marginGuide = thirdDayInfoTableView.layoutMarginsGuide
        NSLayoutConstraint.activate([
            message.topAnchor.constraint(equalTo: marginGuide.topAnchor, constant: 20),
            message.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor),
            message.heightAnchor.constraint(equalToConstant: 100),
            message.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor)
        ])
    }
    
    func fetchData(groupValue: String, dayWeek: String) {
        
           db.collection(groupValue).document(dayWeek).getDocument { [self] snapshot, error in
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
                       let scheduleItem = DayInfoModel(teacher: teacherArray[i], subject: subjectArray[i], place: placeArray[i], lessonType: lessonTypeArray[i], firstTime: firstTimeArray[i], secondTime: secondTimeArray[i])
                       self.thirdDayInfoObjects.append(scheduleItem)

                   }
                   
                   
                 
                   thirdDayInfoTableView.updateConstraints()
                   thirdDayInfoTableView.reloadData()
               }
           }
       }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return thirdDayInfoObjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "thirdDayInfoCell", for: indexPath) as! ThirdDayTableViewCell
        let object = thirdDayInfoObjects[indexPath.row]
    
        cell.set(object: object)
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    

}
