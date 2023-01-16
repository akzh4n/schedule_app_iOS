//
//  TeacherInfoViewController.swift
//  schedule_app
//
//  Created by Акжан Калиматов on 14.01.2023.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseFirestore

class TeacherInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    
    
    var db = Firestore.firestore()
    var teacherName: String?
    var teacherInfoTableObjects = [TeacherTableInfoModel]()

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var professionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var teacherInfoTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        teacherInfoTableView.delegate = self
        teacherInfoTableView.dataSource = self
      
        self.nameLabel.text = teacherName
        self.fetchTeacherData(teacherName: nameLabel.text!)
    }
    
    
    
    func fetchTeacherData(teacherName: String) {
           db.collection("Teachers").document(teacherName).getDocument { [self] snapshot, error in
               if error != nil {
                   print("Error")
               }
               else {
                  
                   
                   let data = snapshot!.data()
                   print(data)
                   
                   
                   let professionData = data!["profession"] as! String
                   self.professionLabel.text = professionData
                   
                   let nameData = data!["name"] as! String
                   self.nameLabel.text = nameData
                   
                   
                   let emailData = data!["email"] as! String
                   self.emailLabel.text = emailData
                   
                   
                   
                   
                   let jobTypeArray = data!["jobType"] as! [String]
                   let jobStartTimeArray = data!["jobStartTime"] as! [String]
                   let jobEndTimeArray = data!["jobEndTime"] as! [String]
                   
                  
                
                   
                 
                   for i in 0..<jobTypeArray.count {
                       let teacherScheduleItem = TeacherTableInfoModel(jobType: [jobTypeArray[i]], jobStartTime: [jobStartTimeArray[i]], jobEndTime: [jobEndTimeArray[i]])
                       self.teacherInfoTableObjects.append(teacherScheduleItem)

                   }
                   
                   
                   let imageData = data!["image"] as! String
                   let path = "teachersImage/\(imageData)"
                   let reference = Storage.storage().reference(withPath: path)

                   reference.getData(maxSize: (1 * 1024 * 1024)) { (data, error) in
                           if let err = error {
                              print(err)
                         } else {
                           if let image  = data {
                                let myImage: UIImage! = UIImage(data: image)

                               self.imageView.image = myImage
                           }
                        }
                   }
                   
                   
                 
                   teacherInfoTableView.updateConstraints()
                   teacherInfoTableView.reloadData()
                   print(teacherInfoTableObjects)
               }
           }
       }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teacherInfoTableObjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "teacherInfoCell", for: indexPath) as! TeacherTableViewCell
        let object = teacherInfoTableObjects[indexPath.row]
    
        cell.set(object: object)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
  

}
