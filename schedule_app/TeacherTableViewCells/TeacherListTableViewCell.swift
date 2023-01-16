//
//  TeacherListTableViewCell.swift
//  schedule_app
//
//  Created by Акжан Калиматов on 16.01.2023.
//

import UIKit

class TeacherListTableViewCell: UITableViewCell {

    @IBOutlet weak var fullNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    
    func set(object:TeacherList) {
        self.fullNameLabel.text = object.fullname
    }
 

}
