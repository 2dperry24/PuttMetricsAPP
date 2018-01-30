//
//  IntheBag2VC.swift
//  PuttMetricsAPP
//
//  Created by User on 1/26/18.
//  Copyright © 2018 DustinPerry. All rights reserved.
//

import UIKit
import FirebaseStorage



class IntheBag2VC: UIViewController {

    
    
    @IBOutlet weak var uploadImage: UIImageView!
    
    @IBOutlet weak var downloadImage: UIImageView!
    
    let filename = "earth.jpg"
    
    
    var imageReference: StorageReference {
        
        return Storage.storage().reference().child("images")
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        print("inthebagMADEITTO")
        
        
        // Do any additional setup after loading the view.
    }

    @IBAction func uploadBTN(_ sender: UIButton) {
        guard let image = uploadImage.image else {return}
        guard let imageData = UIImageJPEGRepresentation(image, 1) else {return}
        
        let uploadImageRef = imageReference.child(filename)
        let uploadTask = uploadImageRef.putData(imageData, metadata: nil) { (metadata, error) in
           
            print("Upload task finished")
            print(metadata ?? "NO metadata")
            print(error ?? "No Error")
        }
        uploadTask.observe(.progress) { (snapshot) in
            print(snapshot.progress ?? "No more progress")
        }
        uploadTask.resume()
    }
    

    @IBAction func downloadBTN(_ sender: UIButton) {
        
        let downloadImageRef = imageReference.child(filename)
        
        let downloadtask = downloadImageRef.getData(maxSize: 1024*1024*12) { (data, error) in
        
            if let data = data {
                let image = UIImage(data: data)
                self.downloadImage.image = image
            }
        print(error ?? "NO ERROR")
        }
        downloadtask.observe(.progress) { (snapshot) in
            print(snapshot.progress ?? "No more progress")
        }
         downloadtask.resume()
    }
    
}


