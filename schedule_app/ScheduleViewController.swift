//
//  ScheduleViewController.swift
//  schedule_app
//
//  Created by Акжан Калиматов on 02.01.2023.
//

import UIKit

class ScheduleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
  
    @IBOutlet weak var groupLabel: UILabel!
    
    @IBOutlet weak var dayTableView: UITableView!
    
    var currendDateFormatter = CurrentDateFormatter()
    
//    var objects = [
//        DayModel(weekDay: CurrentDateFormatter().setCurrentData(currentDateInt: 0), date: CurrentDateFormatter().setCurrentDataNumber(currentDateInt: 0)),
//        DayModel(weekDay: CurrentDateFormatter().setCurrentData(currentDateInt: 1), date: CurrentDateFormatter().setCurrentDataNumber(currentDateInt: 1)),
//        DayModel(weekDay: CurrentDateFormatter().setCurrentData(currentDateInt: 2), date: CurrentDateFormatter().setCurrentDataNumber(currentDateInt: 2))
//
//    ]
    
    
    var objects = CurrentDateFormatter().getObject()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        groupLabel.layer.cornerRadius = 10
        groupLabel.clipsToBounds = true
        dayTableView.delegate = self
        dayTableView.dataSource = self
        
   
      
        
    }
    
    
  
    
    
//    
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
//        return 1
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
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


extension ScheduleViewController {
    
    func setCurrentDate(currentDate: String) -> String {
        let date = Date()
        
        let formatterCurrentDay = DateFormatter()
    
        formatterCurrentDay.dateFormat = currentDate
        formatterCurrentDay.locale = Locale(identifier: "en_US")
        
        let dayOfWeek = formatterCurrentDay.string(from: date).localizedCapitalized
        return dayOfWeek
     
    }
    
}






