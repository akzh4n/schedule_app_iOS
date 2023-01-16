//
//  TeachersListTableViewController.swift
//  schedule_app
//
//  Created by Акжан Калиматов on 16.01.2023.
//

import UIKit
import FirebaseStorage
import Firebase
import FirebaseFirestore



class TeachersListTableViewController: UITableViewController {
    var searchController: UISearchController!
    var filteredData = [TeacherList]()
    let db = Firestore.firestore()
    var teacherListObjects = [TeacherList]()
    override func viewDidLoad() {
        super.viewDidLoad()
 
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search teachers"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        
        self.fetchTeacherListDocuments()
    }
    
    

    
    func fetchTeacherListDocuments() {
        db.collection("Teachers").getDocuments { [self] (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                for document in querySnapshot!.documents {
                    let scheduleItem = TeacherList(fullname: document.documentID)
                    self.teacherListObjects.append(scheduleItem)
                    print("Document name: \(document.documentID)")
                }
                self.filteredData = self.teacherListObjects 
                self.tableView.updateConstraints()
                self.tableView.reloadData()
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filteredData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "teacherListCell", for: indexPath) as! TeacherListTableViewCell
        
        let object = filteredData[indexPath.row]
        cell.set(object: object)
        
        
        return cell
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "teacherInfoView" {
            let destinationVC = segue.destination as! TeacherInfoViewController
            let cell = sender as! TeacherListTableViewCell
            let selectedData = cell.fullNameLabel.text
            destinationVC.teacherName = selectedData
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    
}

extension TeachersListTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
          if let searchText = searchController.searchBar.text, !searchText.isEmpty {
              filteredData = teacherListObjects.filter { teacher in
                  return teacher.fullname.contains(searchText)
              }
          } else {
              filteredData = teacherListObjects
          }
          tableView.reloadData()
      }
}
