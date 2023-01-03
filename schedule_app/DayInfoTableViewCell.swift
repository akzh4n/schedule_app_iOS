//
//  DayInfoTableViewCell.swift
//  schedule_app
//
//  Created by Акжан Калиматов on 02.01.2023.
//

import UIKit

class DayInfoTableViewCell: UITableViewCell {
    

    @IBOutlet weak var subjectLabel: UILabel!
    
    
    @IBOutlet weak var tacherLabel: UILabel!
    
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var lessonTypeLabel: UILabel!
    
    @IBOutlet weak var secondTimeLabel: UILabel!
    @IBOutlet weak var firstTimeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func set(object: DayInfoModel) {
        self.subjectLabel.text = object.subject
        self.tacherLabel.text = object.teacher
        self.placeLabel.text = object.place
        self.lessonTypeLabel.text = object.lessonType
        self.firstTimeLabel.text = object.firstTime
        self.secondTimeLabel.text = object.secondTime
    }
    


}
