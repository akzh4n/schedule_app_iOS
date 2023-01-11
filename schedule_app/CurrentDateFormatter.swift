//
//  CurrentDateFormatter.swift
//  schedule_app
//
//  Created by Акжан Калиматов on 09.01.2023.
//

import Foundation
import UIKit






class CurrentDateFormatter {
    
    func setCurrentData(currentDateInt: Int) -> String {
        let currentDate = Date()

        // Get the calendar
        let calendar = Calendar.current

        // Add one day to the current date
        let nextDay = calendar.date(byAdding: .day, value: currentDateInt, to: currentDate)

        // Create a date formatter
        let dateFormatter = DateFormatter()

        // Set the date format for the day
        dateFormatter.dateFormat = "EEEE"
        dateFormatter.locale = Locale(identifier: "en_US")

        // Get the day as a string
        let dayString = dateFormatter.string(from: nextDay!).localizedCapitalized
        

        // Print the day
        return dayString
    }
    
    
    func setCurrentDataNumber(currentDateInt: Int) -> String {
        let currentDate = Date()

        // Get the calendar
        let calendar = Calendar.current

        // Add one day to the current date
        let nextDay = calendar.date(byAdding: .day, value: currentDateInt, to: currentDate)

        // Create a date formatter
        let dateFormatter = DateFormatter()

        // Set the date format for the day
        dateFormatter.dateFormat = "DD.MM"
        dateFormatter.locale = Locale(identifier: "en_US")

        // Get the day as a string
        let dayString = dateFormatter.string(from: nextDay!).localizedCapitalized
        

        // Print the day
        return dayString
    }
    
    
    
    
}
