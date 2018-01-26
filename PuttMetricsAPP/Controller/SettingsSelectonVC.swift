//
//  SettingsSelectonVC.swift
//  PuttMetricsAPP
//
//  Created by User on 1/18/18.
//  Copyright © 2018 DustinPerry. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit


class SettingsSelectonVC: UIViewController {

    
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var label2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let username = Auth.auth().currentUser?.displayName else {
            print("couldn't get userName")
            return
        }
        label.text = username
        
//        guard let userEmail = Auth.auth().currentUser?.email else {
//            print(debugDescription)
//            return
//        }
//        print(userEmail)
//
        guard let userEmail = Auth.auth().currentUser?.email else {
            print(debugDescription)
            return
        }
        print(userEmail)
        
        
        
        
        
    }
   

    @IBAction func signOutBTNTapped(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "signOutSegue", sender: nil)
            
        } catch {
            print(error)
        }
        
        
        
    }
    
    
    
 
    
    
}
