//
//  AdminHomeController.swift
//  hbcumade
//
//  Created by Vijay Rathore on 13/07/21.
//

import UIKit

class AdminHomeController: UIViewController {
    
    @IBOutlet weak var manageWaitlistView: UIView!
    
    @IBOutlet weak var sendPushNotificationView: UIView!
    @IBOutlet weak var manageSchoolNamesView: UIView!
    @IBOutlet weak var waitListSchoolView: UIView!
    override func viewDidLoad() {
        
        manageWaitlistView.layer.cornerRadius = 4
        manageWaitlistView.dropShadow()
        manageWaitlistView.isUserInteractionEnabled = true
        manageWaitlistView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(manageWaitListBtnClicked)))
        
        
        waitListSchoolView.layer.cornerRadius = 4
        waitListSchoolView.dropShadow()
        waitListSchoolView.isUserInteractionEnabled = true
        waitListSchoolView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(manageWaitListSchoolBtnClicked)))
        
        manageSchoolNamesView.isUserInteractionEnabled = true
        manageSchoolNamesView.layer.cornerRadius = 4
        manageSchoolNamesView.dropShadow()
        manageSchoolNamesView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(manageSchoolNameBtnClicked)))
        
        
        sendPushNotificationView.isUserInteractionEnabled = true
        sendPushNotificationView.layer.cornerRadius = 4
        sendPushNotificationView.dropShadow()
        sendPushNotificationView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(sendPushNotificationsBtnClicked)))
        
    }
    
    @objc func manageSchoolNameBtnClicked(){
        performSegue(withIdentifier: "schoolsnameseg", sender: nil)
    }
    
    @objc func sendPushNotificationsBtnClicked(){
        sendPushNotification()
    }
    
    @objc func manageWaitListBtnClicked(){
        performSegue(withIdentifier: "waitlistseg", sender: nil)
    }
    
    @objc func manageWaitListSchoolBtnClicked(){
        performSegue(withIdentifier: "waitlistschoolseg", sender: nil)
    }
    
    
    @IBAction func backBtnClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
