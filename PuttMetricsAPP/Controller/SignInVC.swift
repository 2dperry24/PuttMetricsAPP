//
//  SignInVC.swift
//  PuttMetricsAPP
//
//  Created by User on 1/23/18.
//  Copyright © 2018 DustinPerry. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit
//import FBSDKCoreKit

class SignInVC: UIViewController {
     var dict : [String : AnyObject]!
    
    
   
    @IBOutlet weak var userEmailTF: UITextField!
    @IBOutlet weak var userPassWordTF: UITextField!
    @IBOutlet weak var signUpBTN: ToggleButton!
    
    
    @IBOutlet weak var resetPasswordBTN: UIButton!
    
    @IBOutlet weak var logInBTNOutlet: UIButton!
    @IBAction func logInBTN(_ sender: Any) {
    }
    @IBAction func resetPasswordBTN(_ sender: UIButton) {
    }
    
    
    
    let yourAttributes : [NSAttributedStringKey: Any] = [
        NSAttributedStringKey.font : UIFont(name: "AvenirNext-Regular", size: 16) ?? "",
        NSAttributedStringKey.foregroundColor : UIColor.white,
        NSAttributedStringKey.underlineStyle : NSUnderlineStyle.styleSingle.rawValue]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
       // discsMovingUP()
        discsMovingDown()
        view.setGradientBackground(colorOne: UIColor.flatLime(), colorTwo: UIColor.flatSkyBlue())
        
        let attributeString = NSMutableAttributedString(string: "Create new account with email",
                                                        attributes: yourAttributes)
        logInBTNOutlet.setAttributedTitle(attributeString, for: .normal)
        
        signUpBTN.backgroundColor = UIColor.clear
        signUpBTN.layer.borderColor = UIColor.white.cgColor
        signUpBTN.layer.borderWidth = 3
        
        resetPasswordBTN.backgroundColor = UIColor.clear
        resetPasswordBTN.layer.borderColor = UIColor.white.cgColor
        resetPasswordBTN.layer.borderWidth = 3
        
        
        
        //If there is a logged in user, by pass this screen and go straight to ChatViewController
        
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if Auth.auth().currentUser != nil {
                 self.performSegue(withIdentifier: "signInSegue", sender: self)
                print("user was already signed in")
            } else {
                print("user isn't currently signed in")
            }
        }
    
       self.hideKeyboard()

        
        //add our custom fb login button here
        let customFBButton = UIButton(type: .system)
        customFBButton.backgroundColor = .clear
        customFBButton.frame = CGRect(x: 16, y: 50, width: view.frame.width - 32, height: 50)
        customFBButton.setTitle("Sign In with FaceBook", for: .normal)
        customFBButton.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 18)
        customFBButton.setTitleColor(.white, for: .normal)
        customFBButton.layer.borderWidth = 3
        customFBButton.layer.borderColor = UIColor.white.cgColor
        view.addSubview(customFBButton)

        customFBButton.addTarget(self, action: #selector(handleCustomFBLogin), for: .touchUpInside)
    }

    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
 
    
    
    
    
    
    

    @objc func handleCustomFBLogin() {
        FBSDKLoginManager().logIn(withReadPermissions: ["email", "public_profile"], from: self) { (result, err) in
            if err != nil {
                print("Custom FB Login failed:", err ?? "")
                return
            }

            self.showEmailAddress()
        }
    }

    
    @IBAction func signInBTNTapped(_ sender: UIButton) {
        guard let email = userEmailTF.text,
            email != "",
            let password = userPassWordTF.text,
            password != ""
            else {
                AlertController.showAlert(self, title: "Missing Info", message: "Please fill out all required fields")
                return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            guard error == nil else {
                AlertController.showAlert(self, title: "Error", message: error!.localizedDescription)
                return
            }
            guard let user = user else {return}
            print(user.email ?? "Missing Email")
            print(user.displayName ?? "Missing display name")
            print(user.uid)
            
            self.performSegue(withIdentifier: "signInSegue", sender: self)
            
        }
    }
    


    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did log out of facebook")
    }

    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        }

        print("Successfully logged in with facebook...")
        showEmailAddress()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    func showEmailAddress() {
        let accessToken = FBSDKAccessToken.current()
        guard let accessTokenString = accessToken?.tokenString else { return }

        let credentials = FacebookAuthProvider.credential(withAccessToken: accessTokenString)
        Auth.auth().signIn(with: credentials, completion: { (user, error) in
            if error != nil {
                print("Something went wrong with our FB user: ", error ?? "")
                return
            }

            print("Successfully logged in with our user: ", user ?? "")
        })

        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"]).start { (connection, result, err) in

            if err != nil {
                print("Failed to start graph request:", err ?? "")
                return
            }
            print(result ?? "")
        }
        
        
    }
        
        
        
    


    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true;
    }
    
    
    func discsMovingUP () {
        let emitter =  EmitterUP.get(with: #imageLiteral(resourceName: "ProdigyDisc"))
        emitter.emitterPosition = CGPoint(x: view.frame.width/2, y: view.frame.height + 100)
        emitter.emitterSize = CGSize(width: view.frame.width, height: 2)
        view.layer.insertSublayer(emitter, at: 0)
        
    }
    func discsMovingDown () {
        let emitter =  EmitterDown.get(with: #imageLiteral(resourceName: "ProdigyDisc"))
        emitter.emitterPosition = CGPoint(x: view.frame.width/2, y: 0 - 100)
        emitter.emitterSize = CGSize(width: view.frame.width, height: 2)
        view.layer.insertSublayer(emitter, at: 0)
        
    }
    



}





extension UIViewController
{
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(SignInVC.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}



