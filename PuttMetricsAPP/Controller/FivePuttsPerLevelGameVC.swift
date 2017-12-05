//
//  FivePuttsPerLevelGameViewController.swift
//  PuttMetricsAPP
//
//  Created by User on 12/2/17.
//  Copyright © 2017 DustinPerry. All rights reserved.
//

import UIKit
import ConcentricProgressRingView


class FivePuttsPerLevelGameViewController: UIViewController{

    
    @IBOutlet weak var ProgressRingScrollView: UIScrollView!
 
    
    let distanceMarksArray = [10, 15, 20, 25, 30, 35, 40, 45, 50]
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()
        
   
        
    }
    
    
    
    
    override func viewDidLoad() {

        
        
        
        ProgressRingScrollView.isPagingEnabled = true
        ProgressRingScrollView.contentSize = CGSize(width: self.view.bounds.width * CGFloat(distanceMarksArray.count), height: self.view.bounds.height)
        ProgressRingScrollView.showsHorizontalScrollIndicator = false
        
        loadDistancesIntoScrollView()
        
        
        
        
        
        
    
        
        
    }

    
    
    
    
    //MARK: Here I am trying to load the concentric ring circls onto a scroll view so it will display the ring for each of the values in distanceMarksArray. The view is located in the fivePutts.xib file. To recap, at the first level it will display there distance, which is 10 in the given distancemarksArray. I want the 

    func loadDistancesIntoScrollView() {
        for (index, feature) in distanceMarksArray.enumerated() {
            if let displayView = Bundle.main.loadNibNamed("FivePutts", owner: self, options: nil)?.first as? FivePuttsXib {
              displayView.DistanceOfPuttLevelLBL.text = String(distanceMarksArray[index])
                print("We got here,index = \(index)")
                print("Feature = \(feature)")
                
                
                displayView.frame.size.width = self.view.bounds.size.width
                displayView.frame.origin.x = CGFloat(index) * self.view.bounds.size.width
                print("\(displayView.frame.origin.x)")
                
                
                // Here I am using the function to place to progress rings circle into the scroll view. The function returns a value that I have set as TempRingVariable. I placed that variable as a subview in progressRingViewDisplayBox (thats a view in the nib file). However, I can't figure out how to get the circle to reposition inside in the center of the view and not down and away like it is currently. perhaps you can figure out how to contain the circles within the view that they are set in. Also having the button functionality is ultimately what I am hoping you can solve for me. I have outlined some info in the setRingCirlceWithinEachDistance() on how to progress the ring when missed or made button is pressed. When those buttons are pressed though, I want the totalPuttsTakenLabel between them to update with total amount of putts/shots taken at that distance. So for each distance I need to be able to store those values (totalputtsTaken and how many were missed and made so I can create percentages on a future part of this app). Hope this info helps. To recap: My hope is you can get the missed and made buttons to move the progress ring, create variable to store each value of total, missed and made for each distance. Lastly, ifyou can set the circle within the view that would really help. thanks.
                
                
                setRingCirlceWithinEachDistance()
                
                let TempRingVariable = setRingCirlceWithinEachDistance()
                
                 displayView.progressRingViewDisplayBox.addSubview(TempRingVariable)
                
                
                ProgressRingScrollView.addSubview(displayView)
               
                
                
                
            //    displayView.addSubview(ringProgessView)
                
                
                displayView.missedPuttBTN.addTarget(self, action: #selector(FivePuttsPerLevelGameViewController.missedPutt(sender:)), for: .touchUpInside)
                displayView.missedPuttBTN.addTarget(self, action: #selector(FivePuttsPerLevelGameViewController.madePutt(sender:)), for: .touchUpInside)
            }
        }

        }
    
    
    @objc func missedPutt(sender: UIButton) {
     
    }
    
    @objc func madePutt(sender: UIButton) {
        
    }
    
    
    
    
    
    func setRingCirlceWithinEachDistance() -> ConcentricProgressRingView {
        
        
        
    
        let fgColor1 = UIColor.yellow
        let bgColor1 = UIColor.darkGray
        let fgColor2 = UIColor.green
        let bgColor2 = UIColor.darkGray
      
        let margin: CGFloat = 2
        let radius: CGFloat = 180
        
        
        let rings = [
            ProgressRing(color: UIColor.green, backgroundColor: UIColor.black, width: 30),
            ProgressRing(color: UIColor.clear, backgroundColor: UIColor.red, width: 20),
           ProgressRing(color: UIColor.clear, backgroundColor: UIColor.red, width: 20),
           ProgressRing(color: UIColor.clear, backgroundColor: UIColor.red, width: 20),
           ProgressRing(color: UIColor.clear, backgroundColor: UIColor.red, width: 20),
           ProgressRing(color: UIColor.clear, backgroundColor: UIColor.red, width: 40),
            ]
        let progressRingView = try! ConcentricProgressRingView(center: view.center, radius: radius, margin: margin, rings: rings, defaultWidth: 30)
            
   
        
        
        // using this line of code below is the only way I know how to get the progress rings to do anything. The only thing I want to happen when its loaded is have the outer green ring set to 0.5. Then I want the missed and made button to be able to progress the rings like the cocaopods states is possible. Meaning have the each missed and made button be able to progress the outer green ring 0.1. Therefore, 5 made shots in a row would net a full green ring. 5 missed shots in row would net a ring with zero green. Each missed button would also turn a red inner ring fully red. 5 missed would have all the red rings filled within the green ring. Hope that makes sense.
        
        for ring in progressRingView {
                       ring.progress = 0.5
                 }
            
        
        return progressRingView
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
   
    // MARK: - Navigation

   
}


