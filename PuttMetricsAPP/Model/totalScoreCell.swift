//
//  totalScoreCell.swift
//  PuttMetricsAPP
//
//  Created by User on 12/19/17.
//  Copyright © 2017 DustinPerry. All rights reserved.
//


import UIKit

class totalScoreCustomCell: UITableViewCell {
    
    
    
    @IBOutlet weak var awardImage0: UIImageView!
    @IBOutlet weak var awardImage1: UIImageView!
    @IBOutlet weak var awardImage2: UIImageView!
    @IBOutlet weak var awardImage3: UIImageView!
    @IBOutlet weak var awardImage4: UIImageView!
    @IBOutlet weak var awardImage5: UIImageView!
    @IBOutlet weak var awardImage6: UIImageView!
    @IBOutlet weak var awardImage7: UIImageView!
    @IBOutlet weak var awardImage8: UIImageView!
    
    @IBOutlet weak var averagePercentLabel: UILabel!
    @IBOutlet weak var levelsPassedLabel: UILabel!
    @IBOutlet weak var perfectLevelsLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    @IBOutlet weak var totalScoreFirstView: UIView!
    
    @IBOutlet weak var totalScoreSecondView: UIView!
    
    @IBOutlet weak var secondHeightConstraintTotalScore: NSLayoutConstraint!
    
    @IBOutlet weak var totalScoreLabel: UILabel!
    
    var showsDetails = false {
        didSet {
            secondHeightConstraintTotalScore.priority = UILayoutPriority(rawValue: UILayoutPriority.RawValue(showsDetails ? 250 : 999))
        }
    }
    
    
    
    
}
