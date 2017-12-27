//
//  DesignableView.swift
//  PuttMetricsAPP
//
//  Created by User on 12/20/17.
//  Copyright © 2017 DustinPerry. All rights reserved.
//

import UIKit

@IBDesignable class DesignableView: UIView {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
   

}
