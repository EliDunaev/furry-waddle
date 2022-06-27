//
//  AppDelegate.swift
//  Maps
//
//  Created by Илья Дунаев on 12.06.2022.
//

import UIKit
import GoogleMaps

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var visualEffectView = UIVisualEffectView()
    var window: UIWindow?
    var coordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // GMaps API
        GMSServices.provideAPIKey("AIzaSyAhBKe5tt8lTwLxI7eZanUNchsAYIbmCvw")
        
        window = UIWindow()
        window?.makeKeyAndVisible()
        
        coordinator = AppCoordinator()
        coordinator?.start()
        
        return true
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
         self.visualEffectView.removeFromSuperview()
     }

     func applicationWillResignActive(_ application: UIApplication) {
         if !self.visualEffectView.isDescendant(of: self.window!) {
             let blurEffect = UIBlurEffect(style: .light)
             self.visualEffectView = UIVisualEffectView(effect: blurEffect)
             self.visualEffectView.frame = (self.window?.bounds)!
             self.window?.addSubview(self.visualEffectView)
         }
     }

     func applicationDidBecomeActive(_ application: UIApplication) {
         self.visualEffectView.removeFromSuperview()
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


}

