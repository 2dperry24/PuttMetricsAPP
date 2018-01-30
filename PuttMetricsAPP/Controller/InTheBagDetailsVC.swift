//
//  InTheBagDetailsVC.swift
//  PuttMetricsAPP
//
//  Created by User on 1/3/18.
//  Copyright © 2018 DustinPerry. All rights reserved.
//

import UIKit

class InTheBagDetailsVC: UIViewController {

    
    var selection: UIImage!

    @IBOutlet weak var Imagedetails: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       Imagedetails.image = selection
        
    }



}
