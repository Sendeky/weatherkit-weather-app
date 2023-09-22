//
//  AppDelegateBackgrounRefresh.swift
//  weatherkit-weather-app
//
//  Created by Ruslan Spirkin on 9/21/23.
//

import Foundation
import BackgroundTasks


// class to handle Background refresh in AppDelegate
extension AppDelegate {
    
    func registerBackgroundTask() {
            BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.ES.refresh", using: nil) { task in
                guard let backgroundWeatherRefreshTask = task as? BGAppRefreshTask else { return }
                self.bgTask = backgroundWeatherRefreshTask
                self.handleFirebasePostTask(backgroundWeatherRefreshTask)
            }
        }
    
    // Schedule the app to try our background task for getting weather.
    // - Parameter minutes: (Int) How many minutes from now do you want this to run?
    // - IMPORTANT: Needs to be called in 'applicationDidEnterBackground' App delegate function.
    func scheduleWeatherTask(minutes: Int) {
        do {
            let seconds = TimeInterval(minutes * 60)
            print("BG Task: Scheduling to run again in \(minutes) minutes.")
            let task = BGAppRefreshTaskRequest(identifier: self.bgAppTaskId)
            task.earliestBeginDate = seconds == 0 ? nil : Date(timeIntervalSinceNow: seconds)
            try BGTaskScheduler.shared.submit(task)
        } catch {
            print("BG Task: Failed to submit to the BG Task Scheduler: \(error.localizedDescription)")
        }
    }
    
    private func handleFirebasePostTask(_ task: BGAppRefreshTask) {
        scheduleWeatherTask(minutes: 60) // This is how often we want our BG Task to run.
//        task.expirationHandler = bgExpirationHandler
        let mainVC = MainViewController()
        mainVC.viewDidLoadRefresh()
    }
}
