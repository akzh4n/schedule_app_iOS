//
//  MainViewController.swift
//  schedule_app
//
//  Created by Акжан Калиматов on 18.01.2023.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseStorage

class MainViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.okBtn.layer.cornerRadius = 10
        
        emailTF.delegate = self
        passwordTF.delegate = self
        setLogButton(enabled: false)
        activityView.isHidden = true
        
        emailTF.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        passwordTF.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        
        // Textfields Placeholder Settings
        
        let placeholderColor = UIColor.gray
        let placeholderStringEmail = NSAttributedString(string: "ex: 211323@astanait.edu.kz", attributes: [NSAttributedString.Key.foregroundColor: placeholderColor])
        let placeholderStringPassword = NSAttributedString(string: "ex: 12345678", attributes: [NSAttributedString.Key.foregroundColor: placeholderColor])
        emailTF.attributedPlaceholder = placeholderStringEmail
        passwordTF.attributedPlaceholder = placeholderStringPassword

        
        // To remove keyboard by tapping view
        
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        
    }
    
    // Keyboard settings to hide and show
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardWillShow(sender:)),
            name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    


    
    
    
    // Special code to automatically resizing view with keyboard
    @objc func keyboardWillShow(sender: NSNotification) {
        guard let userInfo = sender.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextField = UIResponder.currentFirst() as? UITextField else { return }
        
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        let convertedTextFieldFrame = view.convert(currentTextField.frame, from: currentTextField.superview)
        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height
        
        // if textField bottom is below keyboard bottom - bump the frame up
        if textFieldBottomY > keyboardTopY {
            let textBoxY = convertedTextFieldFrame.origin.y
            let newFrameY = (textBoxY - keyboardTopY / 2) * -1
            view.frame.origin.y = newFrameY
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
    }
    
    
    
    
    // Function to access the button after filling in the textfields
    
    @objc func textFieldChanged(_ target:UITextField) {
        let email = emailTF.text
        let password = passwordTF.text
        
        let formFilled = email != nil && email != "" && password != nil && password != ""
        setLogButton(enabled: formFilled)
    }
    
   
    
    func setLogButton(enabled:Bool) {
        if enabled {
            okBtn.alpha = 1
            okBtn.isEnabled = true
        } else {
            okBtn.alpha = 0.5
            okBtn.isEnabled = false
        }
    }
    
    
    
    
    // Login process
    
    func loginCheck() {
        let email = emailTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if error != nil {
                // Couldn't sign in
                self.showAlert(with: "Error", and: "The user doesn`t exist")
                self.setLogButton(enabled: true)
                self.activityView.isHidden = true
                self.activityView.stopAnimating()
                
            }
            else {
                
                self.goToNextView()
            }
        }
    }
    
    
    @IBAction func okBtnTapped(_ sender: Any) {
        
        setLogButton(enabled: false)
        activityView.isHidden = false
        activityView.startAnimating()
        
        self.loginCheck()
        
    }
    
    
    func goToNextView() {
        let chooseGroupVC = storyboard?.instantiateViewController(withIdentifier: "chooseGroupVC") as? ChooseGroupViewController
        
        view.window?.rootViewController = chooseGroupVC
        view.window?.makeKeyAndVisible()
    }
    
}
