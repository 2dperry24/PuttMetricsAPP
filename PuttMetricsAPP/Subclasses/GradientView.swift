//
//  GradientView.swift
//  PuttMetricsAPP
//
//  Created by User on 12/6/17.
//  Copyright © 2017 DustinPerry. All rights reserved.
//

import UIKit

class GradientView: UIView {

    @IBInspectable var FirstColor: UIColor: UIColor.clear {
    didSet {
    updateView()
    }
    }
    
    
    @IBInspectable var FirstColor: UIColor: UIColor.clear {
    didSet {
    updateView()
    }
    }
    
    override class var layerClass: AnyClass {
        
        get {
            return CAGradientLayer.self
        }
        
    }
    func updateView {
        let layer = self.layer as! CAGradientLayer
        layer.colors = [FirstColor.cgColor, SecondColor.cgColor]
    }
}
