//
//  radarChart.swift
//  PuttMetricsAPP
//
//  Created by User on 12/29/17.
//  Copyright © 2017 DustinPerry. All rights reserved.
//

import UIKit
import CoreData
import Charts





class RadarChartViewController: DemoBaseViewController {
  
    
  
  
    //   @IBOutlet weak var viewheightConstraint: NSLayoutConstraint!
    @IBOutlet var chartView: RadarChartView!{
        didSet{
            fetchcoredataToPopulateRadarGraph()
            updateChartData()
            
        }
    }
    
    let activities = ["10'", "15'", "20'","25'", "30'", "35","40'", "45'", "50'"]
    var counter = 0
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Do any additional setup after loading the view.
        self.title = "Radar Bar Chart"
        self.options = [.toggleValues,
                        .toggleHighlight,
                        .toggleHighlightCircle,
                        .toggleXLabels,
                        .toggleYLabels,
                        .toggleRotate,
                        .toggleFilled,
                        .animateX,
                        .animateY,
                        .animateXY,
                        .spin,
                        .saveToGallery,
                        .toggleData]
        
        chartView.delegate = self
        
        chartView.chartDescription?.enabled = false
        chartView.webLineWidth = 1
        chartView.innerWebLineWidth = 1
        chartView.webColor = .lightGray
        chartView.innerWebColor = .lightGray
        chartView.webAlpha = 1
        
        let marker = RadarMarkerView.viewFromXib()!
        marker.chartView = chartView
        chartView.marker = marker
        
        let xAxis = chartView.xAxis
        xAxis.labelFont = .systemFont(ofSize: 9, weight: .light)
        xAxis.xOffset = 0
        xAxis.yOffset = 0
        xAxis.valueFormatter = self
        xAxis.labelTextColor = .black
        
        let yAxis = chartView.yAxis
        yAxis.labelFont = .systemFont(ofSize: 9, weight: .light)
        yAxis.labelCount = 5
        yAxis.axisMinimum = 0
        yAxis.axisMaximum = 80
        yAxis.drawLabelsEnabled = false
        
        let l = chartView.legend
        l.horizontalAlignment = .center
        l.verticalAlignment = .top
        l.orientation = .horizontal
        l.drawInside = false
        l.font = .systemFont(ofSize: 10, weight: .light)
        l.xEntrySpace = 7
        l.yEntrySpace = 5
        l.textColor = .black
       //       chartView.legend = l
        
      //  self.updateChartData()
        
        chartView.animate(xAxisDuration: 1.4, yAxisDuration: 1.4, easingOption: .easeOutBack)
   
    let pickerViewOptions = ["All Conditions", "No Wind", "Head Wind", "Tail Wind", "Right-to-Left", "Left-to-Right", ""]
        
        
      
    setPickerView()
    createToolBar()
       
        
        
    self.updateChartData()
    pickerViewTextField.text = pickerViewOptions[pickingIndexSet1]
    pickerViewTextField2.text = pickerViewOptions[pickingIndexSet2]
        
        self.hideKeyboard()
        
    }
