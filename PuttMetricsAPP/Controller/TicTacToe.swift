//
//  TicTacToe.swift
//  PuttMetricsAPP
//
//  Created by User on 1/9/18.
//  Copyright © 2018 DustinPerry. All rights reserved.
//

import UIKit

class TicTacToe: UIViewController {

    @IBOutlet weak var gridImage: UIImageView!
    @IBOutlet weak var gridHeightConstraint: NSLayoutConstraint!
    @IBOutlet var BTN1: [UIButton]!
    
    
    
    
    
    
    
    
    
    
    
    
    
    private var lowerBound = 10
    private var uppeerBound = 50
    
    private var activePlayer = 1 //Cross
    
    var gameState = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      gridHeightConstraint.constant = view.frame.width - 10
        
        setDistanceLabels()
        
        print("height: \(gridHeightConstraint.constant)")
        print("frame width: \(gridImage.frame.width)")
        print("gamestatecount: \(gameState.count)")
      
        
        
        
    }


    
    @IBAction func BTNPressed(_ sender: UIButton) {
        
        if (gameState[sender.tag - 1] == 0) {
            gameState[sender.tag - 1] = activePlayer
            
            if (activePlayer == 1) {
                sender.setBackgroundImage(UIImage(named:"Cross"), for: UIControlState())
                sender.setTitle("", for: UIControlState())
                activePlayer = 2
            } else {
                sender.setBackgroundImage(UIImage(named:"Nought"), for: UIControlState())
                 sender.setTitle("", for: UIControlState())
                activePlayer = 1
                
            }
            
        }
        
        
        print("tag: \(sender.tag)")
    }
    
    
    
   // generates random number to be placed as button titles
    
    func random(_ range:Range<Int>) -> Int
    {
        return range.lowerBound + Int(arc4random_uniform(UInt32(range.upperBound - range.lowerBound)))
    }
    
  
    
    // TODO: lowerbound and upperbound values need to be passed in from pickerView or other source.
    func setDistanceLabels(){
        
        for num in BTN1.indices {
            let distance = arc4random()
            BTN1[num].setTitle("\(random(lowerBound..<uppeerBound))'", for: UIControlState())
            BTN1[num].setTitleColor(UIColor.darkGray, for: UIControlState())
            BTN1[num].titleLabel?.font = UIFont(name: "Avenir-Medium", size: 12)
        }
    }


}
