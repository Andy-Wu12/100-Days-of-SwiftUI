//
//  CustomValuesFromEnvironment.swift
//  HotProspects-16
//
//  Created by Andy Wu on 2/25/23.
//

import SwiftUI

/*
 Imagine we had app with multiple views lined up in a chain:
 
 view A -> view B -> view C -> view D -> ...
 and we want A and E to access the same object.
 
 With @ObservedObject we would have to go through A -> E
 passing the same object again and again.
 
 With @EnvironmentObject, we can put the object into the environment
 and view E can read the object out from the environment
 with B, C, and D not having to know a thing.
 
 env objects use the same ObservableObject protocol and SwiftUI
 will automatically make sure all views that share the same object get updated when it change.
*/

@MainActor class User: ObservableObject {
    @Published var name = "Tony Stark"
    
}

struct EditView: View {
    /*
     This will look for a User instance in the environment and
     place whatever it finds into the user property.
     
     If it CAN'T FIND a User in the environment, the code will just crash
     */
    @EnvironmentObject var user: User
    
    var body: some View {
        HStack() {
            Spacer()
            TextField("Name", text: $user.name)
            Spacer()
        }
    }
}

struct DisplayView: View {
    @EnvironmentObject var user: User
    
    var body: some View {
        Text(user.name)
    }
}

struct CustomValuesFromEnvironment: View {
    @StateObject private var user = User()
    
    var body: some View {
        VStack {
            EditView() //.environmentObject(user)
            DisplayView() //.environmentObject(user)
                .background(.blue)
                .foregroundColor(.white)
        }
        /*
             This result is identical to injecting into the environment of the view itself
             We're now placing the environment into ContentView, but
             since EditView and DisplayView are children on ContentView
             they inherit its environment automatically.
         */
        .environmentObject(user)
        .multilineTextAlignment(.center)
    }
}

struct CustomValuesFromEnvironment_Previews: PreviewProvider {
    static var previews: some View {
        CustomValuesFromEnvironment()
    }
}
