//
//  AlertExtension.swift
//  schedule_app
//
//  Created by Акжан Калиматов on 19.01.2023.
//

import Foundation
import UIKit



extension UIViewController {
    func showAlert(with title: String, and message: String, completion: @escaping () -> Void = { }) {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
                completion()
            }
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
    }
}
