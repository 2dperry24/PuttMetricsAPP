//
//  TicTacToe.swift
//  PuttMetricsAPP
//
//  Created by User on 1/9/18.
//  Copyright © 2018 DustinPerry. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class TicTacToe: UIViewController, MCSessionDelegate, MCBrowserViewControllerDelegate {
    
    
    var peerID:MCPeerID!
    var mcSession:MCSession!
    var mcAdvertiserAssistant:MCAdvertiserAssistant!
    
    

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
                player1Container.backgroundColor = UIColor.flatOrange()
                player2Container.backgroundColor = UIColor.clear
            } else {
                player1Container.backgroundColor = UIColor.clear
                player2Container.backgroundColor = UIColor.flatSkyBlue()
               
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
    

    var tempMax = Int()
    var tempMin = Int()
    var receivedArray = [0,0,0]
    var tempArray = [Int]()
    var tempPlayerMode : String!
    var playerMode = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        gridHeightConstraint.constant = view.frame.width - 10
        
       
        
        playerHasWonLabel.isHidden = true
        playAgainOutlet.isHidden = true
        playerHasWonLabel.alpha = 1
        playAgainOutlet.alpha = 1
        player2Container.backgroundColor = UIColor.clear
        player1Container.backgroundColor = UIColor.flatOrange()
        player2View.layer.cornerRadius = player2View.layer.frame.height / 2
        player1View.layer.cornerRadius = player1View.layer.frame.height / 2

        peerID = MCPeerID(displayName: UIDevice.current.name)
        mcSession = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        mcSession.delegate = self
        
      // sent via segues from previous VC
        
      lowerBound = tempMin
      uppeerBound = tempMax
      receivedArray = tempArray
      playerMode = tempPlayerMode
        
        print("playerMode: \(playerMode)")
        print("receivedArray: \(receivedArray)")
        print("upperbound: \(uppeerBound), lowerbound: \(lowerBound)")
        
      setDistanceLabels()
        
        
    }

    private var lastPlayerToGo =  [MCPeerID]()
    private var amountOfMovesMade = 0
    
    @IBAction func BTNPressed(_ senderX: UIButton) {
        
       amountOfMovesMade += 1
        
        
        if lastPlayerToGo.last != peerID || mcSession.connectedPeers.count == 0  {
        
        
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
       
            
       
            
            print("lastplayerTogo: \(lastPlayerToGo)")
        print("MyPeerId: \(peerID)")
        print("peerIDCountArray: \(lastPlayerToGo.count)")
           // print("conectedPeers: \(mcSession.connectedPeers)")
      }
     
        
                
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
          //  self.didPlayerMissPutt = true
            self.switchPlayerWhenMissed(sender: sender)
             sender.layer.borderWidth = 0
        }))
        alert.addAction(UIAlertAction(title: "Re-pick spot", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
             sender.layer.borderWidth = 0
            print("Position on board was canceled")
        }))
        self.present(alert, animated: true, completion: nil)
      
      
    }
    
    
    
    var didPlayerMissPutt = false
    
    func switchPlayerWhenMissed(sender: UIButton){
        
//
//        if (activePlayer == 1) {
//            activePlayer = 2
//        } else {
//            activePlayer = 1
//        }
        didPlayerMissPutt = true
        let numberString = String(sender.tag)
        send(buttonPressed: numberString, sender: sender)
        
    }
    
    
    func placeMarkForPlayer(sender: UIButton) {
        
        let numberString = String(sender.tag)
        send(buttonPressed: numberString, sender: sender)
        
        
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
        
        
        checkForWinningCombination()
    
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
    
    
    
    
    
    func checkForWinningCombination(){
        
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
        
        if playerMode == "singlePlayer" {
            for num in BTN1.indices {
                BTN1[num].setTitle("\(random(lowerBound..<uppeerBound))'", for: UIControlState())
                BTN1[num].setTitleColor(UIColor.darkGray, for: UIControlState())
                BTN1[num].titleLabel?.font = UIFont(name: "Avenir-Medium", size: 12)
                }
        } else {
            for num in BTN1.indices{
                let NumberAtIndexSpot = receivedArray[num]
                BTN1[num].setTitle("\(NumberAtIndexSpot)'", for: UIControlState())
                BTN1[num].setTitleColor(UIColor.darkGray, for: UIControlState())
                BTN1[num].titleLabel?.font = UIFont(name: "Avenir-Medium", size: 12)
                
            }
        }
        
    }

    

    
    func send(buttonPressed : String, sender: UIButton) {
     //   NSLog("%@", "sendColor: \(colorName) to \(mcSession.connectedPeers.count) peers")

        if mcSession.connectedPeers.count > 0 {
            do {
                try self.mcSession.send(buttonPressed.data(using: .utf8)!, toPeers: mcSession.connectedPeers, with: .reliable)
                lastPlayerToGo.append(peerID)
               
             
                
            }
            catch let error {
                NSLog("%@", "Error for sending: \(error)")
            }
              print("tried sending data")
        }
    }
    
    
    

    
    
    // MARK: - Multipeer Connectivity
    
    var myAdvertiser = false   //bool to control if .stop() is allowed.
    
    @IBAction func showConnectivityActions(_ sender: Any) {
        
        let actionSheet = UIAlertController(title: "Use Two Devices For The Game", message: "This action will allow you to have control the game with two phones instead of one.", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Host Game", style: .default, handler: { (action:UIAlertAction) in
            
            self.mcAdvertiserAssistant = MCAdvertiserAssistant(serviceType: "ticTacToe", discoveryInfo: nil, session: self.mcSession)
            self.mcAdvertiserAssistant.start()
            self.myAdvertiser = true
        }))
        
        if mcSession.connectedPeers.count < 2 {
        actionSheet.addAction(UIAlertAction(title: "Join Game", style: .default, handler: { (action:UIAlertAction) in
            let mcBrowser = MCBrowserViewController(serviceType: "ticTacToe", session: self.mcSession)
            mcBrowser.delegate = self
            self.present(mcBrowser, animated: true, completion: nil)
        }))
        }
        
        if mcSession.connectedPeers.count > 0 || myAdvertiser == true {
                    var _title = "Leave Current Game"
            if myAdvertiser == true && mcSession.connectedPeers.count == 0 {
                _title = "Turn Off Host Signal"
            }
            
            
            
                actionSheet.addAction(UIAlertAction(title: _title , style: .default, handler: { (action:UIAlertAction) in
                    //TODO: safeproof this, maybe if mcSession is > 0 ? maybe only use one of them?
                    self.mcSession.disconnect()
                    
                    if self.myAdvertiser == true {
                        self.mcAdvertiserAssistant.stop()
                        print("advertiser stopped ")
                        self.myAdvertiser = false
                        }
                    
                    }))
        }
        
        
        
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    
    
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case MCSessionState.connected:
            print("Connected: \(peerID.displayName)")
            
        case MCSessionState.connecting:
            print("Connecting: \(peerID.displayName)")
            
        case MCSessionState.notConnected:
            print("Not Connected: \(peerID.displayName)")
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        
        
        
        
        
        
        do {
            let buttonPressed = String(data: data, encoding: .utf8)!
            let buttonWithCorrectIndex = (Int(buttonPressed)! - 1)
            
            DispatchQueue.main.async {
  
                
                if self.didPlayerMissPutt == true {
                    print("didPlayerMissPutt at beginning of receiveddata block: \(self.didPlayerMissPutt)")
                    if self.activePlayer == 1 {
                        self.activePlayer = 2
                    }else {
                        self.activePlayer = 1
                    }
                    
                    self.lastPlayerToGo.append(peerID)
                    self.didPlayerMissPutt = false
                    print("didPlayerMissPutt is now: \(self.didPlayerMissPutt)")
                } else {
                    
                print("buttonPressed Via sent transmission: \(String(describing: buttonPressed))")
                
              
                if (self.gameState[buttonWithCorrectIndex] == 0) && self.gameIsActive == true {
                    self.gameState[buttonWithCorrectIndex] = self.activePlayer
                    
                if (self.activePlayer == 1) {
                    self.BTN1[buttonWithCorrectIndex].setBackgroundImage(UIImage(named:"cross_black"), for: UIControlState())
                    self.BTN1[buttonWithCorrectIndex].setTitle("", for: UIControlState())
                    
                } else {
                    self.BTN1[buttonWithCorrectIndex].setBackgroundImage(UIImage(named:"circle_black"), for: UIControlState())
                    self.BTN1[buttonWithCorrectIndex].setTitle("", for: UIControlState())
                   
                    }
                }
                
                
                if self.activePlayer == 1 {
                    self.activePlayer = 2
                }else {
                    self.activePlayer = 1
                }
                
                
                
                self.checkForWinningCombination()
                self.lastPlayerToGo.append(peerID)
                
              
                self.amountOfMovesMade += 1

                    
                }
            }
           
        }catch{
            fatalError("Unable to process recieved data")
        }

    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        
    }
    
    
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    

    
    
    
    
    
    
    
    
 
    

}

//extension String {
//    //: ### Base64 encoding a string
//    func base64Encoded() -> String? {
//        if let data = self.data(using: .utf8) {
//            return data.base64EncodedString()
//        }
//        return nil
//    }
//    
//    //: ### Base64 decoding a string
//    func base64Decoded() -> String? {
//        if let data = Data(base64Encoded: self) {
//            return String(data: data, encoding: .utf8)
//        }
//        return nil
//    }
//}

