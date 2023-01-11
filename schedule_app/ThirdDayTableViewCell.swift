//
//  ThirdDayTableViewCell.swift
//  schedule_app
//
//  Created by Акжан Калиматов on 11.01.2023.
//

import UIKit

class ThirdDayTableViewCell: UITableViewCell {

    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var lessonTypeLabel: UILabel!
    @IBOutlet weak var secondTimeLabel: UILabel!
    @IBOutlet weak var firstTimeLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var teacherLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
        }
        for firstTime in object.firstTime {
            self.firstTimeLabel.text = firstTime
        }
        for secondTime in object.secondTime {
            self.secondTimeLabel.text = secondTime
        }
        

        
    }

}
