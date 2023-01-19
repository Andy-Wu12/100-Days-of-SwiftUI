//
//  StatePropertyAndStructs.swift
//  iExpense
//
//  Created by Andy Wu on 12/15/22.
//

import SwiftUI

/// If we want to share data between multiple views, i.e. one change to an instance should affect all other copies of said instance,
/// then we need to use CLASS instead of STRUCT.
/// Note that @State does not work with CLASS since the class instance can just be modified directly

/// This is due to how @State works - it was designed to track local structs rather than external classes.
/// It asks SwiftUI to watch a property for changes, and re-invokes the body property of the view.
/// When User was a struct, every time we modified a property Swift was actually creating a new instance of the struct.
/// @State was able to spot that change and automatically reloaded that view.
class User {
    var firstName = "Tony"
    var lastName = "Stark"
}

/// State property wrapper is designed for simple data that is local to current view
/// But as soon as you want to share data between views it is no longer useful
struct StatePropertyAndStructs: View {
    /// SwiftUI smart enough to understand this one object contains all our data
    /// and will update the UI when either value changes.
    /// Behind the scenes, each time a value inside our struct changes the WHOLE STRUCT changes
    /// It's basically a new user every time we type a key for first / last name. Sounds wasteful, but actually extremely fast
    /// Since structs always have unique owners unlike classes where you can have multiple copies of the same instance,
    /// This means that if we have two SwiftUI views and send them both the same struct to work with
    /// they each have a UNIQUE copy of that struct.
    @State private var user = User()
    
    var body: some View {
        VStack {
            Text("Your name is \(user.firstName) \(user.lastName).")
            TextField("First name", text: $user.firstName)
            TextField("Last name", text: $user.lastName)
        }
        .multilineTextAlignment(.center)
    }
}

struct StatePropertyAndStructs_Previews: PreviewProvider {
    static var previews: some View {
        StatePropertyAndStructs()
    }
}
