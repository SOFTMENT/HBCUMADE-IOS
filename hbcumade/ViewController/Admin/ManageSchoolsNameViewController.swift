//
//  ManageSchoolsNameViewController.swift
//  hbcumade
//
//  Created by Apple on 16/09/21.
//

import UIKit
import Firebase

class ManageSchoolsNameViewController: UIViewController {
    
    @IBOutlet weak var no_schools_name_available: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var schools = [Schools]()
    override func viewDidLoad() {
       
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        
        getSchools()
    }
    @IBAction func backBtnClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func getSchools(){
        ProgressHUDShow(text: "")
        Firestore.firestore().collection("Schools").order(by: "name", descending: false).addSnapshotListener { snapshot, error in
            self.ProgressHUDHide()
            if error == nil {
                self.schools.removeAll()
                if let snapshot = snapshot, !snapshot.isEmpty {
                   
                    for qds in snapshot.documents {
                        if let school = try? qds.data(as: Schools.self) {
                            
                          
                            
                            self.schools.append(school)
                            
                        }
                    }
                   
                }
                print("VIJAU")
                print(self.schools.count)
              
                self.tableView.reloadData()
            }
        }
    }
    @objc func deleteSchool(value : MyTapGesture){
        let id = value.id
        ProgressHUDShow(text: "Deleting...")
        Firestore.firestore().collection("Schools").document(id).delete { error in
            self.ProgressHUDHide()
            if error == nil {
                self.showToast(message: "Deleted")
            }
        }
    }
    
    @IBAction func addSchoolNameBtnClicked(_ sender: Any) {
        let alertController = UIAlertController(title: "Add School Name", message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter School Name"
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { alert -> Void in
            let firstTextField = alertController.textFields![0] as UITextField
            if let sSchoolName = firstTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines){
                if sSchoolName.isEmpty {
                    self.showToast(message: "Enter school name")
                }
                else {
                    self.ProgressHUDShow(text: "Adding...")
                    let docRef = Firestore.firestore().collection("Schools").document()
                    docRef.setData(["name" : sSchoolName, "id" : docRef.documentID]) { error in
                        if error == nil {
                            self.ProgressHUDHide()
                            self.showToast(message: "Added")
                        }
                    }
                }
            }
            
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { (action : UIAlertAction!) -> Void in })
        
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
}



extension ManageSchoolsNameViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if schools.count > 0 {
            no_schools_name_available.isHidden = true
        }
        else {
            no_schools_name_available.isHidden = false
        }
        return schools.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "schoolsnamecell", for: indexPath) as? SchoolsNameCell {
            
            cell.mView.layer.cornerRadius = 4
            cell.mView.dropShadow()
            
            let school = schools[indexPath.row]
            cell.schoolName.text = school.name
            cell.deleteBtn.isUserInteractionEnabled = true
            let myTap = MyTapGesture(target: self, action: #selector(deleteSchool(value:)))
            myTap.id = school.id!
            cell.deleteBtn.addGestureRecognizer(myTap)
            
            return cell
        }
        return SchoolsNameCell()
    }
    
    
    
    
}
