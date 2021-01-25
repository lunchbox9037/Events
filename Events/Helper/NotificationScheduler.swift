//
//  NotificationScheduler.swift
//  Events
//
//  Created by stanley phillips on 1/22/21.
//

import UserNotifications

class NotificationScheduler {
    func scheduleNotification(event: Event) {
        guard let date = event.date,
              let title = event.title,
              let id = event.uuid else {return}
        
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "\(title) is today!"
        content.body = "Will you still you be attending?"
        content.sound = UNNotificationSound.default
        
        let triggerDate = Calendar.current.dateComponents([.day, .hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        
        let request = UNNotificationRequest(identifier: "\(id)", content: content, trigger: trigger)
        center.add(request)
    }
    
    func cancelNotification(event: Event) {
        guard let id = event.uuid else {return}
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
    }
}
