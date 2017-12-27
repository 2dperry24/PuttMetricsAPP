//
//  tableViewCellResultsPuttOfWarTableViewCell.swift
//  PuttMetricsAPP
//
//  Created by User on 12/11/17.
//  Copyright © 2017 DustinPerry. All rights reserved.
//

import UIKit

class tableViewCellResultsPuttOfWarTableViewCell: UITableViewCell {

    
    
    
    override func awakeFromNib() {
        self.layoutMargins = UIEdgeInsets.zero
        self.preservesSuperviewLayoutMargins = false
    }
    
    
    @IBOutlet weak var imageViewToCreateBorder: UIImageView!
    @IBOutlet weak var awardImage: UIImageView!
    @IBOutlet weak var firstView: UIView!
    
    @IBOutlet weak var secondView: UIView!
    
    @IBOutlet weak var secondHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var LevelPercentageImage: UIImageView!
    @IBOutlet weak var totalPuttsTakenLabel: UILabel!
    
    @IBOutlet weak var comparisonToAverageTotalPuttsLabel: UILabel!
    
    @IBOutlet weak var comparisonToAverageScoreLabel: UILabel!
    
    @IBOutlet weak var LevelAverageImage: UIImageView!
    
    @IBOutlet weak var AverageTotalPuttsLabel: UILabel!
    
    var showsDetails = false {
        didSet {
            secondHeightConstraint.priority = UILayoutPriority(rawValue: UILayoutPriority.RawValue(showsDetails ? 250 : 999))
        }
    }
    
    
    
    
}
