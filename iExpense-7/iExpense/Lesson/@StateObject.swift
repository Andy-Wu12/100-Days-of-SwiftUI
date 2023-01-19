//
//  @StateObject.swift
//  iExpense
//
//  Created by Andy Wu on 12/15/22.
//

import SwiftUI

// Sharing SwiftUI state with @StateObject

/// If you want to use class with SwiftUI data, which you will if data needs to be shared across views,
/// then SwiftUI gives us three property wrappers that are useful
/// @StateObject, @ObservedObject, @EnvironmentObject

/// @ObservableObject means "we want other things to be able to monitor this for changes"
class Student: ObservableObject {
    /// @Published marks properties to make them notify any views watching our class that a change has happened so they can be reloaded.
    @Published var firstName = "Peter"
    @Published var lastName = "Parker"
}

struct _StateObject: View {
    /// @StateObject tells SwiftUI that we're CREATING a new class instance that should be watched for any changes
    /// When attempting to USE it in a different view, we use @ObservedObject instead.
    @StateObject var student = Student()
    
    var body: some View {
        VStack {
            Text("Your name is \(student.firstName) \(student.lastName).")

            TextField("First name", text: $student.firstName)
            TextField("Last name", text: $student.lastName)
        }
    }
}

struct _StateObject_Previews: PreviewProvider {
    static var previews: some View {
        _StateObject()
    }
}
