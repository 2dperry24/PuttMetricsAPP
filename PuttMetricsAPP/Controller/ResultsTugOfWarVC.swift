//
//  ResultsTugOfWarViewController.swift
//  PuttMetricsAPP
//
//  Created by User on 12/7/17.
//  Copyright © 2017 DustinPerry. All rights reserved.
//

import UIKit
import SVProgressHUD
import CoreData




class ResultsTugOfWarVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    
    @IBOutlet weak var AverageScoreLabel: UILabel!
    @IBOutlet weak var levelsPassedLabel: UILabel!
    
    @IBOutlet weak var awardImage0: UIImageView!
    @IBOutlet weak var awardImage1: UIImageView!
    @IBOutlet weak var awardImage2: UIImageView!
    @IBOutlet weak var awardImage3: UIImageView!
    @IBOutlet weak var awardImage4: UIImageView!
    @IBOutlet weak var awardImage5: UIImageView!
    @IBOutlet weak var awardImage6: UIImageView!
    @IBOutlet weak var awardImage7: UIImageView!
    @IBOutlet weak var awardImage8: UIImageView!
    
    var awardImageArray = [UIImageView]()
  

    @IBOutlet weak var totalScoreLabel: UILabel!
    
    @IBOutlet weak var tableViewForScores: UITableView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    
//
//    @IBAction func saveResults(_ sender: Any) {
//       let score10puttsTaken = Int16(scoresfromTen_TotalPutts[scoresfromTen_TotalPutts.count - 1])
//        let persistentScoresFrom10 = Score(context: PersistenceService.context)
//        persistentScoresFrom10.totalPutts = score10puttsTaken as NSObject
//       PersistenceService.saveContext()
//       scoresfromTen_TotalPutts
//      PersistentScore10puttsTaken.append(persistentScoresFrom10)
//
//    }
//
    
    
    
    
    
    
    
    
    
    
    
    var distancesArrayForLabel = ["10'", "15'","20'","25'","30'","35'","40'","45'","50'","Champion"]
    
    var cellCount = 0
    //selectedIndex is for expandable Cell in tableView.
    var selectedIndex = -1
    var lifeTimeAveragesForPuttsPerLevel = [Int16] ()
    var lifeTimeAveragesForScorePerLevel = [Double] ()
    
    var data = [DistanceScoring]()
    var resultsForScoringArray = [DistanceScoring]()
    
