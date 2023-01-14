//
//  TeacherTableViewCell.swift
//  schedule_app
//
//  Created by Акжан Калиматов on 14.01.2023.
//

import UIKit

class TeacherTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var jobTypeLabel: UILabel!
    
    @IBOutlet weak var jobStartTimeLabel: UILabel!
    
    @IBOutlet weak var jobEndTimeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    func set(object: TeacherTableInfoModel) {
        for jobType in object.jobType {
            self.jobTypeLabel.text = jobType
        }
        for jobStartTime in object.jobStartTime {
            self.jobStartTimeLabel.text = jobStartTime
        }
        for jobEndTime in object.jobEndTime {
            self.jobEndTimeLabel.text = jobEndTime
        }
    }

   

}
