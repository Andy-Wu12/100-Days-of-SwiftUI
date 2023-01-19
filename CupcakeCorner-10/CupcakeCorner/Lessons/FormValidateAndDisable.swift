//
//  FormValidateAndDisable.swift
//  CupcakeCorner
//
//  Created by Andy Wu on 1/7/23.
//

import SwiftUI

/*
    Sometimes we may need to check input is valid before proceeding further.
    A modifier, disabled(), is built just for that purpose.
 
    disabled() takes a condition to check, and if true
        prevents user input (tapping, slider dragging, etc.) if true
*/
struct FormValidateAndDisable: View {
    @State private var username = ""
    @State private var email = ""
    
    var formFilled: Bool {
        username.count > 5 && email.count > 3
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }
            
            // Don't want users to create an account unless both fields have been filled
            Section {
                Button("Create account") {
                    print("Creating account...")
                }
            }
//            .disabled(username.isEmpty || email.isEmpty)
            // Might be useful to make condition a computed property
            .disabled(!formFilled)
            
        }
    }
}

struct FormValidateAndDisable_Previews: PreviewProvider {
    static var previews: some View {
        FormValidateAndDisable()
    }
}