//    var allScoresRetrievedFromCoreData = [Score]()
    
    
    
    
    
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
   //   var scoresfromFiftyFive = [FiftyFiveFeetScores]()
   //   var scoresfromSixty = [SixtyFeetScores]()
 

   
    
  var sumOfScores : Double = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
                SVProgressHUD.show()
                SVProgressHUD.dismiss(withDelay: 3)
        
                data = resultsForScoringArray
        
                getTotalScoreForRound()
        
        
        
        
                    let fetchRequestTotalScores: NSFetchRequest<TotalScores> = TotalScores.fetchRequest()
                    do {
                        let scoresTotal = try PersistenceService.context.fetch(fetchRequestTotalScores)
                        self.totalScores = scoresTotal
                        //   print("scorefromTen: \(scoresfromTen)")
                        //    self.tableViewForScores.reloadData()
                    } catch { print("Reloading data didn't work, hence the catch 10")}
        
        
        
        
        
        
        
                let fetchRequest: NSFetchRequest<TenFeetScores> = TenFeetScores.fetchRequest()
                do {
                    let scores10 = try PersistenceService.context.fetch(fetchRequest)
                    self.scoresfromTen = scores10
                 //   print("scorefromTen: \(scoresfromTen)")
                //    self.tableViewForScores.reloadData()
                    } catch { print("Reloading data didn't work, hence the catch 10")}
        
        
                let fetchRequest15: NSFetchRequest<FifteenFeetScores> = FifteenFeetScores.fetchRequest()
                do {
                            let scores15 = try PersistenceService.context.fetch(fetchRequest15)
                            self.scoresfromFifteen = scores15
                        //   print("scorefromTen: \(scoresfromTen)")
                        //    self.tableViewForScores.reloadData()
                    } catch { print("Reloading data didn't work, hence the catch 15")}
        
                let fetchRequest20: NSFetchRequest<TwentyFeetScores> = TwentyFeetScores.fetchRequest()
                do {
                    let scores20 = try PersistenceService.context.fetch(fetchRequest20)
                    self.scoresfromTwenty = scores20
                    //   print("scorefromTen: \(scoresfromTen)")
                    //    self.tableViewForScores.reloadData()
                } catch { print("Reloading data didn't work, hence the catch 20")}
        
                let fetchRequest25: NSFetchRequest<TwentyFiveFeetScores> = TwentyFiveFeetScores.fetchRequest()
                do {
                    let scores25 = try PersistenceService.context.fetch(fetchRequest25)
                    self.scoresfromTwentyFive = scores25
                    //   print("scorefromTen: \(scoresfromTen)")
                    //    self.tableViewForScores.reloadData()
                } catch { print("Reloading data didn't work, hence the catch 25")}
        
                let fetchRequest30: NSFetchRequest<ThirtyFeetScores> = ThirtyFeetScores.fetchRequest()
                do {
                    let scores30 = try PersistenceService.context.fetch(fetchRequest30)
                    self.scoresfromThirty = scores30
                    //   print("scorefromTen: \(scoresfromTen)")
                    //    self.tableViewForScores.reloadData()
                } catch { print("Reloading data didn't work, hence the catch 30")}
        
                let fetchRequest35: NSFetchRequest<ThirtyFiveFeetScores> = ThirtyFiveFeetScores.fetchRequest()
                do {
                    let scores35 = try PersistenceService.context.fetch(fetchRequest35)
                    self.scoresfromThirtyFive = scores35
                    //   print("scorefromTen: \(scoresfromTen)")
                    //    self.tableViewForScores.reloadData()
                } catch { print("Reloading data didn't work, hence the catch 35")}
        
                let fetchRequest40: NSFetchRequest<FortyFeetScores> = FortyFeetScores.fetchRequest()
                do {
                    let scores40 = try PersistenceService.context.fetch(fetchRequest40)
                    self.scoresfromForty = scores40
                    //   print("scorefromTen: \(scoresfromTen)")
                    //    self.tableViewForScores.reloadData()
                } catch { print("Reloading data didn't work, hence the catch 40")}
        
                let fetchRequest45: NSFetchRequest<FortyFiveFeetScores> = FortyFiveFeetScores.fetchRequest()
                do {
                    let scores45 = try PersistenceService.context.fetch(fetchRequest45)
                    self.scoresfromFortyFive = scores45
                    //   print("scorefromTen: \(scoresfromTen)")
                    //    self.tableViewForScores.reloadData()
                } catch { print("Reloading data didn't work, hence the catch 45")}
        
                let fetchRequest50: NSFetchRequest<FiftyFeetScores> = FiftyFeetScores.fetchRequest()
                do {
                    let scores50 = try PersistenceService.context.fetch(fetchRequest50)
                    self.scoresfromFifty = scores50
                    //   print("scorefromTen: \(scoresfromTen)")
                    //    self.tableViewForScores.reloadData()
                } catch { print("Reloading data didn't work, hence the catch 50")}
        
