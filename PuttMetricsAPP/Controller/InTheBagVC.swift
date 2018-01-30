//
//  InTheBagVC.swift
//  PuttMetricsAPP
//
//  Created by User on 1/3/18.
//  Copyright © 2018 DustinPerry. All rights reserved.
//

import UIKit
import CoreData












class InTheBagVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
    
    
    @IBOutlet private weak var deleteButton: UIBarButtonItem!
    @IBOutlet private weak var addButton: UIBarButtonItem!
    @IBOutlet private weak var collectionView:UICollectionView!

    private let dataSource = CollectionViewDataSource()
    private let pictureInfoSource = PictureInfoVC()
    
    var imageToSend = UIImage()
    var images:[UIImage]!
    var imagePathArray = [String]()
    
//    var _images = [(UIImage,Double,Int)]()
//
//
    
    @IBAction func deleteSelected() {
 
        if let selected = collectionView.indexPathsForSelectedItems {
            
            
                     let fetchRequest: NSFetchRequest<CollectViewImages> = CollectViewImages.fetchRequest()
                        var receivedImages = try! PersistenceService.context.fetch(fetchRequest)
                        
            
                        let context: NSManagedObjectContext = PersistenceService.context
                        
                        let items = selected.map{$0.item}.sorted().reversed()
            
                        for item in items {
                           dataSource._images.remove(at: item)
                            context.delete(receivedImages[item] as NSManagedObject)
                            
                        }
            
                        collectionView.deleteItems(at: selected)
                        PersistenceService.saveContext()
            
            
            }
    }
    
    
    
    
    
    
    
   @IBAction func addItem() {
        
     //   let index = IndexPath(row: _images.count - 1, section: 0)
    
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
   
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
            imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true, completion: nil)
            } else {
                print("Camera is not available")
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:nil))
        
        self.present(actionSheet,animated: true,completion: nil)

    

    
    
      //             collectionView.insertItems(at: [index])
        
//        collectionView.performBatchUpdates({
//            for _ in 0..<2 {
//                let text = "\(collectionData.count + 1) 🐱"
//                collectionData.append(text)
//                let index = IndexPath(row: collectionData.count - 1, section: 0)
//                collectionView.insertItems(at: [index])
//            }
//        }, completion: nil)
    }
    
  
    
    
    
    
    
    
    
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
       
        imageToSend = image
       
       // _images.append(image)
      
        
              // prepareImageForSaving(image: image)
      //    dataSource.loadImages()
        
       
        
      //    collectionView.reloadData()
        
        

    
       picker.dismiss(animated: true, completion: nil)
        
        
        performSegue(withIdentifier: "sendToImageInfo", sender: self)
    
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    

    
    @objc func refresh() {

       collectionView.refreshControl?.endRefreshing()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set up a 3-column Collection View
        let width = view.frame.size.width  / 3
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width:width, height:width)
        // Refresh Control
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(self.refresh), for: UIControlEvents.valueChanged)
        collectionView.refreshControl = refresh

       navigationItem.rightBarButtonItem = editButtonItem
    
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        collectionView.reloadData()
        print("Did reappear")
    }
    
    
    
    
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toInTheBagDetails" {
            if let dest = segue.destination as? InTheBagDetailsVC,
                let index = sender as? IndexPath {
                dest.selection = dataSource._images[index.row].0

            
            }
        }
        
        
        if segue.identifier == "sendToImageInfo" {
            if let destination = segue.destination as? PictureInfoVC {
                destination._imageTemp = imageToSend

            }
            
        }
    }

    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        deleteButton.isEnabled = editing
        
        addButton.isEnabled = !editing
        
        collectionView.allowsMultipleSelection = editing
        let indexes = collectionView.indexPathsForVisibleItems
        for index in indexes {
            let cell = collectionView.cellForItem(at: index) as! CollectionViewCell
            cell.isEditing = editing
        }
    }
    

 
}
   
    
    
    
    
    
    
    
    

    
    
    




extension InTheBagVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        
        dataSource.loadImages()
        return dataSource._images.count
        
   
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
    
        
         cell.cellImage.image = dataSource._images[indexPath.row].0
        cell.titleLabel.text = "\(dataSource._images[indexPath.row].1)"

        
        
        
      
        cell.isEditing = isEditing
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !isEditing {
            performSegue(withIdentifier: "toInTheBagDetails", sender: indexPath)
        }
    }
}

extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}

