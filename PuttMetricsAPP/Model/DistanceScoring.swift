//
//  DistanceScoring.swift
//  PuttMetricsAPP
//
//  Created by User on 12/6/17.
//  Copyright © 2017 DustinPerry. All rights reserved.
//

import UIKit



class DistanceScoring {
    
    var  percentage : Double
    var totalPuttsTaken: Int
    
    init(totalPuttsTaken: Int, percentage: Double) {
        self.totalPuttsTaken = totalPuttsTaken
        self.percentage = percentage
    }
}



