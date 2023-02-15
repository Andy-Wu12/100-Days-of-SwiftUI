//
//  TouchAndFaceID.swift
//  BucketList-14
//
//  Created by Andy Wu on 2/10/23.
//

import SwiftUI
import LocalAuthentication


struct TouchAndFaceID: View {
    @State private var isUnlocked = false
    
    var body: some View {
        VStack {
            if isUnlocked {
                Text("Unlocked")
            } else {
                Text("Locked")
            }
        }
        .onAppear(perform: authenticate)
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        // check whether biometric authentication is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // possible, so try using it
            let reason = "We need to unlock your data."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                // authentication completed
                if success {
                    isUnlocked = true
                } else {
                    // issue occurred
                }
            }
        } else {
            // no biometrics - best to provide a fallback option like passcode
        }
    }
}

struct TouchAndFaceID_Previews: PreviewProvider {
    static var previews: some View {
        TouchAndFaceID()
    }
}
