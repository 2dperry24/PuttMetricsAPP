//
//  passwordResetVC.swift
//  PuttMetricsAPP
//
//  Created by User on 1/26/18.
//  Copyright © 2018 DustinPerry. All rights reserved.
//

import UIKit
import Firebase

class passwordResetVC: UIViewController {

    
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var resetPasswordBTNOutlet: UIButton!
    @IBOutlet weak var backBTNOutlet: UIButton!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let attributeString = NSMutableAttributedString(string: "Go Back",
                                                        attributes: yourAttributes)
        backBTNOutlet.setAttributedTitle(attributeString, for: .normal)
        
        resetPasswordBTNOutlet.backgroundColor = .clear
        resetPasswordBTNOutlet.layer.borderWidth = 3
        resetPasswordBTNOutlet.layer.borderColor = UIColor.white.cgColor
        
        
        view.setGradientBackground(colorOne: UIColor.flatLime(), colorTwo: UIColor.flatSkyBlue())
        discsMovingUP()

        hideKeyboard()
        // Do any additional setup after loading the view.
    }
    
    
    let yourAttributes : [NSAttributedStringKey: Any] = [
        NSAttributedStringKey.font : UIFont(name: "AvenirNext-Regular", size: 16) ?? "",
        NSAttributedStringKey.foregroundColor : UIColor.white,
        NSAttributedStringKey.underlineStyle : NSUnderlineStyle.styleSingle.rawValue]
    
    
    
    

    @IBAction func resetPasswordBTN(_ sender: UIButton) {
        
        
        if emailTF.text != "" {
             let email = emailTF.text!
             resetPassword(email: email)
        } else {
                AlertController.showAlert(self, title: "Missing Info", message: "Please provide an email to reset your password.")
                return
            }
    }
    
    func resetPassword(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
                AlertController.showAlert(self, title: "Error", message: ("There is no user record corresponding to this email address"))
            } else {
                 AlertController.showAlert(self, title: "Success", message: "An email with instructions to reset your password has been sent \(email). Thank you.")
                self.emailTF.text = ""
            }
        }
       
    }
    
    
    @IBAction func backBTNPressed(_ sender: UIButton) {
       
        dismiss(animated: true, completion: nil)
    }
    
    
    
    func discsMovingUP () {
        let emitter =  EmitterUP.get(with: #imageLiteral(resourceName: "ProdigyDisc"))
        emitter.emitterPosition = CGPoint(x: view.frame.width/2, y: view.frame.height + 100)
        emitter.emitterSize = CGSize(width: view.frame.width, height: 2)
        view.layer.insertSublayer(emitter, at: 1)
        
    }
    
   

}
