//
//  CreatingContextMenus.swift
//  HotProspects-16
//
//  Created by Andy Wu on 2/26/23.
//

import SwiftUI

/*
 When a user taps on buttons or nav links, they clearly want
 to trigger the default action.
 
 What if the user taps and holds onto these UI elements?
 It means they intend to see extra options for whatever they interact with.
 
 SwiftUI lets us attach context menus to objects to provide this extra functionality
 This is done using contextMenu(), which takes a selection of buttons shown in theo rder provided
*/
struct CreatingContextMenus: View {
    @State private var backgroundColor = Color.red
    
    var body: some View {
        VStack {
            Text("Hello, World!")
                .padding()
                .background(backgroundColor)
            
            Text("Change Color")
                .padding()
                .contextMenu {
                    Button("Red") {
                        backgroundColor = .red
                    }
                    
                    Button("Green") {
                        backgroundColor = .green
                    }
                    
                    Button {
                        backgroundColor = .blue
                    } label: {
                        Label("Blue", systemImage: "checkmark.circle.fill")
                        /*
                         This modifier is ignored since iOS wants our menus to look uniform
                         If we really want a red item however, we can mark the button's role as destructive
                        */
                            .foregroundColor(.blue)
                    }
                }
        }
    }
}

struct CreatingContextMenus_Previews: PreviewProvider {
    static var previews: some View {
        CreatingContextMenus()
    }
}
