//
//  ResultsTugOfWarViewController.swift
//  PuttMetricsAPP
//
//  Created by User on 12/7/17.
//  Copyright © 2017 DustinPerry. All rights reserved.
//

import UIKit
import SVProgressHUD





class ResultsTugOfWarVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

 
    @IBOutlet weak var tableViewForScores: UITableView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    
    var distancesArrayForLabel = ["10'", "15'","20'","25'","30'","35'","40'","45'","50'","55'","60'","Champion"]
    
    var cellCount = 0
    

    var data = [DistanceScoring]()
    var resultsForScoringArray = [DistanceScoring]()
   
    var scoresfromTen_Percentage = [Double]()
    var scoresfromTen_TotalPutts = [Int]()
    var scoresfromFifteen_Percentage = [Double]()
    var scoresfromFifteen_TotalPutts = [Int]()
    var scoresfromTwenty_Percentage = [Double]()
    var scoresfromTwenty_TotalPutts = [Int]()
    var scoresfromTwentyFive_Percentage = [Double]()
    var scoresfromTwentyFive_TotalPutts = [Int]()
    var scoresfromThirty_Percentage = [Double]()
    var scoresfromThirty_TotalPutts = [Int]()
    var scoresfromThirtyFive_Percentage = [Double]()
    var scoresfromThirtyFive_TotalPutts = [Int]()
    var scoresfromForty_Percentage = [Double]()
    var scoresfromForty_TotalPutts = [Int]()
    var scoresfromFortyFive_Percentage = [Double]()
    var scoresfromFortyFive_TotalPutts = [Int]()
    var scoresfromFifty_Percentage = [Double]()
    var scoresfromFifty_TotalPutts = [Int]()
    var scoresfromFiftyFive_Percentage = [Double]()
    var scoresfromFiftyFive_TotalPutts = [Int]()
    var scoresfromSixty_Percentage = [Double]()
    var scoresfromSixty_TotalPutts = [Int]()
    
    
    
    
    
    
    
    
    
    
    
    
    var sumOfScores : Double = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
SVProgressHUD.show()
    SVProgressHUD.dismiss(withDelay: 3)
        
    // Setting the tableView height
      tableViewForScores.delegate = self
        tableViewForScores.dataSource = self
     tableViewHeightConstraint.constant = self.view.frame.height * (2/3)
        tableViewForScores.rowHeight = 100
        
      data = resultsForScoringArray
       getTotalScoreForRound()
      putScoresIntoEachDistaceArray()
        
//        print(scoresfromTen.per)
//
//      totalScoreLabel.text = String(format: "%.0f", sumOfScores)
//        // Do any additional setup after loading the view.
//
//        assignScoresToLevels()
//        assignImages()
//
        
    }

    
    
    
    
    
    //TODO: FIX THIS CODE, There has to be a more consice way of doing this.
    
    func getTotalScoreForRound() {
        
       sumOfScores = data.reduce(0.0) { $0 + ($1.percentage) }

         print("Total Points: \(sumOfScores)")
        
        
    }

    
    
    // These arrays hold values for longterm calculation comparisons
    
    func putScoresIntoEachDistaceArray() {

        scoresfromTen_Percentage.append(data[0].percentage)
        scoresfromTen_TotalPutts.append(data[0].totalPuttsTaken)
        
        scoresfromFifteen_Percentage.append(data[1].percentage)
        scoresfromFifteen_TotalPutts.append(data[1].totalPuttsTaken)
        
        scoresfromTwenty_Percentage.append(data[2].percentage)
        scoresfromTwenty_TotalPutts.append(data[2].totalPuttsTaken)
        
        scoresfromTwentyFive_Percentage.append(data[3].percentage)
        scoresfromTwentyFive_TotalPutts.append(data[3].totalPuttsTaken)
        
        scoresfromThirty_Percentage.append(data[4].percentage)
        scoresfromThirty_TotalPutts.append(data[4].totalPuttsTaken)
        
        scoresfromThirtyFive_Percentage.append(data[5].percentage)
        scoresfromThirtyFive_TotalPutts.append(data[5].totalPuttsTaken)
        
        scoresfromForty_Percentage.append(data[6].percentage)
        scoresfromForty_TotalPutts.append(data[6].totalPuttsTaken)
        
        scoresfromFortyFive_Percentage.append(data[7].percentage)
        scoresfromFortyFive_TotalPutts.append(data[7].totalPuttsTaken)
        
        scoresfromFifty_Percentage.append(data[8].percentage)
        scoresfromFifty_TotalPutts.append(data[8].totalPuttsTaken)
        
        scoresfromFiftyFive_Percentage.append(data[9].percentage)
        scoresfromFiftyFive_TotalPutts.append(data[9].totalPuttsTaken)
        
        scoresfromSixty_Percentage.append(data[10].percentage)
        scoresfromSixty_TotalPutts.append(data[10].totalPuttsTaken)
        
        
        
        
        
     

        print(scoresfromTen_TotalPutts.last!)


    }

    


   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellCount
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let percentageImage = String(data[indexPath.row].percentage)
        let totalputts = String(data[indexPath.row].totalPuttsTaken)
        let distanceLabel = distancesArrayForLabel[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "LevelResultsCell") as! tableViewCellResultsPuttOfWarTableViewCell
        
        cell.distanceLabel.text = distanceLabel
        cell.LevelPercentageImage.image = UIImage(named: "puttMade\(percentageImage)")
        cell.totalPuttsTakenLabel.text = totalputts
        
        return cell
        
    }

}
