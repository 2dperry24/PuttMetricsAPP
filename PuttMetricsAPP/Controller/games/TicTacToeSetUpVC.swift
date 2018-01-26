//
//  TicTacToeSetUpVC.swift
//  PuttMetricsAPP
//
//  Created by User on 1/13/18.
//  Copyright © 2018 DustinPerry. All rights reserved.
//

import UIKit

class TicTacToeSetUpVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    

    @IBOutlet weak var firstPickerViewLabel: UILabel!
    @IBOutlet weak var secondPickerViewLabel: UILabel!
    @IBOutlet weak var twoPhoneLabel: UILabel!
    
    @IBOutlet weak var descriptionOutlet: UILabel!
    @IBOutlet weak var onePhoneImageView: UIImageView!
    @IBOutlet weak var twoPhonesImageView: UIImageView!
    @IBOutlet weak var swtichNumberOfPhoneSelectionOutlet: UISwitch!
    @IBAction func swithNumberOfPhonesSelection(_ sender: UISwitch) {
        if sender.isOn == false {
            descriptionOutlet.text = "Play using one device. \n Select the lowest distance and the maximum distance that will be generated for your board."
            twoPhonesImageView.alpha = 0.4
            onePhoneImageView.alpha = 1.0
            firstPickerView.isHidden = false
            twoPhoneLabel.isHidden = true
            firstPickerViewLabel.isHidden = false
            secondPickerViewLabel.isHidden = false
            secondPickerView.isHidden = true
 
            
        } else {
            descriptionOutlet.text = "Play using two devices. Both devices must have the app installed and both must select the same parameters on this screen prior to entering the game. Connection between devices takes place on next screen."
            onePhoneImageView.alpha = 0.4
            twoPhonesImageView.alpha = 1.0
            firstPickerView.isHidden = true
            twoPhoneLabel.isHidden = false
            twoPhoneLabel.text = "Select equal level on both devices"
            firstPickerViewLabel.isHidden = true
            secondPickerViewLabel.isHidden = true
            secondPickerView.isHidden = false
            
          
        }
        
    }
    
    @IBOutlet weak var firstPickerView: UIPickerView!
    @IBOutlet weak var secondPickerView: UIPickerView!
    
    @IBOutlet weak var enterGameBTN: UIButton!
  
    
    private var mutliplayerLevels : [[Int]] = [
       // 1 - level 1
        [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10],
        [15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15],
        [20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20],
        [25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25, 25],
        [30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30],
        [35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35],
        [40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40],
        [45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45],
        [50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50],
        
        
        
        [30, 20, 30, 20, 30, 20, 30, 20, 30, 20, 30, 20, 30, 20, 30, 20, 30, 20, 30, 20, 30, 20, 30, 20, 30, 20, 30, 20, 30, 20, 30, 20, 30, 20, 30, 20],
        [35, 20, 35, 20, 35, 20, 35, 20, 35, 20, 35, 20, 35, 20, 35, 20, 35, 20, 35, 20, 35, 20, 35, 20, 35, 20, 35, 20, 35, 20, 35, 20, 35, 20, 35, 20],
        
        
        //random 15-50
        [35, 46, 39, 30, 45, 15, 21, 29, 30, 37, 49, 23, 47, 39, 46, 36, 27, 26, 28, 31, 20, 36, 22, 18, 24, 37, 23, 28, 41, 48, 19, 39, 39, 47, 20, 45],
        [15, 33, 24, 49, 31, 36, 20, 48, 27, 17, 15, 49, 33, 24, 17, 49, 26, 48, 17, 49, 33, 48, 28, 28, 34, 41, 25, 36, 43, 23, 27, 39, 33, 45, 39, 45],

        [
            30,35,30,35,30,35,
            35,20,20,20,20,30,
            30,20,15,15,20,35,
            35,20,15,15,20,30,
            30,20,20,20,20,35,
            35,30,35,30,35,30
        ],
        
        
    ]
    
    
    private var multiplayerLevelsTitles : [String] = [
        // 1 - level 1
        "1 - All 10 Footers",
        "2 - All 15 Footers",
        "3 - All 20 Footers",
        "4 - All 25 Footers",
        "5 - All 30 Footers",
        "6 - All 35 Footers",
        "7 - All 40 Footers",
        "8 - All 45 Footers",
        "9 - All 50 Footers",
        "10 - 20'/30' Columns",
        "10 - 20'/35' Columns",
        "11 - 15'-50' Random Ver.1",
        "12 - 15'-50' Random Ver.2",
        
        
        
        
        "L1 15' - 35' OuterRing Is Longer",
    
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enterGameBTN.layer.cornerRadius = enterGameBTN.layer.frame.height / 2
        firstPickerView.delegate = self
        firstPickerView.dataSource = self
        secondPickerView.delegate = self
        secondPickerView.dataSource = self
        secondPickerView.isHidden = true
        
        
        swtichNumberOfPhoneSelectionOutlet.tintColor = UIColor.lightGray
        swtichNumberOfPhoneSelectionOutlet.onTintColor = UIColor.lightGray
        swtichNumberOfPhoneSelectionOutlet.thumbTintColor = UIColor.flatOrange()
        twoPhonesImageView.alpha = 0.4
          descriptionOutlet.text = "Play using one device. \n Select the lowest distance and the maximum distance that will be generated for your board."
        firstPickerViewLabel.text = "Minimum"
        secondPickerViewLabel.text = "Maximum"
        
        
        firstPickerView.selectRow(1, inComponent: 0, animated: true)
        firstPickerView.selectRow(7, inComponent: 1, animated: true)
        twoPhoneLabel.isHidden = true
     
    }

    
    var minValue = 15
    var maxValue = 45
   
    var multiplayerLevelSelected = [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10]

    let distancesForPickerView = [10,15,20,25,30,35,40,45,50]
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       if pickerView.tag == 0 {
                return 2
        } else  {
                print("returning 1")
                return 1
        
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 {
                if component == 0 {
                    return distancesForPickerView.count
                } else {
                        print("distanceforPickerview.count: \(distancesForPickerView.count)")
                     return distancesForPickerView.count
                
                }
       
        } else {
                print("multiplayerlEvel.count: \(mutliplayerLevels.count)")
                return mutliplayerLevels.count
          
            
        }
    
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0 {
                if component == 0 {
                    minValue = distancesForPickerView[row]
                    print("Min: \(minValue)")
                } else {
                    maxValue = distancesForPickerView[row]
                    print("Max: \(maxValue)")
                }
        } else {
                multiplayerLevelSelected = mutliplayerLevels[row]
                print("mulitplayerArraySelected: \(multiplayerLevelSelected)")
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
         if pickerView.tag == 0 {
                if component == 0 {
                    return "\(distancesForPickerView[row])'"
                } else {
                    return "\(distancesForPickerView[row])'"
                }
            
         } else {
               return "\(multiplayerLevelsTitles[row])"
         }
        
        
      
        
    }
    
    @IBAction func enterGameButton(_ sender: UIButton) {
        
       
        if minValue > maxValue && swtichNumberOfPhoneSelectionOutlet.isOn == false {
                let alert = UIAlertController(title: "OH SNAP!", message: "Min needs to be less or equal to the Max", preferredStyle: UIAlertControllerStyle.actionSheet)
                let titleFont = [NSAttributedStringKey.font: UIFont(name: "AvenirNext-DemiBold", size: 18.0)!]
                let titleAttrString = NSMutableAttributedString(string: "OH SNAP!", attributes: titleFont)
                alert.setValue(titleAttrString, forKey: "attributedTitle")
                alert.view.alpha = 0.95
                // Creating one button
                alert.addAction(UIAlertAction(title: "Go back", style: UIAlertActionStyle.default, handler: { (action) in
                    alert.dismiss(animated: true, completion: nil)
                }))
                self.present(alert, animated: true, completion: nil)
            
        } else {
            
                performSegue(withIdentifier: "sendToTicTacToe" , sender: self)
        
        }
        
        
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sendToTicTacToe" {
            let secondVC = segue.destination as! TicTacToe

            if swtichNumberOfPhoneSelectionOutlet.isOn == false {
                
                    secondVC.tempPlayerMode = "singlePlayer"
                    secondVC.tempMin = minValue
                    secondVC.tempMax = maxValue
                    print("min value sent: \(minValue) , maxValue sent: \(maxValue)")
            } else {
                    secondVC.tempPlayerMode = "multi-Player"
                    secondVC.tempArray = multiplayerLevelSelected
                    print("array sent over is: \(multiplayerLevelSelected)")
            }
            
        } else {
            print("Player Profile not sent to puttOfWar VC")
        }
    }
    
    
    }
    
    
    
    
    


