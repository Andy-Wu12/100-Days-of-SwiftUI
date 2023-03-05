//
//  TabViewLesson.swift
//  HotProspects-16
//
//  Created by Andy Wu on 2/25/23.
//

import SwiftUI

/*
In addition to
We can also control the tab's view programmatically by:
 
1. Create an @State property to track the tab being shown
2. Modify that property to a new value whenver we want to jump to a different tab
3. Pass (2) as a binding into the TabView to be tracked automatically
4. Tell SwiftUI which tab should be shown for each value of that property.
 */
struct TabViewLesson: View {
    // (1)
    @State private var selectedTab = "One"
    
    var body: some View {
        // (3)
        TabView(selection: $selectedTab) {
            Text("Tab 1")
                // (2)
                .onTapGesture {
                    selectedTab = "Two"
                }
            // tabItem() allows us to customize the way a view is shown in the tab bar
                .tabItem {
                    Label("One", systemImage: "star")
                }
                // (4)
                .tag("One")
            
            Text("Tab 2")
                .tabItem {
                    Label("Two", systemImage: "circle")
                }
                // (4)
                .tag("Two")
        }
    }
}

// Note: IF you want to use NavigationView along with TabView,
// TabView should be the parent, with tabs inside it having a NavigationView,
// not the other way around
struct TabViewLesson_Previews: PreviewProvider {
    static var previews: some View {
        TabViewLesson()
    }
}
