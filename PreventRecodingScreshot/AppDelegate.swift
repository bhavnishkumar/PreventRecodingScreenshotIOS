//
//  AppDelegate.swift
//  PreventRecodingScreshot
//
//  Created by Admin on 25/04/22.
//

import UIKit
import Photos

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var appSwitcherView: UIView?
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        appSwitcherView = UIVisualEffectView(effect: blurEffect)
        appSwitcherView?.frame =  self.window?.bounds ?? CGRect()
        appSwitcherView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        detectScreenRecording {
            print(UIScreen.main.isCaptured)
            if UIScreen.main.isCaptured {
                //your vier hide code
                print("self.toHide()")
                showRecordPopView()
            } else {
                // self.sceneDeleg(ate?.window?.isHidden = false
                //your view show code
                print("self.toShow()")
                hideRecordPopView()
            }
        }
        
        
        detectScreenShot{

            print("screenshot taken")
            let alert = UIAlertController(title: "Error", message: "Screenshot detected You don't have permission take screenshot due to copyright content", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))

            if let window = UIApplication.shared.keyWindow, let rootViewController = window.rootViewController {
                rootViewController.present(alert, animated: true)
            }

            
            
           // deleteAppScreenShot()
        }
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
    
    func applicationWillResignActive(_ application: UIApplication) {
   
        self.window?.addSubview(appSwitcherView ?? UIView())
    }
    
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        appSwitcherView?.removeFromSuperview()
    }
    
    
    
    
    
}

/// This method applies a Gaussian blur on a given UIImage.
/// - Parameters:
///   - image: The image where the Gaussian blur will be applied on
///   - blurFactor: How high should the blur effect be
func applyGaussianBlur(on image: UIImage, withBlurFactor blurFactor : CGFloat) -> UIImage? {
    guard let inputImage = CIImage(image: image) else {
        return nil
    }
    
    // Add a comment where to find documentation for that
    let gaussianFilter = CIFilter(name: "CIGaussianBlur")
    gaussianFilter?.setValue(inputImage, forKey: kCIInputImageKey)
    gaussianFilter?.setValue(blurFactor, forKey: kCIInputRadiusKey)
    
    guard let outputImage = gaussianFilter?.outputImage else {
        return nil
    }
    
    return UIImage(ciImage: outputImage)
}




func detectScreenShot(action: @escaping () -> ()) {
    let mainQueue = OperationQueue.main
    NotificationCenter.default.addObserver(forName: UIApplication.userDidTakeScreenshotNotification, object: nil, queue: mainQueue) { notification in
        // executes after screenshot
        action()
    }
}


func detectScreenRecording(action: @escaping () -> ()) {
    let mainQueue = OperationQueue.main
    NotificationCenter.default.addObserver(forName: UIScreen.capturedDidChangeNotification, object: nil, queue: mainQueue) { notification in
        // executes after screenshot
        action()
    }
}


func deleteAppScreenShot() {
    let fetchOptions = PHFetchOptions()
    fetchOptions.sortDescriptors?[0] = Foundation.NSSortDescriptor(key: "creationDate", ascending: true)
    let fetchResult = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: fetchOptions)
    guard let lastAsset = fetchResult.lastObject else { return }
    PHPhotoLibrary.shared().performChanges {
        PHAssetChangeRequest.deleteAssets([lastAsset] as NSFastEnumeration)
    } completionHandler: { (success, errorMessage) in
        if !success, let errorMessage = errorMessage {
            print(errorMessage.localizedDescription)
        }
    }
}

