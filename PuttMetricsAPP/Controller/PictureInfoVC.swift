//
//  PictureInfoVC.swift
//  PuttMetricsAPP
//
//  Created by User on 1/29/18.
//  Copyright © 2018 DustinPerry. All rights reserved.
//

import UIKit

class PictureInfoVC: UIViewController {
    
    
     // private var _collectionView = InTheBagVC()
    private var dataSource = CollectionViewDataSource()
   
    var _imageTemp : UIImage!
    var image = UIImage()
    
    
    @IBOutlet weak var imageThumbnail: UIImageView!
    
    @IBOutlet weak var nameTF: UITextField!
    
    @IBOutlet weak var discTypeTF: UITextField!
    
    @IBOutlet weak var discInfoTextView: UITextView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       nameTF.delegate = self
        discTypeTF.delegate = self
        
 
        imageThumbnail.image = _imageTemp
       // image = _imageTemp
     
        
       
    }

    
    
    
    
    
    
    
    
    
    

    @IBAction func SaveInfoBTN(_ sender: Any) {
        discInfoTextView.text = "Name: \(nameTF.text!)\nType: \(discTypeTF.text!)"
        
        
        
        
        prepareImageForSaving(image: _imageTemp)
        
       // dataSource.loadImages()
        
        dismiss(animated: true , completion: nil)
        
    }
    
    
    
    
    
    
    
    func prepareImageForSaving(image:UIImage) {
        
        // use date as unique id
        let date : Double = NSDate().timeIntervalSince1970
        
        
        // create NSData from UIImage
        guard let imageData = UIImagePNGRepresentation(image) else {
            // handle failed conversion
            print("png error")
            return
        }
        
        saveImage(imageData: imageData as NSData, date: date)
    }
    
    
    func saveImage(imageData:NSData, date: Double) {
        
        
        let collectionImages = CollectViewImages(context: PersistenceService.context)
        collectionImages.id = date
        collectionImages.imageData = imageData
        PersistenceService.saveContext()
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}



extension PictureInfoVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        }
    }


