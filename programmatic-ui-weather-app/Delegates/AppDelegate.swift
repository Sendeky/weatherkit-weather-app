//
//  AppDelegate.swift
//  programmatic-ui-weather-app
//
//  Created by RuslanS on 10/11/22.
//

import UIKit
import BackgroundTasks

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // background app refresh stuff
    let bgAppTaskId = "com.ES.refresh"
    var bgTask: BGAppRefreshTask?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // device rotation notification
        NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.rotated), name: UIDevice.orientationDidChangeNotification, object: nil)
        
        // Background app referesh (updates weather info and location)
//        var bgExpirationHandler = {{
//            if let task = self.bgTask {
//                task.setTaskCompleted(success: true)
//            }
//        }}()
        // we register the background task
        registerBackgroundTask()
        
        // Override point for customization after application launch.
        let mainViewController = MainViewController()
        mainViewController.viewDidLoadRefresh()
        return true
    }
    
    
    // can potentially be used to correct background when changing between horizontal/vertical
    @objc func rotated() {
        if UIDevice.current.orientation.isLandscape {
            print("Landscape")
        }

        if UIDevice.current.orientation.isPortrait {
            print("Portrait")
        }
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
    func applicationWillTerminate(_ application: UIApplication) {
        //Called when the appcation will be terminated
        let main = MainViewController()
        main.locationManager.stopUpdatingLocation()
    }
    func applicationDidEnterBackground(_ application: UIApplication) {
        //Called when application enters background
        let main = MainViewController()
        main.locationManager.stopUpdatingLocation()
        scheduleWeatherTask(minutes: 60)    // we schedule background weather task to be updated every 60 minutes
                                            // (depends on how much priority system gives us)
    }
}

