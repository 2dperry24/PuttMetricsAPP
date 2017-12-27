//
//  5_toTheGoodLabels.swift
//  PuttMetricsAPP
//
//  Created by User on 12/5/17.
//  Copyright © 2017 DustinPerry. All rights reserved.
//

import UIKit

class PuttOfWar: UIViewController {
    
   
    
    var viewScoresPermission = false
   
    private var undoConstant = 2
    private var counter = 0
    private var overallCounterForLevel : Double = 0
    var percentageForLevel: Double = 0
    var ScoresForAllLevelsArray = [DistanceScoring]()
    var distancesArrayForLabel = ["10'", "15'","20'","25'","30'","35'","40'","45'","50'","Champion"]
    var buttonMessagesToDisplayWhenProgressingToNextLevel = ["On to 15!","On to 20!","On to 25!","On to 30!","On to 35!","On to 40!","On to 45!","On to 50!", "The CHAMP is here!"]
    var indexForDistanceArray = 0
    @IBOutlet weak var CenterConstraintForPopup: NSLayoutConstraint!
    @IBOutlet weak var CenterConstraintForPopupPassedLevel: NSLayoutConstraint!
    
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var popUpViewForPassedLevel: UIView!
    
    @IBOutlet weak var backGroundButtonForPopupDismal: UIButton!
    @IBOutlet weak var backGroundButtonForPopupDismallWhenPassedLevelAppears: UIButton!
    
    
    
    //MARK: wind direction
    var windDirectionindex = 0
    @IBOutlet weak var windDirectionOutlet: UIButton!
    @IBAction func windDirectionBTN(_ sender: UIButton) {
       windDirectionindex += 1
            if windDirectionindex > 4 {
                windDirectionindex = 0
            }
        
        switch windDirectionindex {
        case 0:
            windDirectionOutlet.setImage(UIImage(named: "wind0"), for: .normal)
        case 1:
         windDirectionOutlet.setImage(UIImage(named: "wind1"), for: .normal)
        case 2:
             windDirectionOutlet.setImage(UIImage(named: "wind2"), for: .normal)
        case 3:
          windDirectionOutlet.setImage(UIImage(named: "wind3"), for: .normal)
        case 4:
          windDirectionOutlet.setImage(UIImage(named: "wind4"), for: .normal)
        default:
             windDirectionOutlet.setImage(UIImage(named: "wind0"), for: .normal)
        }

    }
    
    @IBAction func undoButton(_ sender: UIButton) {
        if overallCounterForLevel > 0 {
            
            if undoConstant == 1 {
                overallCounterForLevel -= 1
                totalPuttsTakenLabel.text = String(Int(overallCounterForLevel))
                    let percentageDisplayValueAfterUndo = calculatePercentageForLevel()
                    let numberAfterUndo = String(format: "%.0f", percentageDisplayValueAfterUndo)
                        if numberAfterUndo == "nan" {
                            percentageForLevelLabel.text = String("0 %")
                        } else {
                            percentageForLevelLabel.text = "\(numberAfterUndo) %"
                        }
                changeColorsOfBarsForSender1UndoButton()
                counter += 1
                 checkCounterVariable()
                
            }  else if undoConstant == 2 {
                overallCounterForLevel -= 1
                totalPuttsTakenLabel.text = String(Int(overallCounterForLevel))
                
                percentageForLevel -= 1
                    let percentageDisplayValueAfterUndo = calculatePercentageForLevel()
                    let numberAfterUndo = String(format: "%.0f", percentageDisplayValueAfterUndo)
                    if numberAfterUndo == "nan" {
                        percentageForLevelLabel.text = String("0 %")
                    } else {
                        percentageForLevelLabel.text = "\(numberAfterUndo) %"
                    }
                //Counter must go after changeColor func
                changeColorsOfBarsForSender2UndoButton()
                counter -= 1
                checkCounterVariable()
        }
        
    }
        
        
        
        
        
        
        
    }
    @IBOutlet weak var buttonForEndOfGamePopup: UIButton!
    @IBOutlet weak var buttonForNextLevelPopup: UIButton!
    
    @IBOutlet weak var displayMessageForPassedLevelPopUpView: UILabel!
    