//                let fetchRequest55: NSFetchRequest<FiftyFiveFeetScores> = FiftyFiveFeetScores.fetchRequest()
//                do {
//                    let scores55 = try PersistenceService.context.fetch(fetchRequest55)
//                    self.scoresfromFiftyFive = scores55
//                    //   print("scorefromTen: \(scoresfromTen)")
//                    //    self.tableViewForScores.reloadData()
//                } catch { print("Reloading data didn't work, hence the catch 55")}
//
//                let fetchRequest60: NSFetchRequest<SixtyFeetScores> = SixtyFeetScores.fetchRequest()
//                do {
//                    let scores60 = try PersistenceService.context.fetch(fetchRequest60)
//                    self.scoresfromSixty = scores60
//                    //   print("scorefromTen: \(scoresfromTen)")
//                    //    self.tableViewForScores.reloadData()
//                } catch { print("Reloading data didn't work, hence the catch 60")}
//
//
        
        
        
        putScoresIntoEachDistaceArray()
   
    
      tableViewForScores.delegate = self
        tableViewForScores.dataSource = self
  //   tableViewHeightConstraint.constant = self.view.frame.height
      
      
        
   

        
    }

    
    
    
    
    
    //TODO: FIX THIS CODE, There has to be a more consice way of doing this.
    
    func getTotalScoreForRound() -> Double {
        let levelsPassed = cellCount - 1
        sumOfScores = data[0].percentage + data[1].percentage + data[2].percentage + data[3].percentage + data[4].percentage + data[5].percentage + data[6].percentage + data[7].percentage + data[8].percentage 
    
       awardImageArray.append(contentsOf: [awardImage0, awardImage1, awardImage2, awardImage3, awardImage4, awardImage5, awardImage6, awardImage7, awardImage8])
        for index in 0...8 {
            if data[index].percentage > 90 {
                awardImageArray[index].image = UIImage(named: "gold-medal-1")
            } else if data[index].percentage > 80 && data[index].percentage < 90{
                awardImageArray[index].image = UIImage(named: "silver-medal")
            } else if data[index].percentage > 70 && data[index].percentage < 80 {
                awardImageArray[index].image = UIImage(named: "bronze-medal")
            }
            levelsPassedLabel.text = String(levelsPassed)
            
        }
        
        
        let averageScore = Int(sumOfScores / Double(cellCount - 1 ))
        AverageScoreLabel.text = String(averageScore)
        print ("sumOfScores: \(sumOfScores)")
        totalScoreLabel.text = String(Int(Double(averageScore) * Double(levelsPassed)))
        return sumOfScores
        
        
        
    }
    
  
    
    
    // MARK: Funcs for getting averages for levels over time.
