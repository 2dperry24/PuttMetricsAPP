//
//  RoundedEdgesLabels.swift
//  PuttMetricsAPP
//
//  Created by User on 12/5/17.
//  Copyright © 2017 DustinPerry. All rights reserved.
//

import Foundation
import UIKit


class RoundedLabel: UILabel {
    
    private lazy var maskLayer: CAShapeLayer = {
        let maskLayer = CAShapeLayer()
        maskLayer.cornerRadius = 5
        maskLayer.masksToBounds = true
        self.layer.mask = maskLayer
        
        return maskLayer
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: [.topRight, .bottomRight, .bottomLeft],
                                    cornerRadii: CGSize(width: 10, height: 10))
        
        maskLayer.path = maskPath.cgPath
        maskLayer.frame = bounds
    }
}
