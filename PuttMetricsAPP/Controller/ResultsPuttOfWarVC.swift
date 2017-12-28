//
//  ResultsTugOfWarViewController.swift
//  PuttMetricsAPP
//
//  Created by User on 12/7/17.
//  Copyright © 2017 DustinPerry. All rights reserved.
//

import UIKit
import CoreData




class ResultsPuttOfWarVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    
    @IBOutlet weak var AverageScoreLabel: UILabel!
    @IBOutlet weak var levelsPassedLabel: UILabel!
    var awardImageArray = [UIImageView]()
  

  
    
    @IBOutlet weak var tableViewForScores: UITableView!
  
    var distancesArrayForLabel = ["10'", "15'","20'","25'","30'","35'","40'","45'","50'","Champion"]
    
    var cellCount = 0
    //selectedIndex is for expandable Cell in tableView.
    var selectedIndex = -1
    var selectedIndexTotalScore = -1
    var lifeTimeAveragesForPuttsPerLevel = [Int16] ()
    var lifeTimeAveragesForScorePerLevel = [Double] ()
    
    var data = [DistanceScoring]()
    var resultsForScoringArray = [DistanceScoring]()
    

    
    
      var totalScores = [TotalScores] ()
      var scoresfromTen = [TenFeetScores]()
      var scoresfromFifteen = [FifteenFeetScores]()
      var scoresfromTwenty = [TwentyFeetScores]()
      var scoresfromTwentyFive = [TwentyFiveFeetScores]()
      var scoresfromThirty = [ThirtyFeetScores]()
      var scoresfromThirtyFive = [ThirtyFiveFeetScores]()
      var scoresfromForty = [FortyFeetScores]()
      var scoresfromFortyFive = [FortyFiveFeetScores]()
      var scoresfromFifty = [FiftyFeetScores]()

   
   var windDirectionTemp = Int()
   var windDirectionIndex = 0
   var sumOfScores : Double = 0
   var maxScore: Double = 0
   var bonusPointTotal = 0.0
   var averageScoreForAllAttemptedLevels = 0.0
   var totalScoreToAppendToCoreData = 0.0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       windDirectionIndex = windDirectionTemp
       print("winddirectionIndex: \(windDirectionIndex)")
       data = resultsForScoringArray
          getTotalScoreForRound()
       putScoresIntoEachDistaceArray()
      
        

        
        
       
      tableViewForScores.delegate = self
        tableViewForScores.tableFooterView = UIView()
        tableViewForScores.layoutMargins = UIEdgeInsets.zero
        tableViewForScores.separatorInset = UIEdgeInsets.zero
        tableViewForScores.dataSource = self
        tableViewForScores.separatorColor = UIColor.darkGray

        self.navigationItem.title = "Putt-of-War"
    }

    
    
    
    
    
    

    func getTotalScoreForRound() -> Double {
      
        sumOfScores = data[0].percentage + data[1].percentage + data[2].percentage + data[3].percentage + data[4].percentage + data[5].percentage + data[6].percentage + data[7].percentage + data[8].percentage

        var bonusMultiplier = 0
        
        for x in 0...8 {
            if data[x].percentage == 100 {
            bonusMultiplier += 1
            }
        }
        
        switch bonusMultiplier {
        case 0:
         bonusPointTotal = 0
        case 1:
        bonusPointTotal = 10
        case 2:
        bonusPointTotal = 20
        case 3:
        bonusPointTotal = 40
        case 4:
        bonusPointTotal = 80
        case 5:
        bonusPointTotal = 160
        case 6:
        bonusPointTotal = 320
        case 7:
        bonusPointTotal = 640
        case 8:
        bonusPointTotal = 1280
        default:
            bonusPointTotal = 0
        }
        
        print("bonus: \(bonusMultiplier)")
        
        
  //      print("cellcount: \(cellCount)")
        averageScoreForAllAttemptedLevels  = (sumOfScores) / Double(cellCount)
  //      print("averageScoreForAllAttemptedLevels: \(averageScoreForAllAttemptedLevels)")

        
        
        totalScoreToAppendToCoreData = Double(Int((averageScoreForAllAttemptedLevels.rounded() * Double(cellCount - 1).rounded())) + Int(bonusPointTotal))
        
   //     print("totalScoreToappendTocoreData was gernerated")
        
        return averageScoreForAllAttemptedLevels

    }



    
    // These arrays hold values for longterm calculation comparisons. If putts taken = 0 then we wont add score to the array using an if statement.

   func putScoresIntoEachDistaceArray() {



        let totalScoreForThatAttempt =  totalScoreToAppendToCoreData
        let dateForCurrentGame = NSDate()
        let windDirectionAsString = String(windDirectionIndex)
        if totalScoreForThatAttempt != 0 {
            let persistenceTotalScores = TotalScores(context: PersistenceService.context)
             persistenceTotalScores.total = totalScoreForThatAttempt
            persistenceTotalScores.date = dateForCurrentGame
            persistenceTotalScores.windDirection = windDirectionAsString
            self.totalScores.append(persistenceTotalScores)
            PersistenceService.saveContext()




            //Attempt to get the highscore for highScore label

                                                            let fetchRequestMaxScore: NSFetchRequest<TotalScores> = TotalScores.fetchRequest()
                                                            let sort = NSSortDescriptor(keyPath: \TotalScores.total, ascending: false)
                                                            fetchRequestMaxScore.sortDescriptors = [sort]
                                                            do {
                                                                let maxTempScore = try PersistenceService.context.fetch(fetchRequestMaxScore)
                                                                if let highCount = maxTempScore.first?.total {
                                                                    maxScore = highCount

                                                                }
                                                                //self.maxScore = highCount }
                                                            } catch let error as NSError {
                                                                print("Could not fetch. \(error), \(error.userInfo)")
                                                            }


                                                        }


        let score10puttsTaken = data[0].totalPuttsTaken
        let score10percent = data[0].percentage
        if score10puttsTaken != 0 {
        let persistenceScoresfromTen = TenFeetScores(context: PersistenceService.context)
        persistenceScoresfromTen.puttsTaken = Int16(score10puttsTaken)
        persistenceScoresfromTen.percentage = score10percent

        self.scoresfromTen.append(persistenceScoresfromTen)
            PersistenceService.saveContext()



                                                            let fetchRequest: NSFetchRequest<TenFeetScores> = TenFeetScores.fetchRequest()
                                                            do {
                                                                let scores10 = try PersistenceService.context.fetch(fetchRequest)
                                                                self.scoresfromTen = scores10
                                                                //   print("scorefromTen: \(scoresfromTen)")
                                                                //    self.tableViewForScores.reloadData()
                                                            } catch { print("Reloading data didn't work, hence the catch 10")}


            let sumOfPuttsTaken = scoresfromTen.reduce(0, {$0 + $1.puttsTaken})
            let average10 = Double(sumOfPuttsTaken) / Double(scoresfromTen.count)

//            print("sum from 10' : \(sumOfPuttsTaken)")
//            print("count from 10' : \(scoresfromTen.count)")
//            print("average putts taken from 10' : \(Int16(average10))")
            lifeTimeAveragesForPuttsPerLevel.append(Int16(average10))

            /////////////   /////////////   /////////////   /////////////   /////////////   /////////////   ///////////////

            let sumOfScoreTaken = scoresfromTen.reduce(0, {$0 + $1.percentage})
    //        print("sumOfScoreTaken: \(sumOfScoreTaken)")
            let average10Score = Double(sumOfScoreTaken) / Double(scoresfromTen.count)

    //      print("current average of Percents: \(average10Score)")
            lifeTimeAveragesForScorePerLevel.append(average10Score.rounded())
   //          print("last added : \(lifeTimeAveragesForScorePerLevel.last)")

    }

        let score15puttsTaken = data[1].totalPuttsTaken
        let score15percent = data[1].percentage
        if score15puttsTaken != 0 {
            let persistenceScoresfromFifteen = FifteenFeetScores(context: PersistenceService.context)
            persistenceScoresfromFifteen.puttsTaken = Int16(score15puttsTaken)
            persistenceScoresfromFifteen.percentage = score15percent

            self.scoresfromFifteen.append(persistenceScoresfromFifteen)
            PersistenceService.saveContext()


                                                let fetchRequest15: NSFetchRequest<FifteenFeetScores> = FifteenFeetScores.fetchRequest()
                                                do {
                                                    let scores15 = try PersistenceService.context.fetch(fetchRequest15)
                                                    self.scoresfromFifteen = scores15
                                                    //   print("scorefromTen: \(scoresfromTen)")
                                                    //    self.tableViewForScores.reloadData()
                                                } catch { print("Reloading data didn't work, hence the catch 15")}


                let sumOfPuttsTaken15 = scoresfromFifteen.reduce(0, {$0 + $1.puttsTaken})
                let average15 = Double(sumOfPuttsTaken15) / Double(scoresfromFifteen.count)
   //         print("average putts taken from 15' : \(Int16(average15))")
                lifeTimeAveragesForPuttsPerLevel.append(Int16(average15))

                /////////////   /////////////   /////////////   /////////////   /////////////   /////////////   ///////////////

                let sumOfScoreTaken15 = scoresfromFifteen.reduce(0, {$0 + $1.percentage})
                let average15Score = Double(sumOfScoreTaken15) / Double(scoresfromFifteen.count)
  //          print("current average of 15  Percents: \(average15Score)")
                lifeTimeAveragesForScorePerLevel.append(average15Score.rounded())

        }

        let score20puttsTaken = data[2].totalPuttsTaken
        let score20percent = data[2].percentage
        if score20puttsTaken != 0 {
            let persistenceScoresfromTwenty = TwentyFeetScores(context: PersistenceService.context)
            persistenceScoresfromTwenty.puttsTaken = Int16(score20puttsTaken)
            persistenceScoresfromTwenty.percentage = score20percent
            self.scoresfromTwenty.append(persistenceScoresfromTwenty)
              PersistenceService.saveContext()

                                                            let fetchRequest20: NSFetchRequest<TwentyFeetScores> = TwentyFeetScores.fetchRequest()
                                                            do {
                                                                let scores20 = try PersistenceService.context.fetch(fetchRequest20)
                                                                self.scoresfromTwenty = scores20
                                                                //   print("scorefromTen: \(scoresfromTen)")
                                                                //    self.tableViewForScores.reloadData()
                                                            } catch { print("Reloading data didn't work, hence the catch 20")}



                let sumOfPuttsTaken20 = scoresfromTwenty.reduce(0, {$0 + $1.puttsTaken})
                let average20 = Double(sumOfPuttsTaken20) / Double(scoresfromTwenty.count)
                lifeTimeAveragesForPuttsPerLevel.append(Int16(average20))

                /////////////   /////////////   /////////////   /////////////   /////////////   /////////////   ///////////////

                let sumOfScoreTaken20 = scoresfromTwenty.reduce(0, {$0 + $1.percentage})
                let average20Score = Double(sumOfScoreTaken20) / Double(scoresfromTwenty.count)
                lifeTimeAveragesForScorePerLevel.append(average20Score.rounded())
        }

        let score25puttsTaken = data[3].totalPuttsTaken
        let score25percent = data[3].percentage
        if score25puttsTaken != 0 {
            let persistenceScoresfromTwentyFive = TwentyFiveFeetScores(context: PersistenceService.context)
            persistenceScoresfromTwentyFive.puttsTaken = Int16(score25puttsTaken)
            persistenceScoresfromTwentyFive.percentage = score25percent
            self.scoresfromTwentyFive.append(persistenceScoresfromTwentyFive)
             PersistenceService.saveContext()



                                                                    let fetchRequest25: NSFetchRequest<TwentyFiveFeetScores> = TwentyFiveFeetScores.fetchRequest()
                                                                    do {
                                                                        let scores25 = try PersistenceService.context.fetch(fetchRequest25)
                                                                        self.scoresfromTwentyFive = scores25
                                                                        //   print("scorefromTen: \(scoresfromTen)")
                                                                        //    self.tableViewForScores.reloadData()
                                                                    } catch { print("Reloading data didn't work, hence the catch 25")}


                let sumOfPuttsTaken25 = scoresfromTwentyFive.reduce(0, {$0 + $1.puttsTaken})
                let average25 = Double(sumOfPuttsTaken25) / Double(scoresfromTwentyFive.count)
                lifeTimeAveragesForPuttsPerLevel.append(Int16(average25))

                /////////////   /////////////   /////////////   /////////////   /////////////   /////////////   ///////////////

                let sumOfScoreTaken25 = scoresfromTwentyFive.reduce(0, {$0 + $1.percentage})
                let average25Score = Double(sumOfScoreTaken25) / Double(scoresfromTwentyFive.count)
                lifeTimeAveragesForScorePerLevel.append(average25Score.rounded())

        }

        let score30puttsTaken = data[4].totalPuttsTaken
        let score30percent = data[4].percentage
        if score30puttsTaken != 0 {
            let persistenceScoresfromThirty = ThirtyFeetScores(context: PersistenceService.context)
            persistenceScoresfromThirty.puttsTaken = Int16(score30puttsTaken)
            persistenceScoresfromThirty.percentage = score30percent
            self.scoresfromThirty.append(persistenceScoresfromThirty)
                  PersistenceService.saveContext()

                                                                            let fetchRequest30: NSFetchRequest<ThirtyFeetScores> = ThirtyFeetScores.fetchRequest()
                                                                            do {
                                                                                let scores30 = try PersistenceService.context.fetch(fetchRequest30)
                                                                                self.scoresfromThirty = scores30
                                                                                //   print("scorefromTen: \(scoresfromTen)")
                                                                                //    self.tableViewForScores.reloadData()
                                                                            } catch { print("Reloading data didn't work, hence the catch 30")}

                let sumOfPuttsTaken30 = scoresfromThirty.reduce(0, {$0 + $1.puttsTaken})
                let average30 = Double(sumOfPuttsTaken30) / Double(scoresfromThirty.count)
                lifeTimeAveragesForPuttsPerLevel.append(Int16(average30))

                /////////////   /////////////   /////////////   /////////////   /////////////   /////////////   ///////////////

                let sumOfScoreTaken30 = scoresfromThirty.reduce(0, {$0 + $1.percentage})
                let average30Score = Double(sumOfScoreTaken30) / Double(scoresfromThirty.count)
                lifeTimeAveragesForScorePerLevel.append(average30Score.rounded())

        }

        let score35puttsTaken = data[5].totalPuttsTaken
        let score35percent = data[5].percentage
        if score35puttsTaken != 0 {
            let persistenceScoresfromThirtyFive = ThirtyFiveFeetScores(context: PersistenceService.context)
            persistenceScoresfromThirtyFive.puttsTaken = Int16(score35puttsTaken)
            persistenceScoresfromThirtyFive.percentage = score35percent
            self.scoresfromThirtyFive.append(persistenceScoresfromThirtyFive)
             PersistenceService.saveContext()

                                                                                let fetchRequest35: NSFetchRequest<ThirtyFiveFeetScores> = ThirtyFiveFeetScores.fetchRequest()
                                                                                do {
                                                                                    let scores35 = try PersistenceService.context.fetch(fetchRequest35)
                                                                                    self.scoresfromThirtyFive = scores35
                                                                                    //   print("scorefromTen: \(scoresfromTen)")
                                                                                    //    self.tableViewForScores.reloadData()
                                                                                } catch { print("Reloading data didn't work, hence the catch 35")}

                let sumOfPuttsTaken35 = scoresfromThirtyFive.reduce(0, {$0 + $1.puttsTaken})
                let average35 = Double(sumOfPuttsTaken35) / Double(scoresfromThirtyFive.count)
                lifeTimeAveragesForPuttsPerLevel.append(Int16(average35))

                /////////////   /////////////   /////////////   /////////////   /////////////   /////////////   ///////////////

                let sumOfScoreTaken35 = scoresfromThirtyFive.reduce(0, {$0 + $1.percentage})
                let average35Score = Double(sumOfScoreTaken35) / Double(scoresfromThirtyFive.count)
                lifeTimeAveragesForScorePerLevel.append(average35Score.rounded())

        }

        let score40puttsTaken = data[6].totalPuttsTaken
        let score40percent = data[6].percentage
        if score40puttsTaken != 0 {
            let persistenceScoresfromForty = FortyFeetScores(context: PersistenceService.context)
            persistenceScoresfromForty.puttsTaken = Int16(score40puttsTaken)
            persistenceScoresfromForty.percentage = score40percent
            self.scoresfromForty.append(persistenceScoresfromForty)
            PersistenceService.saveContext()

                                                                                let fetchRequest40: NSFetchRequest<FortyFeetScores> = FortyFeetScores.fetchRequest()
                                                                                do {
                                                                                    let scores40 = try PersistenceService.context.fetch(fetchRequest40)
                                                                                    self.scoresfromForty = scores40
                                                                                    //   print("scorefromTen: \(scoresfromTen)")
                                                                                    //    self.tableViewForScores.reloadData()
                                                                                } catch { print("Reloading data didn't work, hence the catch 40")}

                let sumOfPuttsTaken40 = scoresfromForty.reduce(0, {$0 + $1.puttsTaken})
                let average40 = Double(sumOfPuttsTaken40) / Double(scoresfromForty.count)
                lifeTimeAveragesForPuttsPerLevel.append(Int16(average40))

                /////////////   /////////////   /////////////   /////////////   /////////////   /////////////   ///////////////

                let sumOfScoreTaken40 = scoresfromForty.reduce(0, {$0 + $1.percentage})
                let average40Score = Double(sumOfScoreTaken40) / Double(scoresfromForty.count)
                lifeTimeAveragesForScorePerLevel.append(average40Score.rounded())

        }

        let score45puttsTaken = data[7].totalPuttsTaken
        let score45percent = data[7].percentage
        if score45puttsTaken != 0 {
            let persistenceScoresfromFortyFive = FortyFiveFeetScores(context: PersistenceService.context)
            persistenceScoresfromFortyFive.puttsTaken = Int16(score45puttsTaken)
            persistenceScoresfromFortyFive.percentage = score45percent
            self.scoresfromFortyFive.append(persistenceScoresfromFortyFive)
            PersistenceService.saveContext()


                                                                                    let fetchRequest45: NSFetchRequest<FortyFiveFeetScores> = FortyFiveFeetScores.fetchRequest()
                                                                                    do {
                                                                                        let scores45 = try PersistenceService.context.fetch(fetchRequest45)
                                                                                        self.scoresfromFortyFive = scores45
                                                                                        //   print("scorefromTen: \(scoresfromTen)")
                                                                                        //    self.tableViewForScores.reloadData()
                                                                                    } catch { print("Reloading data didn't work, hence the catch 45")}

                let sumOfPuttsTaken45 = scoresfromFortyFive.reduce(0, {$0 + $1.puttsTaken})
                let average45 = Double(sumOfPuttsTaken45) / Double(scoresfromFortyFive.count)
                lifeTimeAveragesForPuttsPerLevel.append(Int16(average45))

                /////////////   /////////////   /////////////   /////////////   /////////////   /////////////   ///////////////

                let sumOfScoreTaken45 = scoresfromFortyFive.reduce(0, {$0 + $1.percentage})
                let average45Score = Double(sumOfScoreTaken45) / Double(scoresfromFortyFive.count)
                lifeTimeAveragesForScorePerLevel.append(average45Score.rounded())

        }

        let score50puttsTaken = data[8].totalPuttsTaken
        let score50percent = data[8].percentage
        if score50puttsTaken != 0 {
            let persistenceScoresfromFifty = FiftyFeetScores(context: PersistenceService.context)
            persistenceScoresfromFifty.puttsTaken = Int16(score50puttsTaken)
            persistenceScoresfromFifty.percentage = score50percent
            self.scoresfromFifty.append(persistenceScoresfromFifty)
             PersistenceService.saveContext()


                                                                            let fetchRequest50: NSFetchRequest<FiftyFeetScores> = FiftyFeetScores.fetchRequest()
                                                                            do {
                                                                                let scores50 = try PersistenceService.context.fetch(fetchRequest50)
                                                                                self.scoresfromFifty = scores50
                                                                                //   print("scorefromTen: \(scoresfromTen)")
                                                                                //    self.tableViewForScores.reloadData()
                                                                            } catch { print("Reloading data didn't work, hence the catch 50")}



                let sumOfPuttsTaken50 = scoresfromFifty.reduce(0, {$0 + $1.puttsTaken})
                let average50 = Double(sumOfPuttsTaken50) / Double(scoresfromFifty.count)
                lifeTimeAveragesForPuttsPerLevel.append(Int16(average50))

                /////////////   /////////////   /////////////   /////////////   /////////////   /////////////   ///////////////

                let sumOfScoreTaken50 = scoresfromFifty.reduce(0, {$0 + $1.percentage})
                let average50Score = Double(sumOfScoreTaken50) / Double(scoresfromFifty.count)
                lifeTimeAveragesForScorePerLevel.append(average50Score.rounded())

        }
}


    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        //Use +1 to account for total score taking up index.row = 0
        return cellCount + 1
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            
            if(selectedIndexTotalScore == indexPath.row) {
                return 300;
            } else {
                return 120
            }
        } else {
            
            if(selectedIndex == indexPath.row) {
                return 170;
            } else {
                return 90
            }
        }
     }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        if indexPath.row == 0 {
            
            
            if(selectedIndexTotalScore == indexPath.row) {
                selectedIndexTotalScore = -1
            } else {
                selectedIndexTotalScore = indexPath.row
            }
        } else {
            
            
            if(selectedIndex == indexPath.row) {
                selectedIndex = -1
            } else {
                selectedIndex = indexPath.row
            }
            
            
        }
        

        self.tableViewForScores.beginUpdates()
        self.tableViewForScores.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        self.tableViewForScores.endUpdates()
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            
            var perfectLevelCount = 0
            let levelsPassed = cellCount - 1
           
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "totalScore") as! totalScoreCustomCell
            let awardImageArray = [cell2.awardImage0, cell2.awardImage1, cell2.awardImage2, cell2.awardImage3, cell2.awardImage4, cell2.awardImage5, cell2.awardImage6, cell2.awardImage7, cell2.awardImage8 ]
            for x in 0...8 {
                
                if data[x].percentage > 99 {
                    awardImageArray[x]!.image = UIImage(named: "fire")
                    perfectLevelCount += 1
                }
            }
          
            cell2.totalScoreLabel.text = String(Int((averageScoreForAllAttemptedLevels.rounded() * Double(levelsPassed).rounded())) + Int(bonusPointTotal))
            cell2.averagePercentLabel.text = String(Int(averageScoreForAllAttemptedLevels.rounded()))
            cell2.perfectLevelsLabel.text = String(Int(bonusPointTotal))
            cell2.levelsPassedLabel.text = String(levelsPassed)
            cell2.highScoreLabel.text = String("High Score: \(Int(maxScore))")
           // print("highScore equals _________________: \(maxScore)")

            return cell2
            
            
            
        } else {
            
            let indexReplacement = indexPath.row - 1
            
            print("indexPath.row: \(indexPath.row)___________________________")
            let percentageImage = String(Int((data[indexReplacement].percentage).rounded()))
            let totalputts = String(data[indexReplacement].totalPuttsTaken)
            let distanceLabel = distancesArrayForLabel[indexReplacement]
            let cell = tableView.dequeueReusableCell(withIdentifier: "LevelResultsCell") as! tableViewCellResultsPuttOfWarTableViewCell
            
            cell.distanceLabel.text = distanceLabel
            cell.LevelPercentageImage.image = UIImage(named: "puttMade\(percentageImage)")
            cell.totalPuttsTakenLabel.text = totalputts
        
           
            let TotalScorePlusMinus = data[indexReplacement].percentage.rounded() - lifeTimeAveragesForScorePerLevel[indexReplacement]

            print("TotalScorePlusMinus: \(TotalScorePlusMinus)" )
            let TotalScorePlusMinusInteger = Int(TotalScorePlusMinus)
            if TotalScorePlusMinusInteger > 0 {
                cell.comparisonToAverageScoreLabel.text = "+\(TotalScorePlusMinusInteger)"
                cell.comparisonToAverageScoreLabel.layer.borderColor = UIColor.green.cgColor
                cell.comparisonToAverageScoreLabel.layer.masksToBounds = true
                cell.comparisonToAverageScoreLabel.layer.cornerRadius = 2
                cell.comparisonToAverageScoreLabel.layer.borderWidth = 2
            } else if TotalScorePlusMinusInteger < 0 {
                cell.comparisonToAverageScoreLabel.text = "\(TotalScorePlusMinusInteger)"
                cell.comparisonToAverageScoreLabel.layer.borderColor = UIColor.red.cgColor
                cell.comparisonToAverageScoreLabel.layer.masksToBounds = true
                cell.comparisonToAverageScoreLabel.layer.cornerRadius = 2
                cell.comparisonToAverageScoreLabel.layer.borderWidth = 2

            } else if TotalScorePlusMinusInteger == 0 {
                cell.comparisonToAverageTotalPuttsLabel.text = "---"
                cell.comparisonToAverageTotalPuttsLabel.textColor = UIColor.clear
                cell.comparisonToAverageTotalPuttsLabel.backgroundColor = UIColor.clear
                cell.comparisonToAverageTotalPuttsLabel.layer.borderColor = UIColor.clear.cgColor
                cell.comparisonToAverageTotalPuttsLabel.layer.masksToBounds = true
            }


            let TotalPuttsPlusMinus =  (Double(data[indexReplacement].totalPuttsTaken) - Double(lifeTimeAveragesForPuttsPerLevel[indexReplacement]))
//            print("indexPath.row : \(indexReplacement)")
//            print("lifeTimeAveragesForScorePerLevel count :  \(lifeTimeAveragesForScorePerLevel.count)")
//            print("lifeTimeAveragesForScorePerLevel average :  \(lifeTimeAveragesForScorePerLevel.last)")
//            print("lifeTimeAveragesForScorePerLevel contents :  \(lifeTimeAveragesForScorePerLevel)")

            print(Double(data[indexReplacement].totalPuttsTaken))
            print(Double(lifeTimeAveragesForPuttsPerLevel[indexReplacement]))

            print("\(Double(data[indexReplacement].totalPuttsTaken)) - \(Double(lifeTimeAveragesForPuttsPerLevel[indexReplacement]))")

            let TotalPuttsPlusMinusInteger = Int(TotalPuttsPlusMinus)
            if TotalPuttsPlusMinusInteger > 0 {
                cell.comparisonToAverageTotalPuttsLabel.text = "+\(TotalPuttsPlusMinusInteger)"

                cell.comparisonToAverageTotalPuttsLabel.layer.borderColor = UIColor.red.cgColor
                cell.comparisonToAverageTotalPuttsLabel.layer.masksToBounds = true
                cell.comparisonToAverageTotalPuttsLabel.layer.borderWidth = 2
                 cell.comparisonToAverageTotalPuttsLabel.layer.cornerRadius =  2
            } else if TotalPuttsPlusMinusInteger < 0 {
                cell.comparisonToAverageTotalPuttsLabel.text = "\(TotalPuttsPlusMinusInteger)"
                cell.comparisonToAverageTotalPuttsLabel.layer.borderColor = UIColor.green.cgColor
                cell.comparisonToAverageTotalPuttsLabel.layer.masksToBounds = true
                cell.comparisonToAverageTotalPuttsLabel.layer.borderWidth = 2
                cell.comparisonToAverageTotalPuttsLabel.layer.cornerRadius =  2
            } else if TotalPuttsPlusMinusInteger == 0 {
                cell.comparisonToAverageTotalPuttsLabel.text = "---"
                cell.comparisonToAverageTotalPuttsLabel.textColor = UIColor.clear
                cell.comparisonToAverageTotalPuttsLabel.backgroundColor = UIColor.clear
                cell.comparisonToAverageTotalPuttsLabel.layer.borderColor = UIColor.clear.cgColor
                cell.comparisonToAverageTotalPuttsLabel.layer.masksToBounds = true
            }

            if data[indexReplacement].percentage == 100 {
                cell.awardImage.image = UIImage(named: "fire")
            } else {
                cell.awardImage.image = nil
            }

            let AveragepercentageImage = String(Int(lifeTimeAveragesForScorePerLevel[indexReplacement]))
            cell.LevelAverageImage.image = UIImage(named: "puttMade\(AveragepercentageImage)")
            cell.AverageTotalPuttsLabel.text = String(Int(lifeTimeAveragesForPuttsPerLevel[indexReplacement]))
            return cell
            }
        
            
        }
    
    

}

        
        