//    func calculateLifeTimeAveragesForEachLevel_PuttAttemts() -> Int16 {
//
//        var totalSumfor10average: Int16 = 0
//        for number in 0..<(scoresfromTen.count) {
//        let sum = scoresfromTen[number].puttsTaken
//        totalSumfor10average += sum
//            print("current sum: \(totalSumfor10average)")
//        }
//        let average = Double(totalSumfor10average) / Double(scoresfromTen.count)
//        if average > 0 && average < 1000 {
//             return Int16(average)
//        } else {
//            return 0
//        }
//
//    }
//
//    func calculateLifeTimeAveragesForEachLevel_Score(element: [NSManagedObject]) -> Double {
//
//        var totalSumfor10average: Double = 0
//        for number in 0..<(element.count) {
//            let sum = element[number].percentage
//            totalSumfor10average += sum
//            print("current sum of Percents: \(totalSumfor10average)")
//        }
//        let average = Double(totalSumfor10average) / Double(element.count)
//        if average > -1 && average < 101 {
//            return average
//        } else {
//            return 0
//        }
//
//    }
//
    
    
    
    
    
    
    // These arrays hold values for longterm calculation comparisons. If putts taken = 0 then we wont add score to the array using an if statement.
    
    func putScoresIntoEachDistaceArray() {

        
        
        let totalScoreForThatAttempt =  getTotalScoreForRound()
        if totalScoreForThatAttempt != 0 {
            let persistenceTotalScores = TotalScores(context: PersistenceService.context)
             persistenceTotalScores.total = totalScoreForThatAttempt
            PersistenceService.saveContext()
            self.totalScores.append(persistenceTotalScores)
    
        }
        
        
        let score10puttsTaken = data[0].totalPuttsTaken
        let score10percent = data[0].percentage
        if score10puttsTaken != 0 {
        let persistenceScoresfromTen = TenFeetScores(context: PersistenceService.context)
        persistenceScoresfromTen.puttsTaken = Int16(score10puttsTaken)
        persistenceScoresfromTen.percentage = score10percent
        PersistenceService.saveContext()
        self.scoresfromTen.append(persistenceScoresfromTen)

            let sumOfPuttsTaken = scoresfromTen.reduce(0, {$0 + $1.puttsTaken})
            let average10 = Double(sumOfPuttsTaken) / Double(scoresfromTen.count)
            print("average putts taken from 10' : \(Int16(average10))")
            lifeTimeAveragesForPuttsPerLevel.append(Int16(average10))
     
            /////////////   /////////////   /////////////   /////////////   /////////////   /////////////   ///////////////
            
            let sumOfScoreTaken = scoresfromTen.reduce(0, {$0 + $1.percentage})
            let average10Score = Double(sumOfScoreTaken) / Double(scoresfromTen.count)
             print("current average of Percents: \(average10Score)")
            lifeTimeAveragesForScorePerLevel.append(average10Score)
            print("10 append \( lifeTimeAveragesForScorePerLevel.last)")
            
            
    }

        let score15puttsTaken = data[1].totalPuttsTaken
        let score15percent = data[1].percentage
        if score15puttsTaken != 0 {
            let persistenceScoresfromFifteen = FifteenFeetScores(context: PersistenceService.context)
            persistenceScoresfromFifteen.puttsTaken = Int16(score15puttsTaken)
            persistenceScoresfromFifteen.percentage = score15percent
            PersistenceService.saveContext()
            self.scoresfromFifteen.append(persistenceScoresfromFifteen)
            
                let sumOfPuttsTaken15 = scoresfromFifteen.reduce(0, {$0 + $1.puttsTaken})
                let average15 = Double(sumOfPuttsTaken15) / Double(scoresfromFifteen.count)
                lifeTimeAveragesForPuttsPerLevel.append(Int16(average15))
            
                /////////////   /////////////   /////////////   /////////////   /////////////   /////////////   ///////////////
            
                let sumOfScoreTaken15 = scoresfromFifteen.reduce(0, {$0 + $1.percentage})
                let average15Score = Double(sumOfScoreTaken15) / Double(scoresfromFifteen.count)
                lifeTimeAveragesForScorePerLevel.append(average15Score)
                print("15 append \( lifeTimeAveragesForScorePerLevel.last)")
        }
        
        let score20puttsTaken = data[2].totalPuttsTaken
        let score20percent = data[2].percentage
        if score20puttsTaken != 0 {
            let persistenceScoresfromTwenty = TwentyFeetScores(context: PersistenceService.context)
            persistenceScoresfromTwenty.puttsTaken = Int16(score20puttsTaken)
            persistenceScoresfromTwenty.percentage = score20percent
            PersistenceService.saveContext()
            self.scoresfromTwenty.append(persistenceScoresfromTwenty)
            
                let sumOfPuttsTaken20 = scoresfromTwenty.reduce(0, {$0 + $1.puttsTaken})
                let average20 = Double(sumOfPuttsTaken20) / Double(scoresfromTwenty.count)
                lifeTimeAveragesForPuttsPerLevel.append(Int16(average20))
            
                /////////////   /////////////   /////////////   /////////////   /////////////   /////////////   ///////////////
            
                let sumOfScoreTaken20 = scoresfromTwenty.reduce(0, {$0 + $1.percentage})
                let average20Score = Double(sumOfScoreTaken20) / Double(scoresfromTwenty.count)
                lifeTimeAveragesForScorePerLevel.append(average20Score)
              print("20 append \( lifeTimeAveragesForScorePerLevel.last)")
        }
        
        let score25puttsTaken = data[3].totalPuttsTaken
        let score25percent = data[3].percentage
        if score25puttsTaken != 0 {
            let persistenceScoresfromTwentyFive = TwentyFiveFeetScores(context: PersistenceService.context)
            persistenceScoresfromTwentyFive.puttsTaken = Int16(score25puttsTaken)
            persistenceScoresfromTwentyFive.percentage = score25percent
            PersistenceService.saveContext()
            self.scoresfromTwentyFive.append(persistenceScoresfromTwentyFive)
            
                let sumOfPuttsTaken25 = scoresfromTwentyFive.reduce(0, {$0 + $1.puttsTaken})
                let average25 = Double(sumOfPuttsTaken25) / Double(scoresfromTwentyFive.count)
                lifeTimeAveragesForPuttsPerLevel.append(Int16(average25))
            
                /////////////   /////////////   /////////////   /////////////   /////////////   /////////////   ///////////////
            
                let sumOfScoreTaken25 = scoresfromTwentyFive.reduce(0, {$0 + $1.percentage})
                let average25Score = Double(sumOfScoreTaken25) / Double(scoresfromTwentyFive.count)
                lifeTimeAveragesForScorePerLevel.append(average25Score)
            
        }
        
        let score30puttsTaken = data[4].totalPuttsTaken
        let score30percent = data[4].percentage
        if score30puttsTaken != 0 {
            let persistenceScoresfromThirty = ThirtyFeetScores(context: PersistenceService.context)
            persistenceScoresfromThirty.puttsTaken = Int16(score30puttsTaken)
            persistenceScoresfromThirty.percentage = score30percent
            PersistenceService.saveContext()
            self.scoresfromThirty.append(persistenceScoresfromThirty)
            
                let sumOfPuttsTaken30 = scoresfromThirty.reduce(0, {$0 + $1.puttsTaken})
                let average30 = Double(sumOfPuttsTaken30) / Double(scoresfromThirty.count)
                lifeTimeAveragesForPuttsPerLevel.append(Int16(average30))
            
                /////////////   /////////////   /////////////   /////////////   /////////////   /////////////   ///////////////
            
                let sumOfScoreTaken30 = scoresfromThirty.reduce(0, {$0 + $1.percentage})
                let average30Score = Double(sumOfScoreTaken30) / Double(scoresfromThirty.count)
                lifeTimeAveragesForScorePerLevel.append(average30Score)
            
        }
        
        let score35puttsTaken = data[5].totalPuttsTaken
        let score35percent = data[5].percentage
        if score35puttsTaken != 0 {
            let persistenceScoresfromThirtyFive = ThirtyFiveFeetScores(context: PersistenceService.context)
            persistenceScoresfromThirtyFive.puttsTaken = Int16(score35puttsTaken)
            persistenceScoresfromThirtyFive.percentage = score35percent
            PersistenceService.saveContext()
            self.scoresfromThirtyFive.append(persistenceScoresfromThirtyFive)
            
                let sumOfPuttsTaken35 = scoresfromThirtyFive.reduce(0, {$0 + $1.puttsTaken})
                let average35 = Double(sumOfPuttsTaken35) / Double(scoresfromThirtyFive.count)
                lifeTimeAveragesForPuttsPerLevel.append(Int16(average35))
            
                /////////////   /////////////   /////////////   /////////////   /////////////   /////////////   ///////////////
            
                let sumOfScoreTaken35 = scoresfromThirtyFive.reduce(0, {$0 + $1.percentage})
                let average35Score = Double(sumOfScoreTaken35) / Double(scoresfromThirtyFive.count)
                lifeTimeAveragesForScorePerLevel.append(average35Score)
            
        }
        
        let score40puttsTaken = data[6].totalPuttsTaken
        let score40percent = data[6].percentage
        if score40puttsTaken != 0 {
            let persistenceScoresfromForty = FortyFeetScores(context: PersistenceService.context)
            persistenceScoresfromForty.puttsTaken = Int16(score40puttsTaken)
            persistenceScoresfromForty.percentage = score40percent
            PersistenceService.saveContext()
            self.scoresfromForty.append(persistenceScoresfromForty)
            
                let sumOfPuttsTaken40 = scoresfromForty.reduce(0, {$0 + $1.puttsTaken})
                let average40 = Double(sumOfPuttsTaken40) / Double(scoresfromForty.count)
                lifeTimeAveragesForPuttsPerLevel.append(Int16(average40))
            
                /////////////   /////////////   /////////////   /////////////   /////////////   /////////////   ///////////////
            
                let sumOfScoreTaken40 = scoresfromForty.reduce(0, {$0 + $1.percentage})
                let average40Score = Double(sumOfScoreTaken40) / Double(scoresfromForty.count)
                lifeTimeAveragesForScorePerLevel.append(average40Score)
            
        }
        
        let score45puttsTaken = data[7].totalPuttsTaken
        let score45percent = data[7].percentage
        if score45puttsTaken != 0 {
            let persistenceScoresfromFortyFive = FortyFiveFeetScores(context: PersistenceService.context)
            persistenceScoresfromFortyFive.puttsTaken = Int16(score45puttsTaken)
            persistenceScoresfromFortyFive.percentage = score45percent
            PersistenceService.saveContext()
            self.scoresfromFortyFive.append(persistenceScoresfromFortyFive)
            
                let sumOfPuttsTaken45 = scoresfromFortyFive.reduce(0, {$0 + $1.puttsTaken})
                let average45 = Double(sumOfPuttsTaken45) / Double(scoresfromFortyFive.count)
                lifeTimeAveragesForPuttsPerLevel.append(Int16(average45))
            
                /////////////   /////////////   /////////////   /////////////   /////////////   /////////////   ///////////////
            
                let sumOfScoreTaken45 = scoresfromFortyFive.reduce(0, {$0 + $1.percentage})
                let average45Score = Double(sumOfScoreTaken45) / Double(scoresfromFortyFive.count)
                lifeTimeAveragesForScorePerLevel.append(average45Score)
            
        }
        
        let score50puttsTaken = data[8].totalPuttsTaken
        let score50percent = data[8].percentage
        if score50puttsTaken != 0 {
            let persistenceScoresfromFifty = FiftyFeetScores(context: PersistenceService.context)
            persistenceScoresfromFifty.puttsTaken = Int16(score50puttsTaken)
            persistenceScoresfromFifty.percentage = score50percent
            PersistenceService.saveContext()
            self.scoresfromFifty.append(persistenceScoresfromFifty)
            
                let sumOfPuttsTaken50 = scoresfromFifty.reduce(0, {$0 + $1.puttsTaken})
                let average50 = Double(sumOfPuttsTaken50) / Double(scoresfromFifty.count)
                lifeTimeAveragesForPuttsPerLevel.append(Int16(average50))
            
                /////////////   /////////////   /////////////   /////////////   /////////////   /////////////   ///////////////
            
                let sumOfScoreTaken50 = scoresfromFifty.reduce(0, {$0 + $1.percentage})
                let average50Score = Double(sumOfScoreTaken50) / Double(scoresfromFifty.count)
                lifeTimeAveragesForScorePerLevel.append(average50Score)
            
        }
        
//        let score55puttsTaken = data[9].totalPuttsTaken
//        let score55percent = data[9].percentage
//        if score55puttsTaken != 0 {
//            let persistenceScoresfromFiftyFive = FiftyFiveFeetScores(context: PersistenceService.context)
//            persistenceScoresfromFiftyFive.puttsTaken = Int16(score55puttsTaken)
//            persistenceScoresfromFiftyFive.percentage = score55percent
//            PersistenceService.saveContext()
//            self.scoresfromFiftyFive.append(persistenceScoresfromFiftyFive)
//
//                let sumOfPuttsTaken55 = scoresfromFiftyFive.reduce(0, {$0 + $1.puttsTaken})
//                let average55 = Double(sumOfPuttsTaken55) / Double(scoresfromFiftyFive.count)
//                lifeTimeAveragesForPuttsPerLevel.append(Int16(average55))
//
//                /////////////   /////////////   /////////////   /////////////   /////////////   /////////////   ///////////////
//
//                let sumOfScoreTaken55 = scoresfromFiftyFive.reduce(0, {$0 + $1.percentage})
//                let average55Score = Double(sumOfScoreTaken55) / Double(scoresfromFiftyFive.count)
//                lifeTimeAveragesForScorePerLevel.append(average55Score)
//
//        }
//
//        let score60puttsTaken = data[10].totalPuttsTaken
//        let score60percent = data[10].percentage
//        if score60puttsTaken != 0 {
//            let persistenceScoresfromSixty = SixtyFeetScores(context: PersistenceService.context)
//            persistenceScoresfromSixty.puttsTaken = Int16(score60puttsTaken)
//            persistenceScoresfromSixty.percentage = score60percent
//            PersistenceService.saveContext()
//            self.scoresfromSixty.append(persistenceScoresfromSixty)
//
//                let sumOfPuttsTaken60 = scoresfromSixty.reduce(0, {$0 + $1.puttsTaken})
//                let average60 = Double(sumOfPuttsTaken60) / Double(scoresfromSixty.count)
//                lifeTimeAveragesForPuttsPerLevel.append(Int16(average60))
//
//                /////////////   /////////////   /////////////   /////////////   /////////////   /////////////   ///////////////
//
//                let sumOfScoreTaken60 = scoresfromSixty.reduce(0, {$0 + $1.percentage})
//                let average60Score = Double(sumOfScoreTaken60) / Double(scoresfromSixty.count)
//                lifeTimeAveragesForScorePerLevel.append(average60Score)
//
//        }
}
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellCount
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(selectedIndex == indexPath.row) {
            return 150;
        } else {
            return 90
        }
     }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(selectedIndex == indexPath.row) {
            selectedIndex = -1
        } else {
            selectedIndex = indexPath.row
        }
        self.tableViewForScores.beginUpdates()
        self.tableViewForScores.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        self.tableViewForScores.endUpdates()
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("indexPath.row: \(indexPath.row)___________________________")
        let percentageImage = String(data[indexPath.row].percentage)
        let totalputts = String(data[indexPath.row].totalPuttsTaken)
        let distanceLabel = distancesArrayForLabel[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "LevelResultsCell") as! tableViewCellResultsPuttOfWarTableViewCell
        
        cell.distanceLabel.text = distanceLabel
        cell.LevelPercentageImage.image = UIImage(named: "puttMade\(percentageImage)")
        cell.totalPuttsTakenLabel.text = totalputts
        
        // only adding in to check persistent data workability
        let TotalScorePlusMinus = data[indexPath.row].percentage - lifeTimeAveragesForScorePerLevel[indexPath.row]
        
        print("TotalScorePlusMinus: \(TotalScorePlusMinus)" )
         let TotalScorePlusMinusInteger = Int(TotalScorePlusMinus)
        if TotalScorePlusMinusInteger > 0 {
            cell.comparisonToAverageScoreLabel.text = "+\(TotalScorePlusMinusInteger)"
            cell.comparisonToAverageScoreLabel.textColor = UIColor.white
            cell.comparisonToAverageScoreLabel.backgroundColor = UIColor.green
            cell.comparisonToAverageScoreLabel.layer.masksToBounds = true
            cell.comparisonToAverageScoreLabel.layer.cornerRadius = 5
        } else if TotalScorePlusMinusInteger < 0 {
            cell.comparisonToAverageScoreLabel.text = "\(TotalScorePlusMinusInteger)"
            cell.comparisonToAverageScoreLabel.textColor = UIColor.white
            cell.comparisonToAverageScoreLabel.backgroundColor = UIColor.red
            cell.comparisonToAverageScoreLabel.layer.masksToBounds = true
            cell.comparisonToAverageScoreLabel.layer.cornerRadius = 5
        } else if TotalScorePlusMinusInteger == 0 {
            cell.comparisonToAverageScoreLabel.text = "---"
            cell.comparisonToAverageScoreLabel.textColor = UIColor.clear
            cell.comparisonToAverageScoreLabel.backgroundColor = UIColor.clear
            
        }
        
        
       let TotalPuttsPlusMinus =  (Double(data[indexPath.row].totalPuttsTaken) - Double(lifeTimeAveragesForPuttsPerLevel[indexPath.row]))
        print("indexPath.row : \(indexPath.row)")
        print("lifeTimeAveragesForScorePerLevel count :  \(lifeTimeAveragesForScorePerLevel.count)")
         print("lifeTimeAveragesForScorePerLevel average :  \(lifeTimeAveragesForScorePerLevel.last)")
         print("lifeTimeAveragesForScorePerLevel contents :  \(lifeTimeAveragesForScorePerLevel)")
        print("\(Double(data[indexPath.row].totalPuttsTaken)) - \(Double(lifeTimeAveragesForPuttsPerLevel[indexPath.row]))")
        
        let TotalPuttsPlusMinusInteger = Int(TotalPuttsPlusMinus)
        if TotalPuttsPlusMinusInteger > 0 {
            cell.comparisonToAverageTotalPuttsLabel.text = "+\(TotalPuttsPlusMinusInteger)"
            cell.comparisonToAverageTotalPuttsLabel.textColor = UIColor.white
            cell.comparisonToAverageTotalPuttsLabel.backgroundColor = UIColor.red
            cell.comparisonToAverageTotalPuttsLabel.layer.masksToBounds = true
            cell.comparisonToAverageTotalPuttsLabel.layer.cornerRadius = 5
        } else if TotalPuttsPlusMinusInteger < 0 {
            cell.comparisonToAverageTotalPuttsLabel.text = "\(TotalPuttsPlusMinusInteger)"
            cell.comparisonToAverageTotalPuttsLabel.textColor = UIColor.white
            cell.comparisonToAverageTotalPuttsLabel.backgroundColor = UIColor.green
            cell.comparisonToAverageTotalPuttsLabel.layer.masksToBounds = true
            cell.comparisonToAverageTotalPuttsLabel.layer.cornerRadius = 5
        } else if TotalPuttsPlusMinusInteger == 0{
            cell.comparisonToAverageTotalPuttsLabel.text = "---"
            cell.comparisonToAverageTotalPuttsLabel.textColor = UIColor.clear
            cell.comparisonToAverageTotalPuttsLabel.backgroundColor = UIColor.clear
            
        }
     
        if data[indexPath.row].percentage > 90 {
            cell.awardImage.image = UIImage(named: "gold-medal-1")
        } else if data[indexPath.row].percentage > 80 && data[indexPath.row].percentage < 90{
            cell.awardImage.image = UIImage(named: "silver-medal")
        } else if data[indexPath.row].percentage > 70 && data[indexPath.row].percentage < 80 {
            cell.awardImage.image = UIImage(named: "bronze-medal")
        }
        
        
         let AveragepercentageImage = String(Int(lifeTimeAveragesForScorePerLevel[indexPath.row]))
         cell.LevelAverageImage.image = UIImage(named: "puttMade\(AveragepercentageImage)")
       cell.AverageTotalPuttsLabel.text = String(Int(lifeTimeAveragesForPuttsPerLevel[indexPath.row]))
        return cell
    }
    
}