    var tenFeetScores0 = DistanceScoring(totalPuttsTaken: 0, percentage: 0)
    var fifteenFeetScores1 = DistanceScoring(totalPuttsTaken: 0, percentage: 0)
    var twentyFeetScores2 = DistanceScoring(totalPuttsTaken: 0, percentage: 0)
    var twentyFiveFeetScores3 = DistanceScoring(totalPuttsTaken: 0, percentage: 0)
    var thirtyFeetScores4 = DistanceScoring(totalPuttsTaken: 0, percentage: 0)
    var thirtyFiveFeetScores5 = DistanceScoring(totalPuttsTaken: 0, percentage: 0)
    var fourtyFeetScores6 = DistanceScoring(totalPuttsTaken: 0, percentage: 0)
    var fourtyFiveScores7 = DistanceScoring(totalPuttsTaken: 0, percentage: 0)
    var fiftyFeetScores8 = DistanceScoring(totalPuttsTaken: 0, percentage: 0)

    
    @IBOutlet weak var bar5: RoundedEdgesTallButton!
    @IBOutlet weak var bar4: RoundedEdgesTallButton!
    @IBOutlet weak var bar3: RoundedEdgesTallButton!
    @IBOutlet weak var bar2: RoundedEdgesTallButton!
    @IBOutlet weak var bar1: RoundedEdgesTallButton!
    @IBOutlet weak var bar6: RoundedEdgesTallButton!
    @IBOutlet weak var bar7: RoundedEdgesTallButton!
    @IBOutlet weak var bar8: RoundedEdgesTallButton!
    @IBOutlet weak var bar9: RoundedEdgesTallButton!
    @IBOutlet weak var bar10: RoundedEdgesTallButton!
    @IBOutlet weak var bar20: RoundedEdgesTallButton!
    @IBOutlet weak var bar21: RoundedEdgesTallButton!
    @IBOutlet weak var bar22: RoundedEdgesTallButton!
    
    
    
    @IBOutlet weak var DistanceForCurrentLevelLabel: UILabel!
    
    @IBOutlet weak var percentageForLevelLabel: UILabel!
    @IBOutlet weak var totalPuttsTakenLabel: UILabel!
    
    // MARK: Missed and Made buttons for color change purposes in view did load.
    @IBOutlet weak var missedButton: minusButton!
    @IBOutlet weak var madeButton: additionButton!
    
    
    
    
    
    @IBAction func sendToResultsVC(_ sender: Any) {
            performSegue(withIdentifier: "toLeaderboard" , sender: self )
       
    }
    
    
    
    
    
    @IBAction func made_missedButton(_ sender: UIButton) {
     
        if indexForDistanceArray == 0 && overallCounterForLevel == 0 {
            viewScoresPermission = false
        }
        if sender.tag == 1 {
            undoConstant = 1
        } else {
            undoConstant = 2
        }
        
        if sender.tag == 2{
            self.counter = self.counter + 1
            self.percentageForLevel += 1
            changeColorsOfBarsForSender2()
        }
    
        if sender.tag == 1 {
          
            self.counter = self.counter - 1
              changeColorsOfBarsForSender1()
        }
        
        checkCounterVariable()
        didLoseOrWinLevel()
        
        overallCounterForLevel += 1
        
        let totalCountForLabel = String(Int(overallCounterForLevel))
        totalPuttsTakenLabel.text = totalCountForLabel
     //   print("Overall count is \(totalCountForLabel)")
     //   print("Putts made: \(percentageForLevel)")
        let percentageDisplayValue = calculatePercentageForLevel()
        let number = String(Int(percentageDisplayValue.rounded()))
        
        percentageForLevelLabel.text = "\(number) %"
       
        
    }
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        popUpView.layer.cornerRadius = 10
        popUpView.layer.masksToBounds = true
        popUpViewForPassedLevel.layer.cornerRadius = 10
        popUpViewForPassedLevel.layer.masksToBounds = true

