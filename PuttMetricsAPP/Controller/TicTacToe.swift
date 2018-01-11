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
    @IBOutlet weak var playerHasWonLabel: UILabel!
    @IBOutlet weak var playAgainOutlet: UIButton!
    @IBOutlet weak var player1View: DesignableView!
    @IBOutlet weak var player2View: DesignableView!
    @IBOutlet weak var player1Container: DesignableView!
    @IBOutlet weak var player2Container: DesignableView!
    
   
    
    private var lowerBound = 10
    private var uppeerBound = 50
    //Player 1 is Black
    private var activePlayer = 1 {
        didSet {
            if activePlayer == 1 {
                player1Container.backgroundColor = UIColor.flatRed()
                player2Container.backgroundColor = UIColor.clear
            } else {
                player1Container.backgroundColor = UIColor.clear
                player2Container.backgroundColor = UIColor.flatBlue()
            }
        }
    }
    
    
    private var gameIsActive = true {
        didSet {
            print("gameIsActive: \(gameIsActive)")
        }
    }
    private var gameHasBeenWon = false
    private var gameState = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    private let winningCombinations = [
    // Horizontal winning combinations
       [0,1,2,3], [1,2,3,4], [2,3,4,5],
       [6,7,8,9], [7,8,9,10], [8,9,10,11],
       [12,13,14,15], [13,14,15,16], [14,15,16,17],
       [18,19,20,21], [19,20,21,22], [20,21,22,23],
       [24,25,26,27], [25,26,27,28], [26,27,28,29],
       [30,31,32,33], [31,32,33,34], [32,33,34,35],
    // Vertical winning combinations
        [0,6,12,18], [6,12,18,24], [12,18,24,30],
        [1,7,13,19], [7,13,19,25], [13,19,25,31],
        [2,8,14,20], [8,14,20,26], [14,20,26,32],
        [3,9,15,21], [9,15,21,27], [15,21,27,33],
        [4,10,16,22], [10,16,22,28], [16,22,28,34],
        [5,11,17,23], [11,17,23,29], [17,23,29,35],
    // top left to bottom right winnning combinations
        [18,13,8,3], [24,19,14,9], [19,14,9,4], [30,25,20,15],
        [25,20,15,10], [20,15,10,5], [31,26,21,16], [26,21,16,11],
        [32,27,22,17],
    // top right to bottom left winning combinations
        [12,19,26,33], [6,13,20,27], [13,20,27,34], [0,7,14,21],
        [7,14,21,28], [14,21,28,35], [1,8,15,22], [8,15,22,29],
        [2,9,16,23]
        ]
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      gridHeightConstraint.constant = view.frame.width - 10
        
        setDistanceLabels()
        
        playerHasWonLabel.isHidden = true
        playAgainOutlet.isHidden = true
        playerHasWonLabel.alpha = 1
        playAgainOutlet.alpha = 1
        player2Container.backgroundColor = UIColor.clear
        player1Container.backgroundColor = UIColor.flatRed()
        
    }


    
    @IBAction func BTNPressed(_ senderX: UIButton) {
        let puttDistance = senderX.titleLabel?.text
        var borderColor = UIColor()
        var currentPlayer = ""
        if activePlayer == 1 {
           currentPlayer = "Did Player 1 hit the \(puttDistance!) putt?"
            borderColor = UIColor.flatRed()
        } else {
           currentPlayer = "Did Player 2 hit the \(puttDistance!) putt?"
           borderColor = UIColor.flatBlue()
        }
        
        senderX.layer.borderWidth = 4
        senderX.layer.borderColor = borderColor.cgColor
        
        
        sendAlert(title: currentPlayer , message: nil, sender: senderX)
       
       
     
        
                
    }
    
    
    
    func sendAlert(title: String, message: String?, sender: UIButton) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let titleFont = [NSAttributedStringKey.font: UIFont(name: "AvenirNext-DemiBold", size: 18.0)!]
        let titleAttrString = NSMutableAttributedString(string: title, attributes: titleFont)
        alert.setValue(titleAttrString, forKey: "attributedTitle")
        alert.view.alpha = 0.95
        

      
        // Creating one button
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            self.placeMarkForPlayer(sender: sender)
            sender.layer.borderWidth = 0
            print("BorderWidthSet: 0")
        }))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            if self.activePlayer == 1 {
                self.activePlayer = 2
            } else {
                self.activePlayer = 1
            }
             sender.layer.borderWidth = 0
        }))
        alert.addAction(UIAlertAction(title: "Re-pick spot", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
             sender.layer.borderWidth = 0
            print("Position on board was canceled")
        }))
        self.present(alert, animated: true, completion: nil)
      
      
    }
    
    
    
    
    
    
    
    func placeMarkForPlayer(sender: UIButton) {
        
        
        if (gameState[sender.tag - 1] == 0) && gameIsActive == true {
            gameState[sender.tag - 1] = activePlayer
            
            if (activePlayer == 1) {
                sender.setBackgroundImage(UIImage(named:"cross_black"), for: UIControlState())
                sender.setTitle("", for: UIControlState())
                activePlayer = 2
            } else {
                sender.setBackgroundImage(UIImage(named:"circle_black"), for: UIControlState())
                sender.setTitle("", for: UIControlState())
                activePlayer = 1
                
            }
            
        }
        
        
        
        for combination in winningCombinations {
            
            if gameState[combination[0]] != 0 && gameState[combination[0]] == gameState[combination[1]] && gameState[combination[1]] == gameState[combination[2]] && gameState[combination[2]] == gameState[combination[3]]
            {
                gameIsActive = false
                
                
                
                //TODO: use the above positions to set background color for the winning buttons
                
                
                if gameState[combination[0]] == 1
                {
                    BTN1[combination[0]].setBackgroundImage(UIImage(named:"cross_red"), for: UIControlState())
                    BTN1[combination[1]].setBackgroundImage(UIImage(named:"cross_red"), for: UIControlState())
                    BTN1[combination[2]].setBackgroundImage(UIImage(named:"cross_red"), for: UIControlState())
                    BTN1[combination[3]].setBackgroundImage(UIImage(named:"cross_red"), for: UIControlState())
                    
                    
                    playerHasWonLabel.text = "Player 1 has won the game!"
                }
                else
                {
                    BTN1[combination[0]].setBackgroundImage(UIImage(named:"circle_red"), for: UIControlState())
                    BTN1[combination[1]].setBackgroundImage(UIImage(named:"circle_red"), for: UIControlState())
                    BTN1[combination[2]].setBackgroundImage(UIImage(named:"circle_red"), for: UIControlState())
                    BTN1[combination[3]].setBackgroundImage(UIImage(named:"circle_red"), for: UIControlState())
                    
                    
                    playerHasWonLabel.text = "Player 2 has won the game!"
                }
                
                playerHasWonLabel.isHidden = false
                playAgainOutlet.isHidden = false
                player1View.isHidden = true
                player2View.isHidden = true
                player2Container.isHidden = true
                player1Container.isHidden = true
                gameHasBeenWon = true
                print("gameHasBeenWonHasChangedTOTRUE")
            }
            
        }
        
        
        gameIsActive = false
        
        
        
        for i in gameState {
            if i == 0 && gameHasBeenWon == false
            {
                gameIsActive = true
                break
            }
        }
        
        if gameIsActive == false && gameHasBeenWon == false
        {
            playerHasWonLabel.text = "IT WAS A DRAW"
            playerHasWonLabel.isHidden = false
            playAgainOutlet.isHidden = false
            player1View.isHidden = true
            player2View.isHidden = true
        }
        
        
        
        
    }
    
    @IBAction func playAgain(_ sender: UIButton) {
        gameState = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        gameIsActive = true
        playerHasWonLabel.isHidden = true
        playAgainOutlet.isHidden = true
        player1View.isHidden = false
        player2View.isHidden = false
        gameHasBeenWon = false
        player1Container.isHidden = false
        player2Container.isHidden = false
        
        
        for button in BTN1 {
            button.setBackgroundImage(nil, for: UIControlState())
        }
        setDistanceLabels()
    }
    
    
    
   // generates random number to be placed as button titles
    
    func random(_ range:Range<Int>) -> Int
    {
        return range.lowerBound + Int(arc4random_uniform(UInt32(range.upperBound - range.lowerBound)))
    }
    
  
    
    // TODO: lowerbound and upperbound values need to be passed in from pickerView or other source.
    func setDistanceLabels(){
        
        for num in BTN1.indices {
            BTN1[num].setTitle("\(random(lowerBound..<uppeerBound))'", for: UIControlState())
            BTN1[num].setTitleColor(UIColor.darkGray, for: UIControlState())
            BTN1[num].titleLabel?.font = UIFont(name: "Avenir-Medium", size: 12)
        }
    }


}
