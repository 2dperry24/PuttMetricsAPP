//
//  FivePuttsPerLevelGameViewController.swift
//  PuttMetricsAPP
//
//  Created by User on 12/2/17.
//  Copyright © 2017 DustinPerry. All rights reserved.
//

import UIKit



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
        
        loadDistances()
        
        let displayView = Bundle.main.loadNibNamed("FivePutts", owner: self, options: nil)?.first as? FivePuttsXib
        self.view.addSubview(displayView!)
        
        
    }


    func loadDistances() {
        for (index, feature) in distanceMarksArray.enumerated() {
            if let displayView = Bundle.main.loadNibNamed("FivePutts", owner: self, options: nil)?.first as? FivePuttsXib {
              displayView.distanceToPuttLevelLBL.text = String(distanceMarksArray[index])
                print("We got here,index = \(index)")
                print("Feature = \(feature)")
                
                
                displayView.frame.size.width = self.view.bounds.size.width
                displayView.frame.origin.x = CGFloat(index) * self.view.bounds.size.width
                print("\(displayView.frame.origin.x)")
                
                ProgressRingScrollView.addSubview(displayView)
                displayView.missedPuttBTN.addTarget(self, action: #selector(FivePuttsPerLevelGameViewController.missedPutt(sender:)), for: .touchUpInside)
                
            }
        }

        }
    
    
    @objc func missedPutt(sender: UIButton) {
     
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
   
    // MARK: - Navigation

   
}