        missedButton.backgroundColor = UIColor.flatRed()
        madeButton.backgroundColor = UIColor.flatGreen()
        DistanceForCurrentLevelLabel.text = distancesArrayForLabel[indexForDistanceArray]
    }

    func changeColorsOfBarsForSender2() {
        
        if counter == -5 {
            self.bar5.backgroundColor = UIColor.lightGray
        } else if counter == -4 {
            self.bar5.backgroundColor = UIColor.lightGray
        }else if counter == -3 {
            self.bar4.backgroundColor = UIColor.lightGray
        }else if counter == -2 {
            self.bar3.backgroundColor = UIColor.lightGray
        }else if counter == -1 {
            self.bar2.backgroundColor = UIColor.lightGray
        }else if counter == 0 {
            self.bar1.backgroundColor = UIColor.lightGray
        } else if counter == 1 {
            self.bar6.backgroundColor = UIColor.flatGreen()
        } else if counter == 2 {
            self.bar7.backgroundColor = UIColor.flatGreen()
        }else if counter == 3 {
            self.bar8.backgroundColor = UIColor.flatGreen()
        }else if counter == 4 {
            self.bar9.backgroundColor = UIColor.flatGreen()
        }else if counter == 5 {
            self.bar10.backgroundColor = UIColor.flatGreen()
        }
    }
    
    func changeColorsOfBarsForSender2UndoButton() {
        
       if counter == -4 {
            self.bar5.backgroundColor = UIColor.lightGray
        }else if counter == -3 {
            self.bar4.backgroundColor = UIColor.flatRed()
        }else if counter == -2 {
            self.bar3.backgroundColor = UIColor.flatRed()
        }else if counter == -1 {
            self.bar2.backgroundColor = UIColor.flatRed()
        }else if counter == 0 {
            self.bar1.backgroundColor = UIColor.flatRed()
        } else if counter == 1 {
            self.bar6.backgroundColor = UIColor.lightGray
        } else if counter == 2 {
            self.bar7.backgroundColor = UIColor.lightGray
        }else if counter == 3 {
            self.bar8.backgroundColor = UIColor.lightGray
        }else if counter == 4 {
            self.bar9.backgroundColor = UIColor.lightGray
        }
    }
    
    
    
    func changeColorsOfBarsForSender1(){
        
        if counter == -5 {
            self.bar5.backgroundColor = UIColor.flatRed()
        } else if counter == -4 {
            self.bar4.backgroundColor = UIColor.flatRed()
        }else if counter == -3 {
            self.bar3.backgroundColor = UIColor.flatRed()
        }else if counter == -2 {
            self.bar2.backgroundColor = UIColor.flatRed()
        }else if counter == -1 {
            self.bar1.backgroundColor = UIColor.flatRed()
        }else if counter == 0 {
            self.bar6.backgroundColor = UIColor.lightGray
        } else if counter == 1 {
            self.bar7.backgroundColor = UIColor.lightGray
        } else if counter == 2 {
            self.bar8.backgroundColor = UIColor.lightGray
        }else if counter == 3 {
            self.bar9.backgroundColor = UIColor.lightGray
        }else if counter == 4 {
            self.bar10.backgroundColor = UIColor.lightGray
        }
    }
    
    func changeColorsOfBarsForSender1UndoButton(){
        
        if counter == -5 {
            self.bar5.backgroundColor = UIColor.flatRed()
        } else if counter == -4 {
            self.bar4.backgroundColor = UIColor.lightGray
        }else if counter == -3 {
            self.bar3.backgroundColor = UIColor.lightGray
        }else if counter == -2 {
            self.bar2.backgroundColor = UIColor.lightGray
        }else if counter == -1 {
            self.bar1.backgroundColor = UIColor.lightGray
        }else if counter == 0 {
            self.bar6.backgroundColor = UIColor.lightGray
        } else if counter == 1 {
            self.bar7.backgroundColor = UIColor.lightGray
        } else if counter == 2 {
            self.bar8.backgroundColor = UIColor.lightGray
        }else if counter == 3 {
            self.bar9.backgroundColor = UIColor.lightGray
        }else if counter == 4 {
            self.bar10.backgroundColor = UIColor.lightGray
        }else if counter == 5 {
            self.bar10.backgroundColor = UIColor.flatGreen()
        }
    }
    
    
    
    
    
    func loadScoresIntoScoringArray() {
        
        
        print("What IS MY INDEX in loadScoresIntoScoreArray: \(indexForDistanceArray)")
        if indexForDistanceArray == 0 {
            
            tenFeetScores0.percentage = calculatePercentageForLevel()
            tenFeetScores0.totalPuttsTaken = Int(overallCounterForLevel)
            ScoresForAllLevelsArray.append(tenFeetScores0)
        } else if indexForDistanceArray == 1 {
            fifteenFeetScores1.percentage = calculatePercentageForLevel()
            fifteenFeetScores1.totalPuttsTaken = Int(overallCounterForLevel)
            ScoresForAllLevelsArray.append(fifteenFeetScores1)
        }else if indexForDistanceArray == 2 {
            twentyFeetScores2.percentage = calculatePercentageForLevel()
            twentyFeetScores2.totalPuttsTaken = Int(overallCounterForLevel)
            ScoresForAllLevelsArray.append(twentyFeetScores2)
        }else if indexForDistanceArray == 3 {
            twentyFiveFeetScores3.percentage = calculatePercentageForLevel()
            twentyFiveFeetScores3.totalPuttsTaken = Int(overallCounterForLevel)
            ScoresForAllLevelsArray.append(twentyFiveFeetScores3)
        }else if indexForDistanceArray == 4 {
            thirtyFeetScores4.percentage = calculatePercentageForLevel()
            thirtyFeetScores4.totalPuttsTaken = Int(overallCounterForLevel)
            ScoresForAllLevelsArray.append(thirtyFeetScores4)
        }else if indexForDistanceArray == 5 {
            thirtyFiveFeetScores5.percentage = calculatePercentageForLevel()
            thirtyFiveFeetScores5.totalPuttsTaken = Int(overallCounterForLevel)
            ScoresForAllLevelsArray.append(thirtyFiveFeetScores5)
        }else if indexForDistanceArray == 6 {
            fourtyFeetScores6.percentage = calculatePercentageForLevel()
            fourtyFeetScores6.totalPuttsTaken = Int(overallCounterForLevel)
            ScoresForAllLevelsArray.append(fourtyFiveScores7)
        }else if indexForDistanceArray == 7 {
            fourtyFiveScores7.percentage = calculatePercentageForLevel()
            
            fourtyFiveScores7.totalPuttsTaken = Int(overallCounterForLevel)
            ScoresForAllLevelsArray.append(fourtyFiveScores7)
        }else if indexForDistanceArray == 8 {
            fiftyFeetScores8.percentage = calculatePercentageForLevel()
            
            fiftyFeetScores8.totalPuttsTaken = Int(overallCounterForLevel)
            ScoresForAllLevelsArray.append(fiftyFeetScores8)
              viewScoresPermission = true
        }
//        else if indexForDistanceArray == 9 {
//            fiftyFiveFeetScores9.percentage = calculatePercentageForLevel()
//
//            fiftyFiveFeetScores9.totalPuttsTaken = Int(overallCounterForLevel)
//            ScoresForAllLevelsArray.append(fiftyFiveFeetScores9)
//
//
//
//
//        }else if indexForDistanceArray == 10 {
//            sixtyFeetScores10.percentage = calculatePercentageForLevel()
//
//            sixtyFeetScores10.totalPuttsTaken = Int(overallCounterForLevel)
//            ScoresForAllLevelsArray.append(sixtyFeetScores10)
//
//
//        }
        
    }
    
    
    
    
    
    
    


    //Mark: Popup start and closing functions.
    
    
    
    @IBAction func closePopUpOfPassedLevel(_ sender: Any) {
        
        CenterConstraintForPopupPassedLevel.constant = 500
        UIView.animate(withDuration: 0.1, animations: {
            self.view.layoutIfNeeded()
            self.backGroundButtonForPopupDismallWhenPassedLevelAppears.alpha = 0
        })
        
        
        if indexForDistanceArray < distancesArrayForLabel.count {
             DistanceForCurrentLevelLabel.text = distancesArrayForLabel[indexForDistanceArray]
            
            print("THIS SHOULD BE WORKING HERE")
          //  checkForGameToBeWonPast60()
        }
        print("index before loadingintoScoringArrayonPassedLevel is: \(indexForDistanceArray)")
       loadScoresIntoScoringArray()
       addTheRestOfTheNumbersAfterYouDie()
//        print ("Percentage = \(ScoresForAllLevelsArray[indexForDistanceArray - 1].percentage)")
//        print ("totalPuttsWere: = \(ScoresForAllLevelsArray[indexForDistanceArray - 1].totalPuttsTaken)")
//
     
       
        
        if viewScoresPermission == true {
           
          
           performSegue(withIdentifier: "sendToTugWarResultsVC" , sender: self )
              resetTheBoard()
             indexForDistanceArray = 0
            print("indexForDistanceArrayResetAfterBoolChange")
            
        }
        
       indexForDistanceArray += 1
       resetTheBoard()
       
        
    }
    
    
    @IBAction func closePopup(_ sender: Any) {
       
        
        CenterConstraintForPopup.constant = -500
        UIView.animate(withDuration: 0.1, animations: {
            self.view.layoutIfNeeded()
          self.backGroundButtonForPopupDismal.alpha = 0
    })
        
        loadScoresIntoScoringArray()
        addTheRestOfTheNumbersAfterYouDie()
   
        performSegue(withIdentifier: "sendToTugWarResultsVC" , sender: self )
        resetTheBoard()
    }
    
    
    func startPopUp(){
        CenterConstraintForPopup.constant = 0
        
        
        UIView.animate(withDuration: 0.5, delay: 1, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            
            self.view.layoutIfNeeded()
            
        }, completion: nil)
        UIView.animate(withDuration: 0.5, animations: {
            self.backGroundButtonForPopupDismal.alpha = 0.5
        })
    }
    
    func startPopUpForPassedLevel() {
        CenterConstraintForPopupPassedLevel.constant = 0
     
        
        UIView.animate(withDuration: 0.5, delay: 1, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            
            self.view.layoutIfNeeded()
            
        }, completion: nil)
        UIView.animate(withDuration: 0.5, animations: {
            self.backGroundButtonForPopupDismallWhenPassedLevelAppears.alpha = 0.5
        })
        
        
        //TODO: create array for button and display messages.
        displayMessageForPassedLevelPopUpView.text = "Great Job, Onto the next level. Your stats were perfect there \(percentageForLevel)%"
        
        buttonForNextLevelPopup.setTitle(buttonMessagesToDisplayWhenProgressingToNextLevel[indexForDistanceArray], for: .normal)
       
        print("indexForDistanceArray after is \(indexForDistanceArray)")
        
        
    }
    
    
    
