//
//  signOutVC.swift
//  PuttMetricsAPP
//
//  Created by User on 1/23/18.
//  Copyright © 2018 DustinPerry. All rights reserved.
//

import UIKit
import Firebase

class signOutVC: UIViewController {

    
    @IBOutlet weak var label: UILabel!
    
    
    @IBAction func signOutBTNTapped(_ sender: Any) {
        do {
          try Auth.auth().signOut()
            performSegue(withIdentifier: "signOutSegue", sender: nil)
            
        } catch {
            print(error)
        }
        
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let username = Auth.auth().currentUser?.displayName else {
            print("couldn't get userName")
            return
        }
       
        label.text = "hello \(username)"
      
    }

   


}
