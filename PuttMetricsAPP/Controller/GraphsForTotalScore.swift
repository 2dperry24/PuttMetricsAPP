//
//  GraphsForTotalScore.swift
//  PuttMetricsAPP
//
//  Created by User on 12/26/17.
//  Copyright © 2017 DustinPerry. All rights reserved.
//

import Charts
import UIKit
import CoreData



class GraphsForTotalScore: UIViewController, UITableViewDelegate, UITableViewDataSource{

    
    
    var segmentIndex = 0
    @objc var totalScores = [TotalScores]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
      coreDataSortedByTotal()
         lineChartUpdate()
       
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        print("FromGRAPHSVC: \(totalScores.count))")
        
     
    }
   
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        coreDataSortedByTotal()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TotalScoresDisplayed") as! chartsVCcustomcell
        
        
      
        
        cell.totalScoreLabel.text = String(Int(totalScores[indexPath.row].total))
        
          let windNumber = totalScores[indexPath.row].windDirection 
            print("windNumber: \(windNumber)")
            cell.windDirectionImage.image = UIImage(named: "wind\(windNumber)" )
            
        
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
                   // totalStreamersLineChartView.upd
                    tableView.reloadData()
                    lineChartUpdate()
                    return
                } 
        
            coreDataSorted(descriptor: selectedSortDescriptor, predicate: selectedPredicate)
       
                    print("SortDateTotalSegemtIndex: \(sortByDateOrScore.selectedSegmentIndex)")
                    print("windSegmentIndex: \(windDirectionSegmentControl.selectedSegmentIndex)")
         tableView.reloadData()
         lineChartUpdate()
}
    

    
    
    
    
    
    
    func takeValuesFromCoreData() -> [Double]{

        var totalScoringArray = [Double]()

        for i in totalScores.indices{

            let totalScoreTotal = totalScores[i].total
            totalScoringArray.append(totalScoreTotal)

        }

        return totalScoringArray
        
    }
    

    
    
//    enum Streamer {
//        typealias DailyEntry = (day: String, count: Double)
//
//        private static let newStreamerValues = [70.0, 110.0, 96.0, 64.0, 81.0, 89.0, 77.0]
//        private static let baseValue = 100000.0
//        private static let totalValues = [887.0, 930.0, 1131.0, 5930.0, 11181.0, 2171.0, 6123.0, 3145.0, 2771.0, 1171.0, 2019.0, 1101.0, 2881.0, 1743.0]
//
//        static var totalStreamers: Double {
//            return totalValues.reduce(baseValue, +)
//        }
//
//        static var last7DaysNewStreamers: [DailyEntry] {
//            return Array(
//                zip(
//                    DateFormatter().shortWeekdaySymbols.map{$0.uppercased()},
//                    newStreamerValues.reversed()
//                )
//            )
//        }
//
//        static var aggregateTotalStreamers: [Double] {
//            return totalValues.reduce([baseValue]){
//                aggregate, value in aggregate + [aggregate.last! + value]
//            }
//        }
//    }
//
//
    
    

    @IBOutlet var myLineChartView: LineChartView!

    
    func lineChartUpdate () {
        
        
        myLineChartView.configureDefaults()
        myLineChartView.xAxis.drawLabelsEnabled = false
      //  myLineChartView.data =
            let dataSet = LineChartDataSet(
                values:
                // Streamer.aggregateTotalStreamers
                takeValuesFromCoreData()
                    .reversed()
                    .enumerated()
                    .map{
                        dayIndex, total in ChartDataEntry(
                            x: Double(dayIndex),
                            y: total
                        )
                },
                label: nil
            )
        
        if takeValuesFromCoreData().count == 1 {
            dataSet.circleRadius = 3
            dataSet.circleColors = [.red]
           
            
        } else {
            dataSet.circleRadius = 1
            dataSet.circleColors = [.red]
        }
            
            dataSet.drawFilledEnabled = true
            dataSet.fillColor = .white
            dataSet.colors = [.white]
            dataSet.fillAlpha = 1
            
            dataSet.drawCirclesEnabled = true
    
        
            print("dataSet: \(dataSet)")
            print("dataSet: \([dataSet])")
            let data = LineChartData(dataSets: [dataSet])
            data.setDrawValues(false)
            print(takeValuesFromCoreData().enumerated())
            myLineChartView.data = data
           // return data
        
           myLineChartView.notifyDataSetChanged()
        
    }
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
//
//    didSet {
//    totalStreamersLineChartView.data = {
//    let dataSet = LineChartDataSet(
//    values:
//    Streamer.aggregateTotalStreamers
//
//    .enumerated()
//    .map{
//    dayIndex, total in ChartDataEntry(
//    x: Double(dayIndex),
//    y: total
//    )
//    },
//    label: nil
//    )
//
//    print("dataSet: \(dataSet)")
//    print("dataSet: \([dataSet])")
//    let data = LineChartData(dataSets: [dataSet])
//    return data
//    }()
//    }
//

    
    
    
private extension BarLineChartViewBase {
    func configureDefaults() {
        chartDescription?.enabled = false
        legend.enabled = false
        backgroundColor = UIColor.darkGray
        isUserInteractionEnabled = false
        
        for axis in [xAxis, leftAxis] {
            axis.drawAxisLineEnabled = false
            axis.drawGridLinesEnabled = false
        }
        leftAxis.labelTextColor = .white
        rightAxis.enabled = false
    }
}
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
   
    

