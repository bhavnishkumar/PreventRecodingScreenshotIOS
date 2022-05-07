//
//  Helper.swift
//  PreventRecodingScreshot
//
//  Created by Admin on 27/04/22.
//

import Foundation
import UIKit

//Show Internet Pop view
func showRecordPopView(){
    if let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RecordingDisablePopVC") as? RecordingDisablePopVC {
        if let window = UIApplication.shared.keyWindow, let rootViewController = window.rootViewController {
            var currentController = rootViewController
            while let presentedController = currentController.presentedViewController {
                currentController = presentedController
            }
            currentController.present(controller, animated: true, completion: nil)
        }
    }
}

func hideRecordPopView(){
    let bundle = Bundle.main
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:bundle)
    if let vc = storyBoard.instantiateViewController(withIdentifier: "RecordingDisablePopVC" ) as? RecordingDisablePopVC {
        if vc.isModal == true{
            let navController = UINavigationController(rootViewController: vc)
            navController.isNavigationBarHidden = true
            UIApplication.shared.keyWindow?.rootViewController!.dismiss(animated: true, completion: nil)
        }
    }
}



extension UIViewController {
    var isModal: Bool {
        return presentingViewController != nil || navigationController?.presentingViewController?.presentedViewController === navigationController || tabBarController?.presentingViewController is UITabBarController
    }
}

