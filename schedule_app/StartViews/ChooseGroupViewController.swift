//
//  ChooseGroupViewController.swift
//  schedule_app
//
//  Created by Акжан Калиматов on 18.01.2023.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class ChooseGroupViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let names = [String](arrayLiteral: "SE-2109", "SE-2110", "SE-2111", "SE-2112")
    
    var selectedData: String?
    
    var firstViewController: ScheduleViewController?
    
    
    @IBOutlet weak var okBtn: UIButton!
    
    @IBOutlet weak var pickerView: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        okBtn.layer.cornerRadius = 10
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    
    func setDataToFirebase() {
        let userID = Auth.auth().currentUser?.uid 
        let collectionRef = Firestore.firestore().collection("Users")
 
        let documentRef = collectionRef.document(userID!)
        documentRef.updateData(["group": selectedData!])

        
    }
    
    
    
    @IBAction func okBtnTapped(_ sender: Any) {
        self.setDataToFirebase()
        self.goToNextView()
    }
    
    
    
    func goToNextView() {
        let homeTabBarVC = storyboard?.instantiateViewController(withIdentifier: "homeTabBarVC") as? HomeTabBarController
        view.window?.rootViewController = homeTabBarVC
        view.window?.makeKeyAndVisible()
    }
    
    
    
    // PickerView Components
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return names.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return names[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedData = names[row]
    }
    
    
    
  
    
}