//
//    func checkForGameToBeWonPast60() {
//
//        if indexForDistanceArray == distancesArrayForLabel.count - 2 {
//            buttonForNextLevelPopup.setTitle("Incredible Putting, Winner!", for: .normal)
//            indexForDistanceArray = indexForDistanceArray - 1
//        }
//    }
//
    
    
    func calculatePercentageForLevel() -> Double {
        
        let LevelPercentage =  percentageForLevel / overallCounterForLevel
        let LevelPercentageAsAPercent = LevelPercentage * 100
        print("LevelPercentageAsPErcent : \(LevelPercentageAsAPercent)")
        
        return LevelPercentageAsAPercent
  
    }
    
    
    func checkCounterVariable() {
        if self.counter > 0 {
            bar20.backgroundColor = UIColor.flatGreen()
            bar21.backgroundColor = UIColor.flatGreen()
            bar22.backgroundColor = UIColor.flatGreen()
        } else if self.counter < 0 {
            bar20.backgroundColor = UIColor.flatRed()
            bar21.backgroundColor = UIColor.flatRed()
            bar22.backgroundColor = UIColor.flatRed()
        } else  {
            bar20.backgroundColor = UIColor.flatGray()
            bar21.backgroundColor = UIColor.flatGray()
            bar22.backgroundColor = UIColor.flatGray()
        }
    }
    
   
    
    func didLoseOrWinLevel() {
        if self.counter == -5 {
            startPopUp()
        } else if self.counter == 5 {
            startPopUpForPassedLevel()
        }
    }
    
    //Mark: Load functions from level into variables for Score Keeping.
    
    func loadScoreFromLevelIntoVariables() {
       
     

        if DistanceForCurrentLevelLabel.text == distancesArrayForLabel[0] {
            tenFeetScores0.totalPuttsTaken = Int(overallCounterForLevel)
            tenFeetScores0.percentage = calculatePercentageForLevel()
            
            print("10FeetScores:\(tenFeetScores0.totalPuttsTaken)")
            print("10FeetPercentage: \(tenFeetScores0.percentage)")
        }
        
        
        
        
        
    }
  
    
    //MARK: Updating the Board and All the Labels.
    
    func updateAllTheLabelsOnTheBoardAfterReset () {
        
        totalPuttsTakenLabel.text = String(0)
        percentageForLevelLabel.text = String(0)
    }
    

    func resetTheBoard() {
        self.bar1.backgroundColor = UIColor.lightGray
        self.bar2.backgroundColor = UIColor.lightGray
        self.bar3.backgroundColor = UIColor.lightGray
        self.bar4.backgroundColor = UIColor.lightGray
        self.bar5.backgroundColor = UIColor.lightGray
        self.bar6.backgroundColor = UIColor.lightGray
        self.bar7.backgroundColor = UIColor.lightGray
        self.bar8.backgroundColor = UIColor.lightGray
        self.bar9.backgroundColor = UIColor.lightGray
        self.bar10.backgroundColor = UIColor.lightGray
        self.bar20.backgroundColor = UIColor.lightGray
        self.bar21.backgroundColor = UIColor.lightGray
        self.bar22.backgroundColor = UIColor.lightGray
        self.counter = 0
        
        self.percentageForLevel = 0
        self.overallCounterForLevel = 0
        totalPuttsTakenLabel.text = String(0)
        
        percentageForLevelLabel.text = "\(0) %"
        DistanceForCurrentLevelLabel.text = distancesArrayForLabel[indexForDistanceArray]
        viewScoresPermission = false
    }

    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sendToTugWarResultsVC" {
            let secondVC = segue.destination as! ResultsPuttOfWarVC
            
            secondVC.resultsForScoringArray = ScoresForAllLevelsArray
            secondVC.cellCount = indexForDistanceArray + 1
            secondVC.windDirectionTemp = windDirectionindex
        } else {
            print("Data NOT Passed! destination vc is not set to ResultsTugOfWarVC")
        }
    }
    
    
    func addTheRestOfTheNumbersAfterYouDie() {
      
        let number = indexForDistanceArray + 1
        
        for x in number...(distancesArrayForLabel.count) {
                
                if x == 1 {
                    fifteenFeetScores1.percentage = 0
                    fifteenFeetScores1.totalPuttsTaken = 0
                    ScoresForAllLevelsArray.append(fifteenFeetScores1)
                }else if x == 2 {
                    twentyFeetScores2.percentage = 0
                    twentyFeetScores2.totalPuttsTaken = 0
                    ScoresForAllLevelsArray.append(twentyFeetScores2)
                    print("Scores added for 2")
                }else if x == 3 {
                    twentyFiveFeetScores3.percentage = 0
                    twentyFiveFeetScores3.totalPuttsTaken = 0
                    ScoresForAllLevelsArray.append(twentyFiveFeetScores3)
                     print("Scores added for 3")
                }else if x == 4 {
                    thirtyFeetScores4.percentage = 0
                    thirtyFeetScores4.totalPuttsTaken = 0
                    ScoresForAllLevelsArray.append(thirtyFeetScores4)
                }else if x == 5 {
                        thirtyFiveFeetScores5.percentage = 0
                        thirtyFiveFeetScores5.totalPuttsTaken = 0
                        ScoresForAllLevelsArray.append(thirtyFiveFeetScores5)
                }else if x == 6 {
                    fourtyFeetScores6.percentage = 0
                    fourtyFeetScores6.totalPuttsTaken = 0
                    ScoresForAllLevelsArray.append(fourtyFeetScores6)
                }else if x == 7 {
                    fourtyFiveScores7.percentage = 0
                    fourtyFiveScores7.totalPuttsTaken = 0
                    ScoresForAllLevelsArray.append(fourtyFiveScores7)
                     print("Scores added for 7")
                }else if x == 8 {
                    fiftyFeetScores8.percentage = 0
                    fiftyFeetScores8.totalPuttsTaken = 0
                    ScoresForAllLevelsArray.append(fiftyFeetScores8)
                }
//                }else if x == 9 {
//                    fiftyFiveFeetScores9.percentage = 0
//                    fiftyFiveFeetScores9.totalPuttsTaken = 0
//                    ScoresForAllLevelsArray.append(fiftyFiveFeetScores9)
//                }else if x == 10 {
//                    sixtyFeetScores10.percentage = 0
//                    sixtyFeetScores10.totalPuttsTaken = 0
//                    ScoresForAllLevelsArray.append(sixtyFeetScores10)
//                     print("Scores added for 10")
//
//                }
            }
        }
    }



   

