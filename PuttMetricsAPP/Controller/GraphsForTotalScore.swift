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
   
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TotalScoresDisplayed") as! chartsVCcustomcell
        
        
      
        
        cell.totalScoreLabel.text = String(Int(totalScores[indexPath.row].total))
        
        if let windNumber = totalScores[indexPath.row].windDirection {
            print("windNumber: \(windNumber)")
            cell.windDirectionImage.image = UIImage(named: "wind\(windNumber)" )
            }
        
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
   
//    func transformWindDirectionToString(info: String) {
//
//        if info == "0" {
//
//        }
//
//
//
//
//
//
//    }
    
    
    
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
    
    func coreDataSorted (descriptor: NSSortDescriptor , predicate: NSPredicate) {
        
        let fetchRequestTotalScores: NSFetchRequest<TotalScores> = TotalScores.fetchRequest()
       
        fetchRequestTotalScores.sortDescriptors = [descriptor]
        fetchRequestTotalScores.predicate = predicate
        do {
            let sortedScores = try PersistenceService.context.fetch(fetchRequestTotalScores)
            self.totalScores = sortedScores
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        
        
    }
    
    lazy var FourPredicate: NSPredicate = {
        return NSPredicate(format: "%K == %@", #keyPath(TotalScores.windDirection), "4")
    }()
    
    lazy var ThreePredicate: NSPredicate = {
        return NSPredicate(format: "%K == %@", #keyPath(TotalScores.windDirection), "3")
    }()
    lazy var TwoPredicate: NSPredicate = {
        return NSPredicate(format: "%K == %@", #keyPath(TotalScores.windDirection), "2")
    }()
    lazy var OnePredicate: NSPredicate = {
        return NSPredicate(format: "%K == %@", #keyPath(TotalScores.windDirection), "1")
    }()
 
    
    
    @IBOutlet weak var windDirectionSegmentControl: UISegmentedControl!
    @IBOutlet weak var sortByDateOrScore: UISegmentedControl!
    @IBAction func segmentedActionToSortData(_ sender: UISegmentedControl) {
        
    changeTableView()
        
    }
    
    
    func changeTableView() {
        var  selectedPredicate = NSPredicate()
        var selectedSortDescriptor = NSSortDescriptor()
        
        
        if sortByDateOrScore.selectedSegmentIndex == 0 {
            selectedSortDescriptor = NSSortDescriptor(keyPath: \TotalScores.total, ascending: false)
        } else if sortByDateOrScore.selectedSegmentIndex == 1 {
            selectedSortDescriptor = NSSortDescriptor(keyPath: \TotalScores.date, ascending: false)
        }
                if windDirectionSegmentControl.selectedSegmentIndex == 1 {
                    selectedPredicate = OnePredicate
                } else if windDirectionSegmentControl.selectedSegmentIndex == 2 {
                    selectedPredicate = TwoPredicate
                } else if windDirectionSegmentControl.selectedSegmentIndex == 3 {
                    selectedPredicate = ThreePredicate
                } else if windDirectionSegmentControl.selectedSegmentIndex == 4 {
                    selectedPredicate = FourPredicate
                } else if windDirectionSegmentControl.selectedSegmentIndex == 0 {
                    
                                    if sortByDateOrScore.selectedSegmentIndex == 0 {
                                            coreDataSortedByTotal()
                                    } else if sortByDateOrScore.selectedSegmentIndex == 1 {
                                           coreDataSortedByDate()
                                    }
                    
                    tableView.reloadData()
                    return
                } 
        
            coreDataSorted(descriptor: selectedSortDescriptor, predicate: selectedPredicate)
        
                    print("SortDateTotalSegemtIndex: \(sortByDateOrScore.selectedSegmentIndex)")
                    print("windSegmentIndex: \(windDirectionSegmentControl.selectedSegmentIndex)")
         tableView.reloadData()
        

    
}
}


