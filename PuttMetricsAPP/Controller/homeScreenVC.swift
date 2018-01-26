//
//  startingScreenVC.swift
//  PuttMetricsAPP
//
//  Created by User on 1/2/18.
//  Copyright © 2018 DustinPerry. All rights reserved.
//

import UIKit

class HomeScreenVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

 
  private var labelStrings = ["Games", "Stats", "In the bag","User Account", "Settings"]
    private var imageArray: [UIImage] = [#imageLiteral(resourceName: "rubixCube"),#imageLiteral(resourceName: "chart icon"),#imageLiteral(resourceName: "icon1"), #imageLiteral(resourceName: "userAccount"),#imageLiteral(resourceName: "icon3")]
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
   
    @IBOutlet weak var gameTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fallingDiscsFromSky()
        view.setGradientBackground(colorOne: UIColor.flatLime(), colorTwo: UIColor.flatSkyBlue())
        // Do any additional setup after loading the view.
        tableViewHeightConstraint.constant = view.frame.height * (2/3)
        gameTitleLabel.textColor = UIColor.flatBlack()
       tableView.dataSource = self
        tableView.delegate = self
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    
    
    
    

    
    
    func fallingDiscsFromSky () {
        let emitter =  EmitterUP.get(with: #imageLiteral(resourceName: "ProdigyDisc"))
        emitter.emitterPosition = CGPoint(x: view.frame.width/2, y: view.frame.height + 100)
        emitter.emitterSize = CGSize(width: view.frame.width, height: 2)
        view.layer.insertSublayer(emitter, at: 0)
   
    }
    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
            if indexPath.row == 0 {
                performSegue(withIdentifier: "sendToGamesSelectionVC", sender: self)
            } else if indexPath.row == 1 {
                performSegue(withIdentifier: "sendToResultsSelectionVC", sender: self)
            }  else if indexPath.row == 2 {
                    print("send to in the bag VC")
            } else if indexPath.row == 3 {
                 performSegue(withIdentifier: "sendToSettingSelectionVC", sender: self)
            } else if indexPath.row == 4 {
                 print("send to in the Settings VC")
            }
     
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labelStrings.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "homeScreenCustomCell") as! HomeScreencustomcell
        let _label = labelStrings[indexPath.row]
        let _image = imageArray[indexPath.row]
        
        cell.label.text = _label
        cell.label.textColor = UIColor.flatBlack()
        cell.labelImage.image = _image
        
        
        return cell
    }
}

























/// To get this work, a scrollView was set to 260 pixels wide to allow edges of icons to be displayed on the side of the screen to show user that the icon is there for the viewing. a gesture allows user to swipe even though its not a part of the scroll view.

//    override func viewDidAppear(_ animated: Bool) {
//
//        var contentWidth: CGFloat = 0.0
//        let scrollWidth = scrollView.frame.size.width
//
//        for x in 0...3 {
//
//            let label = UILabel()
//            label.text = labelStrings[x]
////            let imageView = UIImageView(image:image)
////            images.append(imageView)
//
//            let button = UIButton()
//            let image = UIImage(named: "icon\(x)")
//            button.setBackgroundImage(image, for: UIControlState())
//            button.tag = x
//            button.addTarget(self, action: #selector(startingScreenVC.sendToFeature(sender:)), for: .touchUpInside)
//            var newX: CGFloat = 0.0
//
//            newX = scrollWidth / 2 + (scrollWidth * CGFloat(x))
//            contentWidth += scrollWidth
//
//            scrollView.addSubview(button)
//            scrollView.addSubview(label)
//            scrollView.contentOffset = CGPoint(x: scrollWidth * 1, y: 0)
//            button.frame = CGRect(x: newX - 75, y: (scrollView.frame.size.height / 2) - 75, width: 150, height: 150)
//           // button.frame.size = CGSize(width: 250, height: 250)
//            button.contentMode = .scaleAspectFit
//            label.frame = CGRect(x: newX - 75, y: (scrollView.frame.size.height / 2) + 75, width: 150, height: 35)
//            label.textAlignment = .center
//            label.font = UIFont(name: "AvenirNext-Bold", size: 18)
//
//        }
//
//        scrollView.clipsToBounds = false
//        scrollView.contentSize = CGSize(width: contentWidth, height: scrollView.frame.height)
//
//        view.addGestureRecognizer(scrollView.panGestureRecognizer)
//
//
//    }
//
//
//    @objc func sendToFeature(sender: UIButton) {
//        print("the tag that was pressed was \(sender.tag)")
//        switch sender.tag {
//        case 0: performSegue(withIdentifier: "sendToTicTacToe", sender: self)
//        case 1: performSegue(withIdentifier: "sendToPuttOfWar", sender: self)
//        case 2: print("go somwhere")
//        default: return
//        }
//    }
//


