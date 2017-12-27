//
//  GraphsForTotalScore.swift
//  PuttMetricsAPP
//
//  Created by User on 12/26/17.
//  Copyright © 2017 DustinPerry. All rights reserved.
//

import UIKit
import CoreData

class GraphsForTotalScore: UIViewController, UITableViewDelegate, UITableViewDataSource{

    
    
    var segmentIndex = 0
    @objc var totalScores = [TotalScores]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
       coreDataSortedByTotal()
        
       
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        print("FromGRAPHSVC: \(totalScores.count))")
        
    }
   
    
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TotalScoresDisplayed") as! chartsVCcustomcell
        
        
      
        
        cell.totalScoreLabel.text = String(Int(totalScores[indexPath.row].total))
        
      //  cell.windDirectionIndexLabel.text = String(totalScores[indexPath.row].windDirection)
        
        if let dateToUse = totalScores[indexPath.row].date {
            
            cell.dateLabel.text = transformDate(date: dateToUse)
           
        return cell
        } else {
            return cell
        }
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return totalScores.count
    }
    
    
    
    
    func transformDate (date: NSDate) -> String {
        
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date as Date)
        let month = calendar.component(.month, from: date as Date)
        let year = calendar.component(.year, from: date as Date)
     
        return String("\(month)/\(day)/\(year)")
    }
   
    
    
    
    func coreDataSortedByTotal() {
        
        let fetchRequestTotalScores: NSFetchRequest<TotalScores> = TotalScores.fetchRequest()
        let sort = NSSortDescriptor(keyPath: \TotalScores.total, ascending: false)
        fetchRequestTotalScores.sortDescriptors = [sort]
        do {
            let sortedScores = try PersistenceService.context.fetch(fetchRequestTotalScores)
            self.totalScores = sortedScores
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func coreDataSortedByDate() {
        
        let fetchRequestTotalScores: NSFetchRequest<TotalScores> = TotalScores.fetchRequest()
        let sort = NSSortDescriptor(keyPath: \TotalScores.date, ascending: false)
        fetchRequestTotalScores.sortDescriptors = [sort]
        do {
            let sortedScores = try PersistenceService.context.fetch(fetchRequestTotalScores)
            self.totalScores = sortedScores
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    
    
    
    
    
    @IBAction func segmentedActionToSortData(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            coreDataSortedByTotal()
        } else if sender.selectedSegmentIndex == 1 {
            coreDataSortedByDate()
        }
        
        tableView.reloadData()
        
    }
    
    
    
    
    
}
