//
//  ProgressRings.swift
//  PuttMetricsAPP
//
//  Created by User on 12/22/17.
//  Copyright © 2017 DustinPerry. All rights reserved.
//

import UIKit
import ConcentricProgressRingView


class ProgressRings: UIViewController {

   
  
   
   
        @IBOutlet weak var ProgressRingScrollView: UIScrollView!
        
        let distanceMarksArray = [10, 15, 20, 25, 30, 35, 40, 45, 50]
        
        
        override func viewDidLoad()
        {
            ProgressRingScrollView.isPagingEnabled = true
            
            ProgressRingScrollView.contentSize = CGSize(width: self.view.bounds.width * CGFloat(distanceMarksArray.count), height: 1)
            
            ProgressRingScrollView.showsHorizontalScrollIndicator = false
            
            loadDistancesIntoScrollView()
        }
        
        
        
        func loadDistancesIntoScrollView()
        {
            for (index, feature) in distanceMarksArray.enumerated()
            {
                if let displayView = Bundle.main.loadNibNamed("FivePutts", owner: self, options: nil)?.first as? FivePuttsXib
                {
                    displayView.DistanceOfPuttLevelLBL.text = String(distanceMarksArray[index])
                    print("We got here,index = \(index)")
                    print("Feature = \(feature)")
                    
                 displayView.frame.size.width = self.ProgressRingScrollView.bounds.size.width

                  displayView.frame.origin.x = CGFloat(index) * self.ProgressRingScrollView.bounds.size.width
                    print("\(displayView.frame.origin.x)")
              //     displayView.frame.origin.y = self.ProgressRingScrollView.bounds.size.height - displayView.frame.size.height
                    
                    // Here I am using the function to place to progress rings circle into the scroll view. The function returns a value that I have set as TempRingVariable. I placed that variable as a subview in progressRingViewDisplayBox (thats a view in the nib file). However, I can't figure out how to get the circle to reposition inside in the center of the view and not down and away like it is currently. perhaps you can figure out how to contain the circles within the view that they are set in. Also having the button functionality is ultimately what I am hoping you can solve for me. I have outlined some info in the setRingCirlceWithinEachDistance() on how to progress the ring when missed or made button is pressed. When those buttons are pressed though, I want the totalPuttsTakenLabel between them to update with total amount of putts/shots taken at that distance. So for each distance I need to be able to store those values (totalputtsTaken and how many were missed and made so I can create percentages on a future part of this app). Hope this info helps. To recap: My hope is you can get the missed and made buttons to move the progress ring, create variable to store each value of total, missed and made for each distance. Lastly, ifyou can set the circle within the view that would really help. thanks.
                    
                    
                    let TempRingVariable = setRingCirlceWithinEachDistance(owner:displayView.progressRingViewDisplayBox)
                    
                    TempRingVariable.bounds = displayView.progressRingViewDisplayBox.bounds;
                    TempRingVariable.backgroundColor = UIColor.clear
                    
                    displayView.progressRingViewDisplayBox.addSubview(TempRingVariable)
                    
                    ProgressRingScrollView.addSubview(displayView)
                    
                    displayView.missedPuttBTN.tag = index;
                    displayView.madeBtn.tag = index;
                    
                    displayView.missedPuttBTN.addTarget(self, action: #selector(FivePuttsPerLevelGameViewController.missedPutt(sender:)), for: .touchUpInside)
                    displayView.madeBtn.addTarget(self, action: #selector(FivePuttsPerLevelGameViewController.madePutt(sender:)), for: .touchUpInside)
                }
            }
        }
        
        
        @objc func missedPutt(sender: UIButton)
        {
            let displayView : FivePuttsXib = self.ProgressRingScrollView.subviews[sender.tag] as! FivePuttsXib
            
            let ringView :ConcentricProgressRingView = displayView.progressRingViewDisplayBox.subviews[0]  as! ConcentricProgressRingView
            
            if ringView.arcs[1].progress == 1.0
            {
                if ringView.arcs[2].progress == 1.0
                {
                    if ringView.arcs[3].progress == 1.0
                    {
                        if ringView.arcs[4].progress == 1.0
                        {
                            if ringView.arcs[5].progress == 1.0
                            {
                            }
                            else
                            {
                                ringView.arcs[5].progress = 1.0
                            }
                        }
                        else
                        {
                            ringView.arcs[4].progress = 1.0
                            
                        }
                    }
                    else
                    {
                        ringView.arcs[3].progress = 1.0
                        
                    }
                }
                else
                {
                    ringView.arcs[2].progress = 1.0
                   
                }
            }
            else
            {
                ringView.arcs[1].progress = 1.0
            changeRingColor()
            }
            
            
        }
        
        @objc func madePutt(sender: UIButton)
        {
            let displayView : FivePuttsXib = self.ProgressRingScrollView.subviews[sender.tag] as! FivePuttsXib
            
            let ringView :ConcentricProgressRingView = displayView.progressRingViewDisplayBox.subviews[0]  as! ConcentricProgressRingView
            
            print(ringView.arcs[0].progress!)
            
            if ringView.arcs[0].progress?.description == "0.0" {
                ringView.arcs[0].progress = ringView.arcs[0].progress! + 1.0
                } else if ringView.arcs[1].progress?.description == "0.0" {
                    changeRingColor()
                    ringView.arcs[1].progress = ringView.arcs[1].progress! + 1.0
                
                    } else if ringView.arcs[2].progress?.description == "0.0" {
                        ringView.arcs[2].progress = ringView.arcs[2].progress! + 1.0
                        } else if ringView.arcs[3].progress?.description == "0.0" {
                            ringView.arcs[3].progress = ringView.arcs[3].progress! + 1.0
                            } else if ringView.arcs[4].progress?.description == "0.0" {
                                ringView.arcs[4].progress = ringView.arcs[4].progress! + 1.0
                                } else if ringView.arcs[5].progress?.description == "0.0" {
                                ringView.arcs[5].progress = ringView.arcs[5].progress! + 1.0
                                }
        }
        
        
    
    
    
        
        func setRingCirlceWithinEachDistance(owner: UIView) -> ConcentricProgressRingView
        {
            let margin: CGFloat = 2
            let radius: CGFloat = owner.frame.size.width/2
            
            var rings = [
                ProgressRing(color: UIColor.green, backgroundColor: UIColor.lightGray, width: (owner.frame.size.width/2)/7),
                ProgressRing(color: UIColor.red, backgroundColor: UIColor.lightGray, width: (owner.frame.size.width/2)/7),
                ProgressRing(color: UIColor.red, backgroundColor: UIColor.lightGray, width: (owner.frame.size.width/2)/7),
                ProgressRing(color: UIColor.red, backgroundColor: UIColor.lightGray, width: (owner.frame.size.width/2)/7),
                ProgressRing(color: UIColor.red, backgroundColor: UIColor.lightGray, width: (owner.frame.size.width/2)/7),
                ProgressRing(color: UIColor.red, backgroundColor: UIColor.lightGray, width: (owner.frame.size.width/2)/7),
                ]
            let progressRingView = try! ConcentricProgressRingView(center: CGPoint.init(x: (owner.frame.size.width/2 - 0), y: (owner.frame.size.height/2 - 0)), radius: radius, margin: margin, rings: rings, defaultWidth: 30)
            
            // using this line of code below is the only way I know how to get the progress rings to do anything. The only thing I want to happen when its loaded is have the outer green ring set to 0.5. Then I want the missed and made button to be able to progress the rings like the cocaopods states is possible. Meaning have the each missed and made button be able to progress the outer green ring 0.1. Therefore, 5 made shots in a row would net a full green ring. 5 missed shots in row would net a ring with zero green. Each missed button would also turn a red inner ring fully red. 5 missed would have all the red rings filled within the green ring. Hope that makes sense.
            
          //  progressRingView.arcs[0].progress = 0.5
           
            
            return progressRingView
        }
    
    
    
    func changeRingColor() {
       
        var rings = [
            ProgressRing(color: UIColor.green, backgroundColor: UIColor.lightGray),
            ProgressRing(color: UIColor.red, backgroundColor: UIColor.lightGray),
            ProgressRing(color: UIColor.red, backgroundColor: UIColor.lightGray),
            ProgressRing(color: UIColor.red, backgroundColor: UIColor.lightGray),
            ProgressRing(color: UIColor.red, backgroundColor: UIColor.lightGray),
            ProgressRing(color: UIColor.red, backgroundColor: UIColor.lightGray),
            ]
        //let progressRingView = try! ConcentricProgressRingView(center: CGPoint.init(x: (owner.frame.size.width/2 - 0), y: (owner.frame.size.height/2 - 0)), radius: radius, margin: margin, rings: rings, defaultWidth: 30)
        
    rings[1]?.color = UIColor.blue
        print(rings[1]!.color!.description)
    
    }

//@objc func missedPutt(sender: UIButton)
//{
//    let displayView : FivePuttsXib = self.ProgressRingScrollView.subviews[sender.tag] as! FivePuttsXib
//
//    let ringView :ConcentricProgressRingView = displayView.progressRingViewDisplayBox.subviews[0]  as! ConcentricProgressRingView
//
//    if ringView.arcs[1].progress == 1.0
//    {
//        if ringView.arcs[2].progress == 1.0
//        {
//            if ringView.arcs[3].progress == 1.0
//            {
//                if ringView.arcs[4].progress == 1.0
//                {
//                    if ringView.arcs[5].progress == 1.0
//                    {
//                    }
//                    else
//                    {
//                        ringView.arcs[5].progress = 1.0
//                        if ringView.arcs[0].progress! > CGFloat(0.0) {
//                            ringView.arcs[0].progress = ringView.arcs[0].progress! - 0.2
//                        }
//                    }
//                }
//                else
//                {
//                    ringView.arcs[4].progress = 1.0
//                    if ringView.arcs[0].progress! > CGFloat(0.0) {
//                        ringView.arcs[0].progress = ringView.arcs[0].progress! - 0.2
//                    }
//                }
//            }
//            else
//            {
//                ringView.arcs[3].progress = 1.0
//                if ringView.arcs[0].progress! > CGFloat(0.0) {
//                    ringView.arcs[0].progress = ringView.arcs[0].progress! - 0.2
//                }
//            }
//        }
//        else
//        {
//            ringView.arcs[2].progress = 1.0
//
//            if ringView.arcs[0].progress! > CGFloat(0.0) {
//                ringView.arcs[0].progress = ringView.arcs[0].progress! - 0.2
//            }
//        }
//    }
//    else
//    {
//        ringView.arcs[1].progress = 1.0
//        if ringView.arcs[0].progress! > CGFloat(0.0) {
//            ringView.arcs[0].progress = ringView.arcs[0].progress! - 0.2
//        }
//    }
//}
//
//@objc func madePutt(sender: UIButton)
//{
//    let displayView : FivePuttsXib = self.ProgressRingScrollView.subviews[sender.tag] as! FivePuttsXib
//
//    let ringView :ConcentricProgressRingView = displayView.progressRingViewDisplayBox.subviews[0]  as! ConcentricProgressRingView
//
//    print(ringView.arcs[0].progress!)
//
//    if ringView.arcs[0].progress?.description != "1.0"
//    {
//        ringView.arcs[0].progress = ringView.arcs[0].progress! + 0.2
//    }
//}

}
