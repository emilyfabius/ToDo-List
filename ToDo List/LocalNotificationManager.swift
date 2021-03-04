//
//  LocalNotificationManager.swift
//  ToDo List
//
//  Created by Emily Fabius on 3/4/21.
//

import Foundation
import UserNotifications

struct LocalNotificationManager {
    static func authorizeLocalNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            guard error == nil else {
                print("Error: \(error!.localizedDescription)")
                return
            }
            if granted {
                print("Notification Authorization Granted")
            }
            else {
                print("The user has denied notifications!")
                //TODO: put an alert telling the user what to do
            }
        }
    }
    
    static func setCalendarNotification(title: String, subtitle: String, body: String, badgeNumber: NSNumber?, sound: UNNotificationSound?, date: Date) -> String {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.body = body
        content.sound = sound
        content.badge = badgeNumber
        
        //create trigger
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        dateComponents.second = 00
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        // create request
        let notificationID = UUID().uuidString
        let request = UNNotificationRequest(identifier: notificationID, content: content, trigger: trigger)
        
        // register request wiht the notification center
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("ERROR: \(error.localizedDescription)")
            }
            else {
                print("Notification scheduled \(notificationID), title: \(title)")
            }
        }
        return ""
    }
}
