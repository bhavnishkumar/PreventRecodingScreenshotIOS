//
//  InternetPopVC.swift
//  BuzzAmaid
//
//  Created by Lakhan's mac mini on 17/01/21.
//  Copyright © 2021 Lakhan's mac mini. All rights reserved.
//
import UIKit

class RecordingDisablePopVC: UIViewController {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var popUpview: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTapRecognizer()
        self.popUpview.isHidden = false //Ttue
        self.backView.alpha = 1.0
     //   self.view.backgroundColor = UIColor.clear
    }

    override func viewDidAppear(_ animated: Bool) {
//        DispatchQueue.main.async {
//            self.popUpview.isHidden = false
//            self.backView.alpha = 0.0
//            self.popUpview.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
//            UIView.animate(withDuration: 1.0 , delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [],  animations: {
//                self.backView.alpha = 1.0
//                self.popUpview.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
//            })
//        }
    }
    

    //Dismiss View Controller
    func addTapRecognizer(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        tap.numberOfTouchesRequired = 1
        tap.numberOfTouchesRequired = 1
        self.backView.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(){
      //  self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func btnAction(_ sender: Any) {
       // self.dismiss(animated: true, completion: nil)

    }
}
