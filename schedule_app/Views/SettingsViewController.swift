//
//  SettingsViewController.swift
//  schedule_app
//
//  Created by Акжан Калиматов on 18.01.2023.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseFirestore

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var logOutBtn: UIButton!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.logOutBtn.layer.cornerRadius = 10
        self.fetchAllData()
    }
    
    func fetchAllData() {
        let db = Firestore.firestore()
        let userID = Auth.auth().currentUser?.uid
        if userID != nil {
            db.collection("Users").document(userID!).getDocument { [self] snapshot, error in
                if error != nil {
                    print("Error")
                }
                else {
                    let data = snapshot!.data()
                    
                    let fullNameData = data!["fullname"] as! String
                    let emailData = data!["email"] as! String
                    let roleData = data!["role"] as! String
                    
                    
                    self.userLabel.text = fullNameData
                    self.emailLabel.text = emailData
                    self.roleLabel.text = roleData
                    
                }
                
            }
            
        }
    }
    
    @IBAction func logOutBtnTapped(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            self.goToStartView()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    
    func goToStartView() {
        let mainVC = storyboard?.instantiateViewController(withIdentifier: "mainVC") as? MainViewController
        view.window?.rootViewController = mainVC
        view.window?.makeKeyAndVisible()
    }
    
}
