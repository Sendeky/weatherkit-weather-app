//
//  NotificationUtil.swift
//  weatherkit-weather-app
//
//  Created by RuslanS on 12/28/22.
//
import UIKit

func createNotification() {
    let sunsetNotificationContent = UNMutableNotificationContent()
    sunsetNotificationContent.title = "Ready for Launch!"
    sunsetNotificationContent.body = "Rocket Ready! Sunset soon"

    //Breaks Date() down into DateComponents (hours, minutes, etc.)
    var sunsetTime = Calendar.current.dateComponents([.hour, .minute], from: WeatherKitData.Sunset)
    print("Comp: \(sunsetTime)")
//        var comp = DateComponents()
//        comp.hour = 12
//        comp.minute = 50
    let sunsetNotificationTrigger = UNCalendarNotificationTrigger(dateMatching: sunsetTime, repeats: true)
    let sunsetNotifcationId = UUID().uuidString
    
    let sunsetNotificationRequest = UNNotificationRequest(identifier: sunsetNotifcationId, content: sunsetNotificationContent, trigger: sunsetNotificationTrigger)
    //Prevents duplicate notifications
    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    UNUserNotificationCenter.current().add(sunsetNotificationRequest) { error in
        if let error = error {
            print("UNUSerNotificationCenter Error: \(error)")
        }
    }
    print("registered sunset notification")
    
    //Breaks Date() down into DateComponents (hours, minutes, etc.)
    let sunriseNotificationContent = UNMutableNotificationContent()
    sunriseNotificationContent.title = "Sunrise Soon!"
    sunriseNotificationContent.body = "Sunrise soon"
    
    var sunriseTime = Calendar.current.dateComponents([.hour, .minute], from: WeatherKitData.Sunrise)
    print("Comp: \(sunriseTime)")
    let sunriseNotificationTrigger = UNCalendarNotificationTrigger(dateMatching: sunriseTime, repeats: true)
    
    let sunriseNotifcationId = UUID().uuidString
    
    let sunriseNotificationRequest = UNNotificationRequest(identifier: sunriseNotifcationId, content: sunriseNotificationContent, trigger: sunriseNotificationTrigger)
    
    //Prevents duplicate notifications
//    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    UNUserNotificationCenter.current().add(sunriseNotificationRequest) { error in
        if let error = error {
            print("UNUSerNotificationCenter Error: \(error)")
        }
    }
    print("registered sunrise notifications")
    
}
