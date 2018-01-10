//
//  InTheBagDetailsVC.swift
//  PuttMetricsAPP
//
//  Created by User on 1/3/18.
//  Copyright © 2018 DustinPerry. All rights reserved.
//

import UIKit

class InTheBagDetailsVC: UIViewController {

    
    var selection: String!
    @IBOutlet private weak var detailsLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        detailsLabel.text = selection
        
    }



}
