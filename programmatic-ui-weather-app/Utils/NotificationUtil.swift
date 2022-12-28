//
//  NotificationUtil.swift
//  weatherkit-weather-app
//
//  Created by RuslanS on 12/28/22.
//

//import Foundation
import UIKit

func createNotification() {
    let notificationContent = UNMutableNotificationContent()
    notificationContent.title = "Ready for Launch!"
    notificationContent.body = "Rocket Ready! Sunset in 2 minutes"
    
    var comp = Calendar.current.dateComponents([.hour, .month], from: WeatherKitData.Sunset)
//        var comp = DateComponents()
//        comp.hour = 12
//        comp.minute = 50
    let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: comp, repeats: true)
    
    let notifcationId = UUID().uuidString
    
    let notificationRequest = UNNotificationRequest(identifier: notifcationId, content: notificationContent, trigger: notificationTrigger)
    
    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    UNUserNotificationCenter.current().add(notificationRequest) { error in
        if let error = error {
            print("UNUSerNotificationCenter Error: \(error)")
        }
    }
    print("registered notification")
    
}
