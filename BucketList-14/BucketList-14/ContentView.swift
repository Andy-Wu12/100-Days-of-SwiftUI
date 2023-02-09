//
//  ContentView.swift
//  BucketList-14
//
//  Created by Andy Wu on 2/9/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Bucket List")
                .font(.system(size: 50))
                .fontWeight(.heavy)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
