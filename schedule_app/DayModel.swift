//
//  DayModel.swift
//  schedule_app
//
//  Created by Акжан Калиматов on 02.01.2023.
//

import Foundation
import UIKit







struct DayModel {
    
    
    var weekDay: String
    var date: String
   
    init(weekDay: String, date: String) {
        self.weekDay = weekDay
        self.date = date
    }
  
}







struct DayInfoModel {
    var teacher: [String]
    var subject: [String]
    var place: [String]
    var lessonType: [String]
    var firstTime: [String]
    var secondTime: [String]
    
    
    

    
    
}


