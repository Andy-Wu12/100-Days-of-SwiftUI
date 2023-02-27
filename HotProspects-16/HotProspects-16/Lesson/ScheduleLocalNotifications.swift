//
//  ScheduleLocalNotifications.swift
//  HotProspects-16
//
//  Created by Andy Wu on 2/26/23.
//

import SwiftUI
import UserNotifications

struct ScheduleLocalNotifications: View {
    var body: some View {
        VStack {
            Button("Request Permission") {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("All set")
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }
            .padding()
            
            /*
             Apple breaks notifications down into three parts for maximum flexibility
             1. The content is what should be shown and can be a title, subtitle, sound, image, and so on
             2. The trigger determines when the notification should be shown,
                and can be a number of seconds from now, a date and time in the future,
                or a location
             3. The request combines the content and trigger, but also adds a unique identifier
                so alerts can be edited or removed later on.
            */
            Button("Schedule Notification") {
                let content = UNMutableNotificationContent()
                content.title = "Feed the cat"
                content.subtitle = "It looks hungry"
                content.sound = UNNotificationSound.default
                
                // show this notification 5s from now
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                
                // choose a random identifier
                let request = UNNotificationRequest(
                    identifier: UUID().uuidString,
                    content: content,
                    trigger: trigger)
                
                // add our notification request
                UNUserNotificationCenter.current().add(request)
            }
        }
    }
}

struct ScheduleLocalNotifications_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleLocalNotifications()
    }
}
