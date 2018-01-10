//
//  ChoosePlayer_PuttOfWar.swift
//  PuttMetricsAPP
//
//  Created by User on 1/2/18.
//  Copyright © 2018 DustinPerry. All rights reserved.
//

import UIKit

class ChoosePlayer_PuttOfWar: UIViewController {

    @IBOutlet weak var guestInfoLabel: UILabel!
    @IBOutlet weak var continueAsUserBTN: UIButton!
    @IBOutlet weak var continueAsGuestBTN: UIButton!
    
    var playerProfile = ""
    override func viewDidLoad() {
        super.viewDidLoad()
       
        guestInfoLabel.text = "Continuing as a guest will allow you to play without saving the score. Your statistics will remain unchanged. "
        // configure buttons
        continueAsUserBTN.layer.cornerRadius = continueAsUserBTN.frame.height / 2
        continueAsUserBTN.backgroundColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
        continueAsUserBTN.setTitleColor(UIColor.white, for: .normal)
        
        continueAsGuestBTN.layer.cornerRadius = continueAsUserBTN.frame.height / 2
        continueAsGuestBTN.backgroundColor = UIColor.white
        continueAsGuestBTN.setTitleColor(UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1), for: .normal)
        continueAsGuestBTN.layer.borderWidth = 2
        continueAsGuestBTN.layer.borderColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1).cgColor
        
        
        
        
    }

  
    @IBAction func proceedToPuttOfWarWithSelectedProfileBTN(_ sender: UIButton) {
       
        if sender.tag == 1{
            playerProfile = "player"
        } else if sender.tag == 2{
            playerProfile = "guest"
        }
    
        performSegue(withIdentifier: "sendToPuttOfWar", sender: self)
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sendToPuttOfWar" {
            let secondVC = segue.destination as! PuttOfWar
            
            secondVC.playerProfileTemp = playerProfile
            print("playerProfile sent: \(playerProfile)")
            
        } else {
            print("Player Profile not sent to puttOfWar VC")
        }
    }
    
    
}
