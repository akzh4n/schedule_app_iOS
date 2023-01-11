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
        for subject in object.subject {
            self.subjectLabel.text = subject
        }
        for teacher in object.teacher {
            self.teacherLabel.text = teacher
        }
        for place in object.place {
            self.placeLabel.text = place
        }
        for lesson in object.lessonType {
            self.lessonTypeLabel.text = lesson
            self.setColorToView()
        }
        for firstTime in object.firstTime {
            self.firstTimeLabel.text = firstTime
        }
        for secondTime in object.secondTime {
            self.secondTimeLabel.text = secondTime
        }
    
        
    }
    
    func setColorToView() {
        if lessonTypeLabel.text == "Lecture" {
            lineView.backgroundColor = .blue
        } else if lessonTypeLabel.text == "Practice"{
            lineView.backgroundColor = .systemGreen
        }
    }

}
