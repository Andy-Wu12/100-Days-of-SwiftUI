//
//  CustomRowSwipe.swift
//  HotProspects-16
//
//  Created by Andy Wu on 2/26/23.
//

import SwiftUI

/*
 iOS apps have had "swipe to delete" functionality for so long now
 More recently however, list rows can now have multiple buttons, often on either side of the row.
 This functionality is obtained through the use of the swipeActions() modifier
*/
struct CustomRowSwipe: View {
    var body: some View {
        List {
            Text("Steve Rogers")
                .swipeActions {
                    Button(role: .destructive) {
                        print("Deleting")
                    } label: {
                        Label("Delete", systemImage: "minus.circle")
                    }
                }
                .swipeActions(edge: .leading) {
                    Button {
                        print("Pinning")
                    } label: {
                        Label("Pin", systemImage: "pin")
                    }
                    .tint(.orange)
                }
        }
    }
}

struct CustomRowSwipe_Previews: PreviewProvider {
    static var previews: some View {
        CustomRowSwipe()
    }
}
