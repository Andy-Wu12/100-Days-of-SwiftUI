//
//  Using_objectWillChange.swift
//  HotProspects-16
//
//  Created by Andy Wu on 2/25/23.
//

import SwiftUI

/*
Every class that conforms to ObservableObject automatically
 gains a property called objectWillChange
 
 This is a PUBLISHER, which means it does the same job as the @Published wrapper
 
*/

/*
    To demonstrate usage, we'll build an ObservableObject class that updates itself 10 times.
*/
@MainActor class DelayedUpdater: ObservableObject {
    /*
     If value isn't marked as Published, the UI update would no longer work unless
     we send the change notifications manually using objectWillChange
     A benefit of doing so is that we can send the notification whenever we want
     instead of having @Published do it automatically
    */
    
    // @Published
    var value = 0 {
        willSet {
            objectWillChange.send()
        }
    }
    
    init() {
        for i in 1...10 {
            DispatchQueue.main.asyncAfter(
                deadline: .now() + Double(i),
                execute: { self.value += 1 }
            )
        }
    }
}

struct Using_objectWillChange: View {
    @StateObject var updater = DelayedUpdater()
    
    var body: some View {
        Text("Value is: \(updater.value)")
    }
}

struct Using_objectWillChange_Previews: PreviewProvider {
    static var previews: some View {
        Using_objectWillChange()
    }
}