//    override func viewDidAppear(_ animated: Bool) {
//        fetchcoredataToPopulateRadarGraph()
//    }
//
//    func transferDataFromCoreDataIntoDoubleArray(doubleArray: [Double], coreData: [TenFeetScores]) -> Double {
//
//        for x in coreData.indices {
//            let number = coreData[x].percentage
//            doubleArray.append(contentsOf: number)
//        }
//
//
//    }
    
    var scoresfromTen_0 = [TenFeetScores]()
    var scoresfromTen_1 = [TenFeetScores]()
    var scoresfromTen_2 = [TenFeetScores]()
    var scoresfromTen_3 = [TenFeetScores]()
    var scoresfromTen_4 = [TenFeetScores]()
    
    var scoresfromFifteen_0 = [FifteenFeetScores]()
    var scoresfromFifteen_1 = [FifteenFeetScores]()
    var scoresfromFifteen_2 = [FifteenFeetScores]()
    var scoresfromFifteen_3 = [FifteenFeetScores]()
    var scoresfromFifteen_4 = [FifteenFeetScores]()
    
    var scoresfromTwenty_0 = [TwentyFeetScores]()
    var scoresfromTwenty_1 = [TwentyFeetScores]()
    var scoresfromTwenty_2 = [TwentyFeetScores]()
    var scoresfromTwenty_3 = [TwentyFeetScores]()
    var scoresfromTwenty_4 = [TwentyFeetScores]()
    
    var scoresfromTwentyFive_0 = [TwentyFiveFeetScores]()
    var scoresfromTwentyFive_1 = [TwentyFiveFeetScores]()
    var scoresfromTwentyFive_2 = [TwentyFiveFeetScores]()
    var scoresfromTwentyFive_3 = [TwentyFiveFeetScores]()
    var scoresfromTwentyFive_4 = [TwentyFiveFeetScores]()
    
    var scoresfromThirty_0 = [ThirtyFeetScores]()
    var scoresfromThirty_1 = [ThirtyFeetScores]()
    var scoresfromThirty_2 = [ThirtyFeetScores]()
    var scoresfromThirty_3 = [ThirtyFeetScores]()
    var scoresfromThirty_4 = [ThirtyFeetScores]()
    
    var scoresfromThirtyFive_0 = [ThirtyFiveFeetScores]()
    var scoresfromThirtyFive_1 = [ThirtyFiveFeetScores]()
    var scoresfromThirtyFive_2 = [ThirtyFiveFeetScores]()
    var scoresfromThirtyFive_3 = [ThirtyFiveFeetScores]()
    var scoresfromThirtyFive_4 = [ThirtyFiveFeetScores]()
    
    var scoresfromForty_0 = [FortyFeetScores]()
    var scoresfromForty_1 = [FortyFeetScores]()
    var scoresfromForty_2 = [FortyFeetScores]()
    var scoresfromForty_3 = [FortyFeetScores]()
    var scoresfromForty_4 = [FortyFeetScores]()
    
    var scoresfromFortyFive_0 = [FortyFiveFeetScores]()
    var scoresfromFortyFive_1 = [FortyFiveFeetScores]()
    var scoresfromFortyFive_2 = [FortyFiveFeetScores]()
    var scoresfromFortyFive_3 = [FortyFiveFeetScores]()
    var scoresfromFortyFive_4 = [FortyFiveFeetScores]()
    
    var scoresfromFifty_0 = [FiftyFeetScores]()
    var scoresfromFifty_1 = [FiftyFeetScores]()
    var scoresfromFifty_2 = [FiftyFeetScores]()
    var scoresfromFifty_3 = [FiftyFeetScores]()
    var scoresfromFifty_4 = [FiftyFeetScores]()
    
    
    
    var scoresfromFifteen = [FifteenFeetScores]()
    var scoresfromTwenty = [TwentyFeetScores]()
    
    //Arrays to values for each windcondition after fetched from coredata
    
    var AverageForEachDistanceAllWindConditions: [Double] = []
    
    var allDistancesFor10_0Wind: [Double] = []
    var allDistancesFor10_1Wind: [Double] = []
    var allDistancesFor10_2Wind: [Double] = []
    var allDistancesFor10_3Wind: [Double] = []
    var allDistancesFor10_4Wind: [Double] = []
   
    var allDistancesFor15_0Wind: [Double] = []
    var allDistancesFor15_1Wind: [Double] = []
    var allDistancesFor15_2Wind: [Double] = []
    var allDistancesFor15_3Wind: [Double] = []
    var allDistancesFor15_4Wind: [Double] = []
    
    var allDistancesFor20_0Wind: [Double] = []
    var allDistancesFor20_1Wind: [Double] = []
    var allDistancesFor20_2Wind: [Double] = []
    var allDistancesFor20_3Wind: [Double] = []
    var allDistancesFor20_4Wind: [Double] = []
    
    var allDistancesFor25_0Wind: [Double] = []
    var allDistancesFor25_1Wind: [Double] = []
    var allDistancesFor25_2Wind: [Double] = []
    var allDistancesFor25_3Wind: [Double] = []
    var allDistancesFor25_4Wind: [Double] = []
    
    var allDistancesFor30_0Wind: [Double] = []
    var allDistancesFor30_1Wind: [Double] = []
    var allDistancesFor30_2Wind: [Double] = []
    var allDistancesFor30_3Wind: [Double] = []
    var allDistancesFor30_4Wind: [Double] = []
    
    var allDistancesFor35_0Wind: [Double] = []
    var allDistancesFor35_1Wind: [Double] = []
    var allDistancesFor35_2Wind: [Double] = []
    var allDistancesFor35_3Wind: [Double] = []
    var allDistancesFor35_4Wind: [Double] = []
    
    var allDistancesFor40_0Wind: [Double] = []
    var allDistancesFor40_1Wind: [Double] = []
    var allDistancesFor40_2Wind: [Double] = []
    var allDistancesFor40_3Wind: [Double] = []
    var allDistancesFor40_4Wind: [Double] = []
    
    var allDistancesFor45_0Wind: [Double] = []
    var allDistancesFor45_1Wind: [Double] = []
    var allDistancesFor45_2Wind: [Double] = []
    var allDistancesFor45_3Wind: [Double] = []
    var allDistancesFor45_4Wind: [Double] = []
    
    var allDistancesFor50_0Wind: [Double] = []
    var allDistancesFor50_1Wind: [Double] = []
    var allDistancesFor50_2Wind: [Double] = []
    var allDistancesFor50_3Wind: [Double] = []
    var allDistancesFor50_4Wind: [Double] = []
    
    
   //These are the arrays that will be passed into the RadarGraphEntry as data Sets
    
    var allWindsFor_0Wind : [Double] = []
    var allWindsFor_1Wind : [Double] = []
    var allWindsFor_2Wind : [Double] = []
    var allWindsFor_3Wind : [Double] = []
    var allWindsFor_4Wind : [Double] = []
    
    
    func checkForNan(intake: Double) -> Double {
        if intake.isNaN == true {
            return 0
        } else {
            return intake
        }
    }
    //Mark: Populate Radar Graph initial (View did load)
    func fetchcoredataToPopulateRadarGraph () {

        let fetchRequest10_0: NSFetchRequest<TenFeetScores> = TenFeetScores.fetchRequest()
        let fetchRequest10_1: NSFetchRequest<TenFeetScores> = TenFeetScores.fetchRequest()
        let fetchRequest10_2: NSFetchRequest<TenFeetScores> = TenFeetScores.fetchRequest()
        let fetchRequest10_3: NSFetchRequest<TenFeetScores> = TenFeetScores.fetchRequest()
        let fetchRequest10_4: NSFetchRequest<TenFeetScores> = TenFeetScores.fetchRequest()
        
        fetchRequest10_0.predicate = NSPredicate(format: "%K == %@", #keyPath(TenFeetScores.windDirection), "0")
        fetchRequest10_1.predicate = NSPredicate(format: "%K == %@", #keyPath(TenFeetScores.windDirection), "1")
        fetchRequest10_2.predicate = NSPredicate(format: "%K == %@", #keyPath(TenFeetScores.windDirection), "2")
        fetchRequest10_3.predicate = NSPredicate(format: "%K == %@", #keyPath(TenFeetScores.windDirection), "3")
        fetchRequest10_4.predicate = NSPredicate(format: "%K == %@", #keyPath(TenFeetScores.windDirection), "4")
        do {
           
            let sortedScores10_0 = try PersistenceService.context.fetch(fetchRequest10_0)
            self.scoresfromTen_0 = sortedScores10_0
            print("fetched 0 done")
            let sortedScores10_1 = try PersistenceService.context.fetch(fetchRequest10_1)
            self.scoresfromTen_1 = sortedScores10_1
            print("fetched 1 done")
            let sortedScores10_2 = try PersistenceService.context.fetch(fetchRequest10_2)
            self.scoresfromTen_2 = sortedScores10_2
            print("fetched 2 done")
            let sortedScores10_3 = try PersistenceService.context.fetch(fetchRequest10_3)
            self.scoresfromTen_3 = sortedScores10_3
            print("fetched 3 done")
            let sortedScores10_4 = try PersistenceService.context.fetch(fetchRequest10_4)
            self.scoresfromTen_4 = sortedScores10_4
            print("fetched 4 done")

        } catch let error as NSError {
            print("Could not fetch 10coredata. \(error), \(error.userInfo)")
        }
                        var allwindsCombinedAverage10 = [Double]()
        
                        let sumOfArray10_0 = scoresfromTen_0.reduce(0, {$0 + $1.percentage})
                        let average10_0 = (Double(sumOfArray10_0) / Double(scoresfromTen_0.count))
                            if checkForNan(intake: average10_0) != 0 {
                                allDistancesFor10_0Wind.append(average10_0)
                                allwindsCombinedAverage10.append(average10_0)
                            }
                        print("scoresfromTen0.count: \(scoresfromTen_0.count)")
                        print("allDistancesFor10_0Wind: \(allDistancesFor10_0Wind)")
        
                        let sumOfArray10_1 = scoresfromTen_1.reduce(0, {$0 + $1.percentage})
                        let average10_1 = (Double(sumOfArray10_1) / Double(scoresfromTen_1.count))
                            if checkForNan(intake: average10_1) != 0 {
                                allDistancesFor10_1Wind.append(average10_1)
                                allwindsCombinedAverage10.append(average10_1)
                            }
        
                        print("scoresfromTen1.count: \(scoresfromTen_1.count)")
                        print("allDistancesFor10_1Wind: \(allDistancesFor10_1Wind)")
        
                        let sumOfArray10_2 = scoresfromTen_2.reduce(0, {$0 + $1.percentage})
                        let average10_2 = (Double(sumOfArray10_2) / Double(scoresfromTen_2.count))
                            if checkForNan(intake: average10_2) != 0 {
                                allDistancesFor10_2Wind.append(average10_2)
                                allwindsCombinedAverage10.append(average10_2)
                            }
                                            print("scoresfromTen2.count: \(scoresfromTen_2.count)")
                        print("allDistancesFor10_2Wind: \(allDistancesFor10_2Wind)")
        
                        let sumOfArray10_3 = scoresfromTen_3.reduce(0, {$0 + $1.percentage})
                        let average10_3 = (Double(sumOfArray10_3) / Double(scoresfromTen_3.count))
                            if checkForNan(intake: average10_3) != 0 {
                                allDistancesFor10_3Wind.append(average10_3)
                                allwindsCombinedAverage10.append(average10_3)
                            }
                        print("scoresfromTen3.count: \(scoresfromTen_3.count)")
                        print("allDistancesFor10_3Wind: \(allDistancesFor10_3Wind)")
        
                        let sumOfArray10_4 = scoresfromTen_4.reduce(0, {$0 + $1.percentage})
                        let average10_4 = (Double(sumOfArray10_4) / Double(scoresfromTen_4.count))
                            if checkForNan(intake: average10_4) != 0 {
                                allDistancesFor10_4Wind.append(average10_4)
                                allwindsCombinedAverage10.append(average10_4)
                            }
                        print("scoresfromTen4.count: \(scoresfromTen_4.count)")
                        print("allDistancesFor10_4Wind: \(allDistancesFor10_4Wind)")
        
        
       
                        print("allwindsCombinedAverage10:\(allwindsCombinedAverage10)")
                        let sumOfAllWindsCombinedAverages10 = allwindsCombinedAverage10.reduce(0, {$0 + $1})
                        print("sumOfAllWindsCombinedAverages10: \(sumOfAllWindsCombinedAverages10)")
                        let AverageOfAllWindsCombinedAverages10 = sumOfAllWindsCombinedAverages10 / Double(allwindsCombinedAverage10.count)
                        //allDistancesTotal will be the average of everything from that distances to be the underlying layer in the radar graph.
                        AverageForEachDistanceAllWindConditions.append(AverageOfAllWindsCombinedAverages10)
                        print("AverageForEachDistanceAllWindConditions[0]: \(AverageForEachDistanceAllWindConditions)")
        
        
        let fetchRequest15_0: NSFetchRequest<FifteenFeetScores> = FifteenFeetScores.fetchRequest()
        let fetchRequest15_1: NSFetchRequest<FifteenFeetScores> = FifteenFeetScores.fetchRequest()
        let fetchRequest15_2: NSFetchRequest<FifteenFeetScores> = FifteenFeetScores.fetchRequest()
        let fetchRequest15_3: NSFetchRequest<FifteenFeetScores> = FifteenFeetScores.fetchRequest()
        let fetchRequest15_4: NSFetchRequest<FifteenFeetScores> = FifteenFeetScores.fetchRequest()
        
        fetchRequest15_0.predicate = NSPredicate(format: "%K == %@", #keyPath(FifteenFeetScores.windDirection), "0")
        fetchRequest15_1.predicate = NSPredicate(format: "%K == %@", #keyPath(FifteenFeetScores.windDirection), "1")
        fetchRequest15_2.predicate = NSPredicate(format: "%K == %@", #keyPath(FifteenFeetScores.windDirection), "2")
        fetchRequest15_3.predicate = NSPredicate(format: "%K == %@", #keyPath(FifteenFeetScores.windDirection), "3")
        fetchRequest15_4.predicate = NSPredicate(format: "%K == %@", #keyPath(FifteenFeetScores.windDirection), "4")
        do {
            
            let sortedScores15_0 = try PersistenceService.context.fetch(fetchRequest15_0)
            self.scoresfromFifteen_0 = sortedScores15_0
            print("fetched 0 done")
            let sortedScores15_1 = try PersistenceService.context.fetch(fetchRequest15_1)
            self.scoresfromFifteen_1 = sortedScores15_1
            print("fetched 1 done")
            let sortedScores15_2 = try PersistenceService.context.fetch(fetchRequest15_2)
            self.scoresfromFifteen_2 = sortedScores15_2
            print("fetched 2 done")
            let sortedScores15_3 = try PersistenceService.context.fetch(fetchRequest15_3)
            self.scoresfromFifteen_3 = sortedScores15_3
            print("fetched 3 done")
            let sortedScores15_4 = try PersistenceService.context.fetch(fetchRequest15_4)
            self.scoresfromFifteen_4 = sortedScores15_4
            print("fetched 4 done")
            
        } catch let error as NSError {
            print("Could not fetch from 15coredata. \(error), \(error.userInfo)")
        }
                        var allwindsCombinedAverage15 = [Double]()
        
                        let sumOfArray15_0 = scoresfromFifteen_0.reduce(0, {$0 + $1.percentage})
                        let average15_0 = (Double(sumOfArray15_0) / Double(scoresfromFifteen_0.count))
                        if checkForNan(intake: average15_0) != 0 {
                            allDistancesFor15_0Wind.append(average15_0)
                            allwindsCombinedAverage15.append(average15_0)
                        }
                        print("scoresfromFifteen0.count: \(scoresfromFifteen_0.count)")
                        print("allDistancesFor10_0Wind: \(allDistancesFor15_0Wind)")
        
                        let sumOfArray15_1 = scoresfromFifteen_1.reduce(0, {$0 + $1.percentage})
                        let average15_1 = (Double(sumOfArray15_1) / Double(scoresfromFifteen_1.count))
                        if checkForNan(intake: average15_1) != 0 {
                            allDistancesFor15_1Wind.append(average15_1)
                            allwindsCombinedAverage15.append(average15_1)
                        }
        
                        print("scoresfromFifteen1.count: \(scoresfromFifteen_1.count)")
                        print("allDistancesFor15_1Wind: \(allDistancesFor15_1Wind)")
        
                        let sumOfArray15_2 = scoresfromFifteen_2.reduce(0, {$0 + $1.percentage})
                        let average15_2 = (Double(sumOfArray15_2) / Double(scoresfromFifteen_2.count))
                        if checkForNan(intake: average15_2) != 0 {
                            allDistancesFor15_2Wind.append(average15_2)
                            allwindsCombinedAverage15.append(average15_2)
                        }
                        print("scoresfromFifteen2.count: \(scoresfromFifteen_2.count)")
                        print("allDistancesFor15_2Wind: \(allDistancesFor15_2Wind)")
        
                        let sumOfArray15_3 = scoresfromFifteen_3.reduce(0, {$0 + $1.percentage})
                        let average15_3 = (Double(sumOfArray15_3) / Double(scoresfromFifteen_3.count))
                        if checkForNan(intake: average15_3) != 0 {
                            allDistancesFor15_3Wind.append(average15_3)
                            allwindsCombinedAverage15.append(average15_3)
                        }
                        print("scoresfromFifteen3.count: \(scoresfromFifteen_3.count)")
                        print("allDistancesFor15_3Wind: \(allDistancesFor15_3Wind)")
        
                        let sumOfArray15_4 = scoresfromFifteen_4.reduce(0, {$0 + $1.percentage})
                        let average15_4 = (Double(sumOfArray15_4) / Double(scoresfromFifteen_4.count))
                        if checkForNan(intake: average15_4) != 0 {
                            allDistancesFor15_4Wind.append(average15_4)
                            allwindsCombinedAverage15.append(average15_4)
                        }
                        print("scoresfromFifteen4.count: \(scoresfromFifteen_4.count)")
                        print("allDistancesFor15_4Wind: \(allDistancesFor15_4Wind)")
        
        
        
                        print("allwindsCombinedAverage15:\(allwindsCombinedAverage15)")
                        let sumOfAllWindsCombinedAverages15 = allwindsCombinedAverage15.reduce(0, {$0 + $1})
                        print("sumOfAllWindsCombinedAverages15: \(sumOfAllWindsCombinedAverages15)")
                        let AverageOfAllWindsCombinedAverages15 = sumOfAllWindsCombinedAverages15 / Double(allwindsCombinedAverage15.count)
                        //allDistancesTotal will be the average of everything from that distances to be the underlying layer in the radar graph.
                        AverageForEachDistanceAllWindConditions.append(AverageOfAllWindsCombinedAverages15)
        
                        print("AverageForEachDistanceAllWindConditions[1]: \(AverageForEachDistanceAllWindConditions)")
                        print("AverageForEachDistanceAllWindConditions.count: \(AverageForEachDistanceAllWindConditions.count)")
        
        
        
        
        let fetchRequest20_0: NSFetchRequest<TwentyFeetScores> = TwentyFeetScores.fetchRequest()
        let fetchRequest20_1: NSFetchRequest<TwentyFeetScores> = TwentyFeetScores.fetchRequest()
        let fetchRequest20_2: NSFetchRequest<TwentyFeetScores> = TwentyFeetScores.fetchRequest()
        let fetchRequest20_3: NSFetchRequest<TwentyFeetScores> = TwentyFeetScores.fetchRequest()
        let fetchRequest20_4: NSFetchRequest<TwentyFeetScores> = TwentyFeetScores.fetchRequest()
        
        fetchRequest20_0.predicate = NSPredicate(format: "%K == %@", #keyPath(TwentyFeetScores.windDirection), "0")
        fetchRequest20_1.predicate = NSPredicate(format: "%K == %@", #keyPath(TwentyFeetScores.windDirection), "1")
        fetchRequest20_2.predicate = NSPredicate(format: "%K == %@", #keyPath(TwentyFeetScores.windDirection), "2")
        fetchRequest20_3.predicate = NSPredicate(format: "%K == %@", #keyPath(TwentyFeetScores.windDirection), "3")
        fetchRequest20_4.predicate = NSPredicate(format: "%K == %@", #keyPath(TwentyFeetScores.windDirection), "4")
        do {
            
            let sortedScores20_0 = try PersistenceService.context.fetch(fetchRequest20_0)
            self.scoresfromTwenty_0 = sortedScores20_0
            print("fetched 0 done")
            let sortedScores20_1 = try PersistenceService.context.fetch(fetchRequest20_1)
            self.scoresfromTwenty_1 = sortedScores20_1
            print("fetched 1 done")
            let sortedScores20_2 = try PersistenceService.context.fetch(fetchRequest20_2)
            self.scoresfromTwenty_2 = sortedScores20_2
            print("fetched 2 done")
            let sortedScores20_3 = try PersistenceService.context.fetch(fetchRequest20_3)
            self.scoresfromTwenty_3 = sortedScores20_3
            print("fetched 3 done")
            let sortedScores20_4 = try PersistenceService.context.fetch(fetchRequest20_4)
            self.scoresfromTwenty_4 = sortedScores20_4
            print("fetched 4 done")
            
        } catch let error as NSError {
            print("Could not fetch from 15coredata. \(error), \(error.userInfo)")
        }
                        var allwindsCombinedAverage20 = [Double]()
                        
                        let sumOfArray20_0 = scoresfromTwenty_0.reduce(0, {$0 + $1.percentage})
                        let average20_0 = (Double(sumOfArray20_0) / Double(scoresfromTwenty_0.count))
                        if checkForNan(intake: average20_0) != 0 {
                            allDistancesFor20_0Wind.append(average20_0)
                            allwindsCombinedAverage20.append(average20_0)
                        }
                        print("scoresfromTwenty0.count: \(scoresfromTwenty_0.count)")
                        print("allDistancesFor20_0Wind: \(allDistancesFor20_0Wind)")
                        
                        let sumOfArray20_1 = scoresfromTwenty_1.reduce(0, {$0 + $1.percentage})
                        let average20_1 = (Double(sumOfArray20_1) / Double(scoresfromTwenty_1.count))
                        if checkForNan(intake: average20_1) != 0 {
                            allDistancesFor20_1Wind.append(average20_1)
                            allwindsCombinedAverage20.append(average20_1)
                        }
                        
                        print("scoresfromTwenty1.count: \(scoresfromTwenty_1.count)")
                        print("allDistancesFor20_1Wind: \(allDistancesFor20_1Wind)")
                        
                        let sumOfArray20_2 = scoresfromTwenty_2.reduce(0, {$0 + $1.percentage})
                        let average20_2 = (Double(sumOfArray20_2) / Double(scoresfromTwenty_2.count))
                        if checkForNan(intake: average20_2) != 0 {
                            allDistancesFor20_2Wind.append(average20_2)
                            allwindsCombinedAverage20.append(average20_2)
                        }
                        print("scoresfromTwenty2.count: \(scoresfromTwenty_2.count)")
                        print("allDistancesFor20_2Wind: \(allDistancesFor20_2Wind)")
                        
                        let sumOfArray20_3 = scoresfromTwenty_3.reduce(0, {$0 + $1.percentage})
                        let average20_3 = (Double(sumOfArray20_3) / Double(scoresfromTwenty_3.count))
                        if checkForNan(intake: average20_3) != 0 {
                            allDistancesFor20_3Wind.append(average20_3)
                            allwindsCombinedAverage20.append(average20_3)
                        }
                        print("scoresfromTwenty3.count: \(scoresfromTwenty_3.count)")
                        print("allDistancesFor20_3Wind: \(allDistancesFor20_3Wind)")
                        
                        let sumOfArray20_4 = scoresfromTwenty_4.reduce(0, {$0 + $1.percentage})
                        let average20_4 = (Double(sumOfArray20_4) / Double(scoresfromTwenty_4.count))
                        if checkForNan(intake: average20_4) != 0 {
                            allDistancesFor20_4Wind.append(average20_4)
                            allwindsCombinedAverage20.append(average20_4)
                        }
                        print("scoresfromTwenty4.count: \(scoresfromTwenty_4.count)")
                        print("allDistancesFor20_4Wind: \(allDistancesFor20_4Wind)")
                        
                        
                        
                        print("allwindsCombinedAverage20:\(allwindsCombinedAverage20)")
                        let sumOfAllWindsCombinedAverages20 = allwindsCombinedAverage20.reduce(0, {$0 + $1})
                        print("sumOfAllWindsCombinedAverages20: \(sumOfAllWindsCombinedAverages20)")
                        let AverageOfAllWindsCombinedAverages20 = sumOfAllWindsCombinedAverages20 / Double(allwindsCombinedAverage20.count)
                        //allDistancesTotal will be the average of everything from that distances to be the underlying layer in the radar graph.
                        AverageForEachDistanceAllWindConditions.append(AverageOfAllWindsCombinedAverages20)
                        
                        print("AverageForEachDistanceAllWindConditions[2]: \(AverageForEachDistanceAllWindConditions)")
                        print("AverageForEachDistanceAllWindConditions.count: \(AverageForEachDistanceAllWindConditions.count)")
                        
                        
                        
        
        let fetchRequest25_0: NSFetchRequest<TwentyFiveFeetScores> = TwentyFiveFeetScores.fetchRequest()
        let fetchRequest25_1: NSFetchRequest<TwentyFiveFeetScores> = TwentyFiveFeetScores.fetchRequest()
        let fetchRequest25_2: NSFetchRequest<TwentyFiveFeetScores> = TwentyFiveFeetScores.fetchRequest()
        let fetchRequest25_3: NSFetchRequest<TwentyFiveFeetScores> = TwentyFiveFeetScores.fetchRequest()
        let fetchRequest25_4: NSFetchRequest<TwentyFiveFeetScores> = TwentyFiveFeetScores.fetchRequest()
        
        fetchRequest25_0.predicate = NSPredicate(format: "%K == %@", #keyPath(TwentyFiveFeetScores.windDirection), "0")
        fetchRequest25_1.predicate = NSPredicate(format: "%K == %@", #keyPath(TwentyFiveFeetScores.windDirection), "1")
        fetchRequest25_2.predicate = NSPredicate(format: "%K == %@", #keyPath(TwentyFiveFeetScores.windDirection), "2")
        fetchRequest25_3.predicate = NSPredicate(format: "%K == %@", #keyPath(TwentyFiveFeetScores.windDirection), "3")
        fetchRequest25_4.predicate = NSPredicate(format: "%K == %@", #keyPath(TwentyFiveFeetScores.windDirection), "4")
        do {
            
            let sortedScores25_0 = try PersistenceService.context.fetch(fetchRequest25_0)
            self.scoresfromTwentyFive_0 = sortedScores25_0
            print("fetched 0 done")
            let sortedScores25_1 = try PersistenceService.context.fetch(fetchRequest25_1)
            self.scoresfromTwentyFive_1 = sortedScores25_1
            print("fetched 1 done")
            let sortedScores25_2 = try PersistenceService.context.fetch(fetchRequest25_2)
            self.scoresfromTwentyFive_2 = sortedScores25_2
            print("fetched 2 done")
            let sortedScores25_3 = try PersistenceService.context.fetch(fetchRequest25_3)
            self.scoresfromTwentyFive_3 = sortedScores25_3
            print("fetched 3 done")
            let sortedScores25_4 = try PersistenceService.context.fetch(fetchRequest25_4)
            self.scoresfromTwentyFive_4 = sortedScores25_4
            print("fetched 4 done")
            
        } catch let error as NSError {
            print("Could not fetch from 25coredata. \(error), \(error.userInfo)")
        }
                        var allwindsCombinedAverage25 = [Double]()
        
                        let sumOfArray25_0 = scoresfromTwentyFive_0.reduce(0, {$0 + $1.percentage})
                        let average25_0 = (Double(sumOfArray25_0) / Double(scoresfromTwentyFive_0.count))
                        if checkForNan(intake: average25_0) != 0 {
                            allDistancesFor25_0Wind.append(average25_0)
                            allwindsCombinedAverage25.append(average25_0)
                        }
                        print("scoresfromTwentyFive_0.count: \(scoresfromTwentyFive_0.count)")
                        print("allDistancesFor25_0Wind: \(allDistancesFor25_0Wind)")
        
                        let sumOfArray25_1 = scoresfromTwentyFive_1.reduce(0, {$0 + $1.percentage})
                        let average25_1 = (Double(sumOfArray25_1) / Double(scoresfromTwentyFive_1.count))
                        if checkForNan(intake: average25_1) != 0 {
                            allDistancesFor25_1Wind.append(average25_1)
                            allwindsCombinedAverage25.append(average25_1)
                        }
        
                        print("scoresfromTwentyFive1.count: \(scoresfromTwentyFive_1.count)")
                        print("allDistancesFor25_1Wind: \(allDistancesFor25_1Wind)")
        
                        let sumOfArray25_2 = scoresfromTwentyFive_2.reduce(0, {$0 + $1.percentage})
                        let average25_2 = (Double(sumOfArray25_2) / Double(scoresfromTwentyFive_2.count))
                        if checkForNan(intake: average25_2) != 0 {
                            allDistancesFor25_2Wind.append(average25_2)
                            allwindsCombinedAverage25.append(average25_2)
                        }
                        print("scoresfromTwentyFive2.count: \(scoresfromTwentyFive_2.count)")
                        print("allDistancesFor25_2Wind: \(allDistancesFor25_2Wind)")
        
                        let sumOfArray25_3 = scoresfromTwentyFive_3.reduce(0, {$0 + $1.percentage})
                        let average25_3 = (Double(sumOfArray25_3) / Double(scoresfromTwentyFive_3.count))
                        if checkForNan(intake: average25_3) != 0 {
                            allDistancesFor25_3Wind.append(average25_3)
                            allwindsCombinedAverage25.append(average25_3)
                        }
                        print("scoresfromTwentyFive3.count: \(scoresfromTwentyFive_3.count)")
                        print("allDistancesFor25_3Wind: \(allDistancesFor25_3Wind)")
        
                        let sumOfArray25_4 = scoresfromTwentyFive_4.reduce(0, {$0 + $1.percentage})
                        let average25_4 = (Double(sumOfArray25_4) / Double(scoresfromTwentyFive_4.count))
                        if checkForNan(intake: average25_4) != 0 {
                            allDistancesFor25_4Wind.append(average25_4)
                            allwindsCombinedAverage25.append(average25_4)
                        }
                        print("scoresfromTwentyFive4.count: \(scoresfromTwentyFive_4.count)")
                        print("allDistancesFor25_4Wind: \(allDistancesFor25_4Wind)")
        
        
        
                        print("allwindsCombinedAverage25:\(allwindsCombinedAverage25)")
                        let sumOfAllWindsCombinedAverages25 = allwindsCombinedAverage25.reduce(0, {$0 + $1})
                        print("sumOfAllWindsCombinedAverages25: \(sumOfAllWindsCombinedAverages25)")
                        let AverageOfAllWindsCombinedAverages25 = sumOfAllWindsCombinedAverages25 / Double(allwindsCombinedAverage25.count)
                        //allDistancesTotal will be the average of everything from that distances to be the underlying layer in the radar graph.
                        AverageForEachDistanceAllWindConditions.append(AverageOfAllWindsCombinedAverages25)
        
                        print("AverageForEachDistanceAllWindConditions[3]: \(AverageForEachDistanceAllWindConditions)")
                        print("AverageForEachDistanceAllWindConditions.count: \(AverageForEachDistanceAllWindConditions.count)")
        
        
        let fetchRequest30_0: NSFetchRequest<ThirtyFeetScores> = ThirtyFeetScores.fetchRequest()
        let fetchRequest30_1: NSFetchRequest<ThirtyFeetScores> = ThirtyFeetScores.fetchRequest()
        let fetchRequest30_2: NSFetchRequest<ThirtyFeetScores> = ThirtyFeetScores.fetchRequest()
        let fetchRequest30_3: NSFetchRequest<ThirtyFeetScores> = ThirtyFeetScores.fetchRequest()
        let fetchRequest30_4: NSFetchRequest<ThirtyFeetScores> = ThirtyFeetScores.fetchRequest()
        
        fetchRequest30_0.predicate = NSPredicate(format: "%K == %@", #keyPath(ThirtyFeetScores.windDirection), "0")
        fetchRequest30_1.predicate = NSPredicate(format: "%K == %@", #keyPath(ThirtyFeetScores.windDirection), "1")
        fetchRequest30_2.predicate = NSPredicate(format: "%K == %@", #keyPath(ThirtyFeetScores.windDirection), "2")
        fetchRequest30_3.predicate = NSPredicate(format: "%K == %@", #keyPath(ThirtyFeetScores.windDirection), "3")
        fetchRequest30_4.predicate = NSPredicate(format: "%K == %@", #keyPath(ThirtyFeetScores.windDirection), "4")
        do {
            
            let sortedScores30_0 = try PersistenceService.context.fetch(fetchRequest30_0)
            self.scoresfromThirty_0 = sortedScores30_0
            print("fetched 0 done")
            let sortedScores30_1 = try PersistenceService.context.fetch(fetchRequest30_1)
            self.scoresfromThirty_1 = sortedScores30_1
            print("fetched 1 done")
            let sortedScores30_2 = try PersistenceService.context.fetch(fetchRequest30_2)
            self.scoresfromThirty_2 = sortedScores30_2
            print("fetched 2 done")
            let sortedScores30_3 = try PersistenceService.context.fetch(fetchRequest30_3)
            self.scoresfromThirty_3 = sortedScores30_3
            print("fetched 3 done")
            let sortedScores30_4 = try PersistenceService.context.fetch(fetchRequest30_4)
            self.scoresfromThirty_4 = sortedScores30_4
            print("fetched 4 done")
            
        } catch let error as NSError {
            print("Could not fetch from 25coredata. \(error), \(error.userInfo)")
        }
                        var allwindsCombinedAverage30 = [Double]()
        
                        let sumOfArray30_0 = scoresfromThirty_0.reduce(0, {$0 + $1.percentage})
                        let average30_0 = (Double(sumOfArray30_0) / Double(scoresfromThirty_0.count))
                        if checkForNan(intake: average30_0) != 0 {
                            allDistancesFor30_0Wind.append(average30_0)
                            allwindsCombinedAverage30.append(average30_0)
                        }
                        print("scoresfromThirty_0.count: \(scoresfromThirty_0.count)")
                        print("allDistancesFor30_0Wind: \(allDistancesFor30_0Wind)")
        
                        let sumOfArray30_1 = scoresfromThirty_1.reduce(0, {$0 + $1.percentage})
                        let average30_1 = (Double(sumOfArray30_1) / Double(scoresfromThirty_1.count))
                        if checkForNan(intake: average30_1) != 0 {
                            allDistancesFor30_1Wind.append(average30_1)
                            allwindsCombinedAverage30.append(average30_1)
                        }
        
                        print("scoresfromThirty1.count: \(scoresfromThirty_1.count)")
                        print("allDistancesFor30_1Wind: \(allDistancesFor30_1Wind)")
        
                        let sumOfArray30_2 = scoresfromThirty_2.reduce(0, {$0 + $1.percentage})
                        let average30_2 = (Double(sumOfArray30_2) / Double(scoresfromThirty_2.count))
                        if checkForNan(intake: average30_2) != 0 {
                            allDistancesFor30_2Wind.append(average30_2)
                            allwindsCombinedAverage30.append(average30_2)
                        }
                        print("scoresfromThirty2.count: \(scoresfromThirty_2.count)")
                        print("allDistancesFor30_2Wind: \(allDistancesFor30_2Wind)")
        
                        let sumOfArray30_3 = scoresfromThirty_3.reduce(0, {$0 + $1.percentage})
                        let average30_3 = (Double(sumOfArray30_3) / Double(scoresfromThirty_3.count))
                        if checkForNan(intake: average30_3) != 0 {
                            allDistancesFor30_3Wind.append(average30_3)
                            allwindsCombinedAverage30.append(average30_3)
                        }
                        print("scoresfromThirty3.count: \(scoresfromThirty_3.count)")
                        print("allDistancesFor30_3Wind: \(allDistancesFor30_3Wind)")
        
                        let sumOfArray30_4 = scoresfromThirty_4.reduce(0, {$0 + $1.percentage})
                        let average30_4 = (Double(sumOfArray30_4) / Double(scoresfromThirty_4.count))
                        if checkForNan(intake: average30_4) != 0 {
                            allDistancesFor30_4Wind.append(average30_4)
                            allwindsCombinedAverage30.append(average30_4)
                        }
                        print("scoresfromThirty4.count: \(scoresfromThirty_4.count)")
                        print("allDistancesFor30_4Wind: \(allDistancesFor30_4Wind)")
        
        
        
                        print("allwindsCombinedAverage30:\(allwindsCombinedAverage30)")
                        let sumOfAllWindsCombinedAverages30 = allwindsCombinedAverage30.reduce(0, {$0 + $1})
                        print("sumOfAllWindsCombinedAverages30: \(sumOfAllWindsCombinedAverages30)")
                        let AverageOfAllWindsCombinedAverages30 = sumOfAllWindsCombinedAverages30 / Double(allwindsCombinedAverage30.count)
                        //allDistancesTotal will be the average of everything from that distances to be the underlying layer in the radar graph.
                        AverageForEachDistanceAllWindConditions.append(AverageOfAllWindsCombinedAverages30)
        
                        print("AverageForEachDistanceAllWindConditions[4]: \(AverageForEachDistanceAllWindConditions)")
                        print("AverageForEachDistanceAllWindConditions.count: \(AverageForEachDistanceAllWindConditions.count)")
        
        
        
        
        let fetchRequest35_0: NSFetchRequest<ThirtyFiveFeetScores> = ThirtyFiveFeetScores.fetchRequest()
        let fetchRequest35_1: NSFetchRequest<ThirtyFiveFeetScores> = ThirtyFiveFeetScores.fetchRequest()
        let fetchRequest35_2: NSFetchRequest<ThirtyFiveFeetScores> = ThirtyFiveFeetScores.fetchRequest()
        let fetchRequest35_3: NSFetchRequest<ThirtyFiveFeetScores> = ThirtyFiveFeetScores.fetchRequest()
        let fetchRequest35_4: NSFetchRequest<ThirtyFiveFeetScores> = ThirtyFiveFeetScores.fetchRequest()
        
        fetchRequest35_0.predicate = NSPredicate(format: "%K == %@", #keyPath(ThirtyFiveFeetScores.windDirection), "0")
        fetchRequest35_1.predicate = NSPredicate(format: "%K == %@", #keyPath(ThirtyFiveFeetScores.windDirection), "1")
        fetchRequest35_2.predicate = NSPredicate(format: "%K == %@", #keyPath(ThirtyFiveFeetScores.windDirection), "2")
        fetchRequest35_3.predicate = NSPredicate(format: "%K == %@", #keyPath(ThirtyFiveFeetScores.windDirection), "3")
        fetchRequest35_4.predicate = NSPredicate(format: "%K == %@", #keyPath(ThirtyFiveFeetScores.windDirection), "4")
        do {
            
            let sortedScores35_0 = try PersistenceService.context.fetch(fetchRequest35_0)
            self.scoresfromThirtyFive_0 = sortedScores35_0
            print("fetched 0 done")
            let sortedScores35_1 = try PersistenceService.context.fetch(fetchRequest35_1)
            self.scoresfromThirtyFive_1 = sortedScores35_1
            print("fetched 1 done")
            let sortedScores35_2 = try PersistenceService.context.fetch(fetchRequest35_2)
            self.scoresfromThirtyFive_2 = sortedScores35_2
            print("fetched 2 done")
            let sortedScores35_3 = try PersistenceService.context.fetch(fetchRequest35_3)
            self.scoresfromThirtyFive_3 = sortedScores35_3
            print("fetched 3 done")
            let sortedScores35_4 = try PersistenceService.context.fetch(fetchRequest35_4)
            self.scoresfromThirtyFive_4 = sortedScores35_4
            print("fetched 4 done")
            
        } catch let error as NSError {
            print("Could not fetch from 25coredata. \(error), \(error.userInfo)")
        }
                        var allwindsCombinedAverage35 = [Double]()
        
                        let sumOfArray35_0 = scoresfromThirtyFive_0.reduce(0, {$0 + $1.percentage})
                        let average35_0 = (Double(sumOfArray35_0) / Double(scoresfromThirtyFive_0.count))
                        if checkForNan(intake: average35_0) != 0 {
                            allDistancesFor35_0Wind.append(average35_0)
                            allwindsCombinedAverage35.append(average35_0)
                        }
                        print("scoresfromThirtyFive_0.count: \(scoresfromThirtyFive_0.count)")
                        print("allDistancesFor35_0Wind: \(allDistancesFor35_0Wind)")
        
                        let sumOfArray35_1 = scoresfromThirtyFive_1.reduce(0, {$0 + $1.percentage})
                        let average35_1 = (Double(sumOfArray35_1) / Double(scoresfromThirtyFive_1.count))
                        if checkForNan(intake: average35_1) != 0 {
                            allDistancesFor35_1Wind.append(average35_1)
                            allwindsCombinedAverage35.append(average35_1)
                        }
        
                        print("scoresfromThirtyFive1.count: \(scoresfromThirtyFive_1.count)")
                        print("allDistancesFor35_1Wind: \(allDistancesFor35_1Wind)")
        
                        let sumOfArray35_2 = scoresfromThirtyFive_2.reduce(0, {$0 + $1.percentage})
                        let average35_2 = (Double(sumOfArray35_2) / Double(scoresfromThirtyFive_2.count))
                        if checkForNan(intake: average35_2) != 0 {
                            allDistancesFor35_2Wind.append(average35_2)
                            allwindsCombinedAverage35.append(average35_2)
                        }
                        print("scoresfromThirtyFive2.count: \(scoresfromThirtyFive_2.count)")
                        print("allDistancesFor35_2Wind: \(allDistancesFor35_2Wind)")
        
                        let sumOfArray35_3 = scoresfromThirtyFive_3.reduce(0, {$0 + $1.percentage})
                        let average35_3 = (Double(sumOfArray35_3) / Double(scoresfromThirtyFive_3.count))
                        if checkForNan(intake: average35_3) != 0 {
                            allDistancesFor35_3Wind.append(average35_3)
                            allwindsCombinedAverage35.append(average35_3)
                        }
                        print("scoresfromThirtyFive3.count: \(scoresfromThirtyFive_3.count)")
                        print("allDistancesFor35_3Wind: \(allDistancesFor35_3Wind)")
        
                        let sumOfArray35_4 = scoresfromThirtyFive_4.reduce(0, {$0 + $1.percentage})
                        let average35_4 = (Double(sumOfArray35_4) / Double(scoresfromThirtyFive_4.count))
                        if checkForNan(intake: average35_4) != 0 {
                            allDistancesFor35_4Wind.append(average35_4)
                            allwindsCombinedAverage35.append(average35_4)
                        }
                        print("scoresfromThirtyFive4.count: \(scoresfromThirtyFive_4.count)")
                        print("allDistancesFor35_4Wind: \(allDistancesFor35_4Wind)")
        
        
        
                        print("allwindsCombinedAverage35:\(allwindsCombinedAverage35)")
                        let sumOfAllWindsCombinedAverages35 = allwindsCombinedAverage35.reduce(0, {$0 + $1})
                        print("sumOfAllWindsCombinedAverages35: \(sumOfAllWindsCombinedAverages35)")
                        let AverageOfAllWindsCombinedAverages35 = sumOfAllWindsCombinedAverages35 / Double(allwindsCombinedAverage30.count)
                        //allDistancesTotal will be the average of everything from that distances to be the underlying layer in the radar graph.
                        AverageForEachDistanceAllWindConditions.append(AverageOfAllWindsCombinedAverages35)
        
                        print("AverageForEachDistanceAllWindConditions[5]: \(AverageForEachDistanceAllWindConditions)")
                        print("AverageForEachDistanceAllWindConditions.count: \(AverageForEachDistanceAllWindConditions.count)")
        
        
        
        
        let fetchRequest40_0: NSFetchRequest<FortyFeetScores> = FortyFeetScores.fetchRequest()
        let fetchRequest40_1: NSFetchRequest<FortyFeetScores> = FortyFeetScores.fetchRequest()
        let fetchRequest40_2: NSFetchRequest<FortyFeetScores> = FortyFeetScores.fetchRequest()
        let fetchRequest40_3: NSFetchRequest<FortyFeetScores> = FortyFeetScores.fetchRequest()
        let fetchRequest40_4: NSFetchRequest<FortyFeetScores> = FortyFeetScores.fetchRequest()
        
        fetchRequest40_0.predicate = NSPredicate(format: "%K == %@", #keyPath(FortyFeetScores.windDirection), "0")
        fetchRequest40_1.predicate = NSPredicate(format: "%K == %@", #keyPath(FortyFeetScores.windDirection), "1")
        fetchRequest40_2.predicate = NSPredicate(format: "%K == %@", #keyPath(FortyFeetScores.windDirection), "2")
        fetchRequest40_3.predicate = NSPredicate(format: "%K == %@", #keyPath(FortyFeetScores.windDirection), "3")
        fetchRequest40_4.predicate = NSPredicate(format: "%K == %@", #keyPath(FortyFeetScores.windDirection), "4")
        do {
            
            let sortedScores40_0 = try PersistenceService.context.fetch(fetchRequest40_0)
            self.scoresfromForty_0 = sortedScores40_0
            print("fetched 0 done")
            let sortedScores40_1 = try PersistenceService.context.fetch(fetchRequest40_1)
            self.scoresfromForty_1 = sortedScores40_1
            print("fetched 1 done")
            let sortedScores40_2 = try PersistenceService.context.fetch(fetchRequest40_2)
            self.scoresfromForty_2 = sortedScores40_2
            print("fetched 2 done")
            let sortedScores40_3 = try PersistenceService.context.fetch(fetchRequest40_3)
            self.scoresfromForty_3 = sortedScores40_3
            print("fetched 3 done")
            let sortedScores40_4 = try PersistenceService.context.fetch(fetchRequest40_4)
            self.scoresfromForty_4 = sortedScores40_4
            print("fetched 4 done")
            
        } catch let error as NSError {
            print("Could not fetch from 40coredata. \(error), \(error.userInfo)")
        }
                        var allwindsCombinedAverage40 = [Double]()
        
                        let sumOfArray40_0 = scoresfromForty_0.reduce(0, {$0 + $1.percentage})
                        let average40_0 = (Double(sumOfArray40_0) / Double(scoresfromForty_0.count))
                        if checkForNan(intake: average40_0) != 0 {
                            allDistancesFor40_0Wind.append(average40_0)
                            allwindsCombinedAverage40.append(average40_0)
                        }
                        print("scoresfromForty_0.count: \(scoresfromForty_0.count)")
                        print("allDistancesFor40_0Wind: \(allDistancesFor40_0Wind)")
        
                        let sumOfArray40_1 = scoresfromForty_1.reduce(0, {$0 + $1.percentage})
                        let average40_1 = (Double(sumOfArray40_1) / Double(scoresfromForty_1.count))
                        if checkForNan(intake: average40_1) != 0 {
                            allDistancesFor40_1Wind.append(average40_1)
                            allwindsCombinedAverage40.append(average40_1)
                        }
        
                        print("scoresfromForty1.count: \(scoresfromForty_1.count)")
                        print("allDistancesFor40_1Wind: \(allDistancesFor40_1Wind)")
        
                        let sumOfArray40_2 = scoresfromForty_2.reduce(0, {$0 + $1.percentage})
                        let average40_2 = (Double(sumOfArray40_2) / Double(scoresfromForty_2.count))
                        if checkForNan(intake: average40_2) != 0 {
                            allDistancesFor40_2Wind.append(average40_2)
                            allwindsCombinedAverage40.append(average40_2)
                        }
                        print("scoresfromForty2.count: \(scoresfromForty_2.count)")
                        print("allDistancesFor40_2Wind: \(allDistancesFor40_2Wind)")
        
                        let sumOfArray40_3 = scoresfromForty_3.reduce(0, {$0 + $1.percentage})
                        let average40_3 = (Double(sumOfArray40_3) / Double(scoresfromForty_3.count))
                        if checkForNan(intake: average40_3) != 0 {
                            allDistancesFor40_3Wind.append(average40_3)
                            allwindsCombinedAverage40.append(average40_3)
                        }
                        print("scoresfromForty3.count: \(scoresfromForty_3.count)")
                        print("allDistancesFor40_3Wind: \(allDistancesFor40_3Wind)")
        
                        let sumOfArray40_4 = scoresfromForty_4.reduce(0, {$0 + $1.percentage})
                        let average40_4 = (Double(sumOfArray40_4) / Double(scoresfromForty_4.count))
                        if checkForNan(intake: average40_4) != 0 {
                            allDistancesFor40_4Wind.append(average40_4)
                            allwindsCombinedAverage40.append(average40_4)
                        }
                        print("scoresfromForty4.count: \(scoresfromForty_4.count)")
                        print("allDistancesFor40_4Wind: \(allDistancesFor40_4Wind)")
        
        
        
                        print("allwindsCombinedAverage40:\(allwindsCombinedAverage40)")
                        let sumOfAllWindsCombinedAverages40 = allwindsCombinedAverage40.reduce(0, {$0 + $1})
                        print("sumOfAllWindsCombinedAverages40: \(sumOfAllWindsCombinedAverages40)")
                        let AverageOfAllWindsCombinedAverages40 = sumOfAllWindsCombinedAverages40 / Double(allwindsCombinedAverage40.count)
                        //allDistancesTotal will be the average of everything from that distances to be the underlying layer in the radar graph.
                        AverageForEachDistanceAllWindConditions.append(AverageOfAllWindsCombinedAverages40)
        
                        print("AverageForEachDistanceAllWindConditions[6]: \(AverageForEachDistanceAllWindConditions)")
                        print("AverageForEachDistanceAllWindConditions.count: \(AverageForEachDistanceAllWindConditions.count)")
        
        
        
        let fetchRequest45_0: NSFetchRequest<FortyFiveFeetScores> = FortyFiveFeetScores.fetchRequest()
        let fetchRequest45_1: NSFetchRequest<FortyFiveFeetScores> = FortyFiveFeetScores.fetchRequest()
        let fetchRequest45_2: NSFetchRequest<FortyFiveFeetScores> = FortyFiveFeetScores.fetchRequest()
        let fetchRequest45_3: NSFetchRequest<FortyFiveFeetScores> = FortyFiveFeetScores.fetchRequest()
        let fetchRequest45_4: NSFetchRequest<FortyFiveFeetScores> = FortyFiveFeetScores.fetchRequest()
        
        fetchRequest45_0.predicate = NSPredicate(format: "%K == %@", #keyPath(FortyFiveFeetScores.windDirection), "0")
        fetchRequest45_1.predicate = NSPredicate(format: "%K == %@", #keyPath(FortyFiveFeetScores.windDirection), "1")
        fetchRequest45_2.predicate = NSPredicate(format: "%K == %@", #keyPath(FortyFiveFeetScores.windDirection), "2")
        fetchRequest45_3.predicate = NSPredicate(format: "%K == %@", #keyPath(FortyFiveFeetScores.windDirection), "3")
        fetchRequest45_4.predicate = NSPredicate(format: "%K == %@", #keyPath(FortyFiveFeetScores.windDirection), "4")
        do {
            
            let sortedScores45_0 = try PersistenceService.context.fetch(fetchRequest45_0)
            self.scoresfromFortyFive_0 = sortedScores45_0
            print("fetched 0 done")
            let sortedScores45_1 = try PersistenceService.context.fetch(fetchRequest45_1)
            self.scoresfromFortyFive_1 = sortedScores45_1
            print("fetched 1 done")
            let sortedScores45_2 = try PersistenceService.context.fetch(fetchRequest45_2)
            self.scoresfromFortyFive_2 = sortedScores45_2
            print("fetched 2 done")
            let sortedScores45_3 = try PersistenceService.context.fetch(fetchRequest45_3)
            self.scoresfromFortyFive_3 = sortedScores45_3
            print("fetched 3 done")
            let sortedScores45_4 = try PersistenceService.context.fetch(fetchRequest45_4)
            self.scoresfromFortyFive_4 = sortedScores45_4
            print("fetched 4 done")
            
        } catch let error as NSError {
            print("Could not fetch from 40coredata. \(error), \(error.userInfo)")
        }
                        var allwindsCombinedAverage45 = [Double]()
        
                        let sumOfArray45_0 = scoresfromFortyFive_0.reduce(0, {$0 + $1.percentage})
                        let average45_0 = (Double(sumOfArray45_0) / Double(scoresfromFortyFive_0.count))
                        if checkForNan(intake: average45_0) != 0 {
                            allDistancesFor45_0Wind.append(average45_0)
                            allwindsCombinedAverage45.append(average45_0)
                        }
                        print("scoresfromFortyFive_0.count: \(scoresfromFortyFive_0.count)")
                        print("allDistancesFor45_0Wind: \(allDistancesFor45_0Wind)")
        
                        let sumOfArray45_1 = scoresfromFortyFive_1.reduce(0, {$0 + $1.percentage})
                        let average45_1 = (Double(sumOfArray45_1) / Double(scoresfromFortyFive_1.count))
                        if checkForNan(intake: average45_1) != 0 {
                            allDistancesFor45_1Wind.append(average45_1)
                            allwindsCombinedAverage45.append(average45_1)
                        }
        
                        print("scoresfromFortyFive1.count: \(scoresfromFortyFive_1.count)")
                        print("allDistancesFor45_1Wind: \(allDistancesFor45_1Wind)")
        
                        let sumOfArray45_2 = scoresfromFortyFive_2.reduce(0, {$0 + $1.percentage})
                        let average45_2 = (Double(sumOfArray45_2) / Double(scoresfromFortyFive_2.count))
                        if checkForNan(intake: average45_2) != 0 {
                            allDistancesFor45_2Wind.append(average45_2)
                            allwindsCombinedAverage45.append(average45_2)
                        }
                        print("scoresfromFortyFive2.count: \(scoresfromFortyFive_2.count)")
                        print("allDistancesFor45_2Wind: \(allDistancesFor45_2Wind)")
        
                        let sumOfArray45_3 = scoresfromFortyFive_3.reduce(0, {$0 + $1.percentage})
                        let average45_3 = (Double(sumOfArray45_3) / Double(scoresfromFortyFive_3.count))
                        if checkForNan(intake: average45_3) != 0 {
                            allDistancesFor45_3Wind.append(average45_3)
                            allwindsCombinedAverage45.append(average45_3)
                        }
                        print("scoresfromFortyFive3.count: \(scoresfromFortyFive_3.count)")
                        print("allDistancesFor45_3Wind: \(allDistancesFor45_3Wind)")
        
                        let sumOfArray45_4 = scoresfromFortyFive_4.reduce(0, {$0 + $1.percentage})
                        let average45_4 = (Double(sumOfArray45_4) / Double(scoresfromFortyFive_4.count))
                        if checkForNan(intake: average45_4) != 0 {
                            allDistancesFor45_4Wind.append(average45_4)
                            allwindsCombinedAverage45.append(average45_4)
                        }
                        print("scoresfromFortyFive4.count: \(scoresfromFortyFive_4.count)")
                        print("allDistancesFor45_4Wind: \(allDistancesFor45_4Wind)")
        
        
        
                        print("allwindsCombinedAverage45:\(allwindsCombinedAverage45)")
                        let sumOfAllWindsCombinedAverages45 = allwindsCombinedAverage45.reduce(0, {$0 + $1})
                        print("sumOfAllWindsCombinedAverages45: \(sumOfAllWindsCombinedAverages45)")
                        let AverageOfAllWindsCombinedAverages45 = sumOfAllWindsCombinedAverages45 / Double(allwindsCombinedAverage45.count)
                        //allDistancesTotal will be the average of everything from that distances to be the underlying layer in the radar graph.
                        AverageForEachDistanceAllWindConditions.append(AverageOfAllWindsCombinedAverages45)
        
                        print("AverageForEachDistanceAllWindConditions[7]: \(AverageForEachDistanceAllWindConditions)")
                        print("AverageForEachDistanceAllWindConditions.count: \(AverageForEachDistanceAllWindConditions.count)")
        
        
        
        let fetchRequest50_0: NSFetchRequest<FiftyFeetScores> = FiftyFeetScores.fetchRequest()
        let fetchRequest50_1: NSFetchRequest<FiftyFeetScores> = FiftyFeetScores.fetchRequest()
        let fetchRequest50_2: NSFetchRequest<FiftyFeetScores> = FiftyFeetScores.fetchRequest()
        let fetchRequest50_3: NSFetchRequest<FiftyFeetScores> = FiftyFeetScores.fetchRequest()
        let fetchRequest50_4: NSFetchRequest<FiftyFeetScores> = FiftyFeetScores.fetchRequest()
        
        fetchRequest50_0.predicate = NSPredicate(format: "%K == %@", #keyPath(FiftyFeetScores.windDirection), "0")
        fetchRequest50_1.predicate = NSPredicate(format: "%K == %@", #keyPath(FiftyFeetScores.windDirection), "1")
        fetchRequest50_2.predicate = NSPredicate(format: "%K == %@", #keyPath(FiftyFeetScores.windDirection), "2")
        fetchRequest50_3.predicate = NSPredicate(format: "%K == %@", #keyPath(FiftyFeetScores.windDirection), "3")
        fetchRequest50_4.predicate = NSPredicate(format: "%K == %@", #keyPath(FiftyFeetScores.windDirection), "4")
        do {
            
            let sortedScores50_0 = try PersistenceService.context.fetch(fetchRequest50_0)
            self.scoresfromFifty_0 = sortedScores50_0
            print("fetched 0 done")
            let sortedScores50_1 = try PersistenceService.context.fetch(fetchRequest50_1)
            self.scoresfromFifty_1 = sortedScores50_1
            print("fetched 1 done")
            let sortedScores50_2 = try PersistenceService.context.fetch(fetchRequest50_2)
            self.scoresfromFifty_2 = sortedScores50_2
            print("fetched 2 done")
            let sortedScores50_3 = try PersistenceService.context.fetch(fetchRequest50_3)
            self.scoresfromFifty_3 = sortedScores50_3
            print("fetched 3 done")
            let sortedScores50_4 = try PersistenceService.context.fetch(fetchRequest50_4)
            self.scoresfromFifty_4 = sortedScores50_4
            print("fetched 4 done")
            
        } catch let error as NSError {
            print("Could not fetch from 40coredata. \(error), \(error.userInfo)")
        }
                        var allwindsCombinedAverage50 = [Double]()
        
                        let sumOfArray50_0 = scoresfromFifty_0.reduce(0, {$0 + $1.percentage})
                        let average50_0 = (Double(sumOfArray50_0) / Double(scoresfromFifty_0.count))
                        if checkForNan(intake: average50_0) != 0 {
                            allDistancesFor50_0Wind.append(average50_0)
                            allwindsCombinedAverage50.append(average50_0)
                        }
                        print("scoresfromFifty_0.count: \(scoresfromFifty_0.count)")
                        print("allDistancesFor50_0Wind: \(allDistancesFor50_0Wind)")
        
                        let sumOfArray50_1 = scoresfromFifty_1.reduce(0, {$0 + $1.percentage})
                        let average50_1 = (Double(sumOfArray50_1) / Double(scoresfromFifty_1.count))
                        if checkForNan(intake: average50_1) != 0 {
                            allDistancesFor50_1Wind.append(average50_1)
                            allwindsCombinedAverage50.append(average50_1)
                        }
        
                        print("scoresfromFifty1.count: \(scoresfromFifty_1.count)")
                        print("allDistancesFor50_1Wind: \(allDistancesFor50_1Wind)")
        
                        let sumOfArray50_2 = scoresfromFifty_2.reduce(0, {$0 + $1.percentage})
                        let average50_2 = (Double(sumOfArray50_2) / Double(scoresfromFifty_2.count))
                        if checkForNan(intake: average50_2) != 0 {
                            allDistancesFor50_2Wind.append(average50_2)
                            allwindsCombinedAverage50.append(average50_2)
                        }
                        print("scoresfromFifty2.count: \(scoresfromFifty_2.count)")
                        print("allDistancesFor50_2Wind: \(allDistancesFor50_2Wind)")
        
                        let sumOfArray50_3 = scoresfromFortyFive_3.reduce(0, {$0 + $1.percentage})
                        let average50_3 = (Double(sumOfArray50_3) / Double(scoresfromFortyFive_3.count))
                        if checkForNan(intake: average50_3) != 0 {
                            allDistancesFor50_3Wind.append(average50_3)
                            allwindsCombinedAverage50.append(average50_3)
                        }
                        print("scoresfromFifty3.count: \(scoresfromFortyFive_3.count)")
                        print("allDistancesFor50_3Wind: \(allDistancesFor50_3Wind)")
        
                        let sumOfArray50_4 = scoresfromFifty_4.reduce(0, {$0 + $1.percentage})
                        let average50_4 = (Double(sumOfArray50_4) / Double(scoresfromFifty_4.count))
                        if checkForNan(intake: average50_4) != 0 {
                            allDistancesFor50_4Wind.append(average50_4)
                            allwindsCombinedAverage50.append(average50_4)
                        }
                        print("scoresfromFifty4.count: \(scoresfromFifty_4.count)")
                        print("allDistancesFor50_4Wind: \(allDistancesFor50_4Wind)")
        
        
        
                        print("allwindsCombinedAverage50:\(allwindsCombinedAverage50)")
                        let sumOfAllWindsCombinedAverages50 = allwindsCombinedAverage50.reduce(0, {$0 + $1})
                        print("sumOfAllWindsCombinedAverages50: \(sumOfAllWindsCombinedAverages50)")
                        let AverageOfAllWindsCombinedAverages50 = sumOfAllWindsCombinedAverages50 / Double(allwindsCombinedAverage50.count)
                        //allDistancesTotal will be the average of everything from that distances to be the underlying layer in the radar graph.
                        AverageForEachDistanceAllWindConditions.append(AverageOfAllWindsCombinedAverages50)
        
                        print("AverageForEachDistanceAllWindConditions[8]: \(AverageForEachDistanceAllWindConditions)")
                        print("AverageForEachDistanceAllWindConditions.count: \(AverageForEachDistanceAllWindConditions.count)")
        
        
        let allZeroWinds_ParentArray = [allDistancesFor10_0Wind, allDistancesFor15_0Wind,allDistancesFor20_0Wind,allDistancesFor25_0Wind,allDistancesFor30_0Wind,allDistancesFor35_0Wind,allDistancesFor40_0Wind,allDistancesFor45_0Wind,allDistancesFor50_0Wind]
        
        let allOneWinds_ParentArray = [allDistancesFor10_1Wind, allDistancesFor15_1Wind,allDistancesFor20_1Wind,allDistancesFor25_1Wind,allDistancesFor30_1Wind,allDistancesFor35_1Wind,allDistancesFor40_1Wind,allDistancesFor45_1Wind,allDistancesFor50_1Wind]
        
         let allTwoWinds_ParentArray = [allDistancesFor10_2Wind, allDistancesFor15_2Wind,allDistancesFor20_2Wind,allDistancesFor25_2Wind,allDistancesFor30_2Wind,allDistancesFor35_2Wind,allDistancesFor40_2Wind,allDistancesFor45_2Wind,allDistancesFor50_2Wind]
        
        let allThreeWinds_ParentArray = [allDistancesFor10_3Wind, allDistancesFor15_3Wind,allDistancesFor20_3Wind,allDistancesFor25_3Wind,allDistancesFor30_3Wind,allDistancesFor35_3Wind,allDistancesFor40_3Wind,allDistancesFor45_3Wind,allDistancesFor50_3Wind]
        
        let allFourWinds_ParentArray = [allDistancesFor10_4Wind, allDistancesFor15_4Wind,allDistancesFor20_4Wind,allDistancesFor25_4Wind,allDistancesFor30_4Wind,allDistancesFor35_4Wind,allDistancesFor40_4Wind,allDistancesFor45_4Wind,allDistancesFor50_4Wind]
        
        var grandParentArray = [allZeroWinds_ParentArray, allOneWinds_ParentArray,allTwoWinds_ParentArray,allThreeWinds_ParentArray,allFourWinds_ParentArray ]
        var dataSetArraysForRadarGraph = [allWindsFor_0Wind, allWindsFor_1Wind,allWindsFor_2Wind,allWindsFor_3Wind,allWindsFor_4Wind,]

        for element in 0..<5 {
                for number in 0..<9 {

                    if (grandParentArray[element])[number].isEmpty {
                        print((grandParentArray[element])[number].isEmpty)
                        // allWindsFor_0Wind.append(0)
                        switch element {
                        case 0: allWindsFor_0Wind.append(0)
                        case 1: allWindsFor_1Wind.append(0)
                        case 2: allWindsFor_2Wind.append(0)
                        case 3: allWindsFor_3Wind.append(0)
                        case 4: allWindsFor_4Wind.append(0)
                        default: return
                        }
                    } else {
                       let sum =  (grandParentArray[element])[number].reduce(0, {$0 + $1})
                        let average = (sum / Double((grandParentArray[element])[number].count))
                      //  allWindsFor_0Wind.append(average)
                        switch element {
                        case 0: allWindsFor_0Wind.append(average)
                        case 1: allWindsFor_1Wind.append(average)
                        case 2: allWindsFor_2Wind.append(average)
                        case 3: allWindsFor_3Wind.append(average)
                        case 4: allWindsFor_4Wind.append(average)
                        default: return
                        }
                        
                    }
                    print("allZeroWinds_ParentArray\(element).count: \(dataSetArraysForRadarGraph[element].count)")
                    print("allZeroWinds_ParentArray\(element): \(dataSetArraysForRadarGraph[element])")
                }
        }

        
//
//                            for number in 0..<9 {
//
//                                if allZeroWinds_ParentArray[number].isEmpty {
//                                    allWindsFor_0Wind.append(0)
//                                } else {
//                                   let sum =  allZeroWinds_ParentArray[number].reduce(0, {$0 + $1})
//                                    let average = (sum / Double(allZeroWinds_ParentArray[number].count))
//                                    allWindsFor_0Wind.append(average)
//                                }
//                                print("allZeroWinds_ParentArray1.count: \(allWindsFor_0Wind.count)")
//                                print("allZeroWinds_ParentArray1: \(allWindsFor_0Wind)")
//                            }
//
//
//
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
//
//    func configureRadarChartDataEntryArray() -> [RadarChartDataEntry]{
//        var dataRadarChartDataEntryArray = [Double]()
//
//        let sumOfScoreTaken = scoresfromTen_0.reduce(0, {$0 + $1.percentage})
//        let average10Score = Double(sumOfScoreTaken) / Double(scoresfromTen_0.count)
//                dataRadarChartDataEntryArray.append(average10Score)
//        let sumOfScoreTaken15 = scoresfromFifteen.reduce(0, {$0 + $1.percentage})
//        let average15Score = Double(sumOfScoreTaken15) / Double(scoresfromFifteen.count)
//                dataRadarChartDataEntryArray.append(average15Score)
//        let sumOfScoreTaken20 = scoresfromTwenty.reduce(0, {$0 + $1.percentage})
//        let average20Score = Double(sumOfScoreTaken20) / Double(scoresfromTwenty.count)
//                dataRadarChartDataEntryArray.append(average20Score)
//        print("dataRadarChartDataEntryArray: \(dataRadarChartDataEntryArray)")
//
//     //   let container = getTotalFromTenFeet(Average: dataRadarChartDataEntryArray)
//
//
//        return container
//    }
    
    func convertToRadarChartDataEntry(Average: [Double]) -> [RadarChartDataEntry]  {
        var container = [RadarChartDataEntry]()
       
        for index in Average.indices{
            print("Average index: \(Average[index])")
            let XXX = RadarChartDataEntry(value: Average[index])
            print("XXX: \(XXX)")
            container.append(XXX)
        }
        print("indeces: \(Average.indices)")
            return container
    }
    
    
    
    
    
    
    
    
    
    

    override func updateChartData() {
        if self.shouldHideData {
            chartView.data = nil
            return
        }
        
        self.setChartData()
    }
    
    
    
    
    var set2Label = ""
    var set1Label = ""
    var pickingIndexSet1 = 0
    var pickingIndexSet2 = 6
    func setChartData() {
    
        
        
        // These arrays are fake data to populate the radar chart for testing purposes.
        
//        let allwinds0Temp = [100.0, 95.0, 90.0] // 88.4, 92.0, 55.0, 32.9]
//        let allwinds1Temp = [95.0, 98.0, 80.0, 78.4, 62.0, 65.0, 22.9, 42.0]
//        let allwinds2Temp = [90.0, 90.0, 60.0, 68.4, 82.0, 75.0, 12.9]
//        let allwinds3Temp = [93.0, 92.0, 90.0, 98.4, 97.0, 78.0, 52.9]
//        let allwinds4Temp = [83.0, 96.0, 96.0] // 60.4, 72.0, 72.0, 32.9]
//
//
//        let EmptyStartingArrray7 = [0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]
//        let myEntry0 = convertToRadarChartDataEntry(Average: AverageForEachDistanceAllWindConditions)
//        let myEntry1 = convertToRadarChartDataEntry(Average: allwinds0Temp)
//        let myEntry2 = convertToRadarChartDataEntry(Average: allwinds1Temp)
//        let myEntry3 = convertToRadarChartDataEntry(Average: allwinds2Temp)
//        let myEntry4 = convertToRadarChartDataEntry(Average: allwinds3Temp)
//        let myEntry5 = convertToRadarChartDataEntry(Average: allwinds4Temp)
//        let myEntry6 = convertToRadarChartDataEntry(Average: EmptyStartingArrray7)
//
        // End of fake data entry section
        
        let EmptyStartingArrray7 = [Double]()
        let myEntry0 = convertToRadarChartDataEntry(Average: AverageForEachDistanceAllWindConditions)
        let myEntry1 = convertToRadarChartDataEntry(Average: allWindsFor_0Wind)
        let myEntry2 = convertToRadarChartDataEntry(Average: allWindsFor_1Wind)
        let myEntry3 = convertToRadarChartDataEntry(Average: allWindsFor_2Wind)
        let myEntry4 = convertToRadarChartDataEntry(Average: allWindsFor_3Wind)
        let myEntry5 = convertToRadarChartDataEntry(Average: allWindsFor_4Wind)
        let myEntry6 = convertToRadarChartDataEntry(Average: EmptyStartingArrray7)

        
        var myEntryArray = [myEntry0, myEntry1, myEntry2, myEntry3, myEntry4, myEntry5, myEntry6]
        let set1 = RadarChartDataSet(values: myEntryArray[pickingIndexSet1], label: pickerViewOptions[pickingIndexSet1])
        // set color is red
        set1.setColor(UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 1))
        set1.fillColor = UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 1)
        set1.drawFilledEnabled = true
        set1.fillAlpha = 0.7
        set1.lineWidth = 2
        set1.drawHighlightCircleEnabled = true
        set1.setDrawHighlightIndicators(false)
        
        
        let set2 = RadarChartDataSet(values: myEntryArray[pickingIndexSet2], label: pickerViewOptions[pickingIndexSet2])
        //set color is teal Blue
        set2.setColor(UIColor(red: 90/255, green: 200/255, blue: 250/255, alpha: 1))
        set2.fillColor = UIColor(red: 90/255, green: 200/255, blue: 250/255, alpha: 1)
        set2.drawFilledEnabled = true
        set2.fillAlpha = 0.7
        set2.lineWidth = 2
        set2.drawHighlightCircleEnabled = true
        set2.setDrawHighlightIndicators(false)
    
        
        let data = RadarChartData(dataSets: [set1, set2])
        data.setValueFont(.systemFont(ofSize: 8, weight: .light))
        data.setDrawValues(false)
        data.setValueTextColor(.black)
        
        chartView.data = data
    }
    
    override func optionTapped(_ option: Option) {
        switch option {
        case .toggleXLabels:
            chartView.xAxis.drawLabelsEnabled = !chartView.xAxis.drawLabelsEnabled
            chartView.data?.notifyDataChanged()
            chartView.notifyDataSetChanged()
            chartView.setNeedsDisplay()
            
        case .toggleYLabels:
            chartView.yAxis.drawLabelsEnabled = !chartView.yAxis.drawLabelsEnabled
            chartView.setNeedsDisplay()
            
        case .toggleRotate:
            chartView.rotationEnabled = !chartView.rotationEnabled
            
        case .toggleFilled:
            for set in chartView.data!.dataSets as! [RadarChartDataSet] {
                set.drawFilledEnabled = !set.drawFilledEnabled
            }
            
            chartView.setNeedsDisplay()
            
        case .toggleHighlightCircle:
            for set in chartView.data!.dataSets as! [RadarChartDataSet] {
                set.drawHighlightCircleEnabled = !set.drawHighlightCircleEnabled
            }
            chartView.setNeedsDisplay()
            
        case .animateX:
            chartView.animate(xAxisDuration: 1.4)
            
        case .animateY:
            chartView.animate(yAxisDuration: 1.4)
            
        case .animateXY:
            chartView.animate(xAxisDuration: 1.4, yAxisDuration: 1.4)
            
        case .spin:
            chartView.spin(duration: 2, fromAngle: chartView.rotationAngle, toAngle: chartView.rotationAngle + 360, easingOption: .easeInCubic)
            
        default:
            super.handleOption(option, forChartView: chartView)
        }
    }

    
    
    func setPickerView(){
        
        let windPicker1 = UIPickerView()
        let windPicker2 = UIPickerView()
        windPicker1.delegate = self
        windPicker2.delegate = self
        pickerViewTextField.inputView = windPicker1
        pickerViewTextField.inputView?.tag = 1
        pickerViewTextField2.inputView = windPicker2
        pickerViewTextField2.inputView?.tag = 2
   
        //  Customization:
        
      
        
    }

    
   //This may have to change back, it was commented out using extension of UiViewController in the signInVC
    
//    @objc func dismissKeyboard() {
//        view.endEditing(true)
//    }
//
    func createToolBar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(RadarChartViewController.dismissKeyboard))
        
        toolbar.setItems([doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        pickerViewTextField.inputAccessoryView = toolbar
        pickerViewTextField2.inputAccessoryView = toolbar
        
        //  Customization:

    }
    
    //Todo: pickerViewOptions Array is two spots, here and view didload. ??
    let pickerViewOptions = ["All Conditions", "No Wind", "Head Wind", "Tail Wind", "Right-to-Left", "Left-to-Right", ""]
    let pickerViewOptionsForLabel = ["All Conditions", "No Wind", "Head Wind", "Tail Wind", "Right-to-Left", "Left-to-Right", ""]
    

    @IBOutlet weak var pickerViewTextField: UITextField!
    @IBOutlet weak var pickerViewTextField2: UITextField!
    
    var selectedWindOption1String = ""
    var selectedWindOption2String = ""
    
    
}

extension RadarChartViewController: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return activities[Int(value) % activities.count]
    }
}

extension RadarChartViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
      return  pickerViewOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerViewOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("tag: \(pickerView.tag)")
        if pickerView.tag == 1 {
            selectedWindOption1String = pickerViewOptions[row]
            pickerViewTextField.text = selectedWindOption1String
            switch row {
            case 0: pickingIndexSet1 = 0
            case 1: pickingIndexSet1 = 1
            case 2: pickingIndexSet1 = 2
            case 3: pickingIndexSet1 = 3
            case 4: pickingIndexSet1 = 4
            case 5: pickingIndexSet1 = 5
            case 6: pickingIndexSet1 = 6
            default: return
            }
            
        } else if pickerView.tag == 2 {
          selectedWindOption2String = pickerViewOptions[row]
            pickerViewTextField2.text = selectedWindOption2String

            switch row {
            case 0: pickingIndexSet2 = 0
            case 1: pickingIndexSet2 = 1
            case 2: pickingIndexSet2 = 2
            case 3: pickingIndexSet2 = 3
            case 4: pickingIndexSet2 = 4
            case 5: pickingIndexSet2 = 5
            case 6: pickingIndexSet2 = 6
            default: return
            }
            
            
        }
       
        
        
        
        
      
       chartView.clearValues()
       // chartView.clear()
         chartView.notifyDataSetChanged()
       viewDidLoad()
        
    }
    
    
}


