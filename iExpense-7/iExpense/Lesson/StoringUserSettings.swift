//
//  StoringUserSettings.swift
//  iExpense
//
//  Created by Andy Wu on 12/15/22.
//

import SwiftUI

// UserDefaults
/// Common way to store a small amount of data
/// Great for simple user preferences
/// No number attached to "small amount", but everything stored in UserDefaults
/// automatically gets loaded when app launches, which slows down app launch if there is a significant amount there
/// Rough estimate is to store no more than 512KB

struct StoringUserSettings: View {
    /// @AppStorage property wrapper provides access to UserDefaults system
    /// Works like @State so that when value changes, it will reinvoke body property so UI reflects up-to-date data
    /// The following reads "Tap" data from UserDefaults and provides a default of 0 if it doesn't exist
    @AppStorage("Tap") private var tapCount = 0
    /// Alternative way to write the above
///    @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
    
    var body: some View {
        Button("Tap count: \(tapCount)") {
            tapCount += 1
            /// UserDefaults.standard is the built-in instance of UserDefaults attached to our app
            /// In more advanced app we can create our own instances like to share our defaults across several app extensions
            UserDefaults.standard.set(self.tapCount, forKey: "Tap")
        }
    }
}

struct StoringUserSettings_Previews: PreviewProvider {
    static var previews: some View {
        StoringUserSettings()
    }
}
