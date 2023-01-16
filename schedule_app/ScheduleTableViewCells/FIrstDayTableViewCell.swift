//
//  FIrstDayTableViewCell.swift
//  schedule_app
//
//  Created by Акжан Калиматов on 11.01.2023.
//

import UIKit

class FIrstDayTableViewCell: UITableViewCell {

    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var teacherLabel: UILabel!
    @IBOutlet weak var firstTimeLabel: UILabel!
    
    @IBOutlet weak var placeLabel: UILabel!
    
    @IBOutlet weak var lessonTypeLabel: UILabel!
    @IBOutlet weak var secondTimeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
   
    }

    
    func set(object: DayInfoModel) {
        self.subjectLabel.text = object.subject
        
        self.teacherLabel.text = object.teacher
        
        self.placeLabel.text = object.place
        
        self.lessonTypeLabel.text = object.lessonType
        self.setColorToView()
        
        self.firstTimeLabel.text = object.firstTime
        
        self.secondTimeLabel.text = object.secondTime
        
    }
    
    func setColorToView() {
        if lessonTypeLabel.text == "Lecture" {
            lineView.backgroundColor = .systemBlue
        } else if lessonTypeLabel.text == "Practice"{
            lineView.backgroundColor = .systemGreen
        }
    }

}

