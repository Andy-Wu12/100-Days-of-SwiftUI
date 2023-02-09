//
//  ConfirmDialogView.swift
//  Instafilter
//
//  Created by Andy Wu on 2/1/23.
//

import SwiftUI

struct ConfirmDialog: View {
    @State private var showingConfirmation = false
    @State private var backgroundColor = Color.white
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .frame(width: 300, height: 300)
            .background(backgroundColor)
            .onTapGesture {
                showingConfirmation = true
            }
        /// Alternative to .alert with vertically stacked buttons
            .confirmationDialog("Change background", isPresented: $showingConfirmation) {
                Button("Red") { backgroundColor = .red }
                Button("Green") { backgroundColor = .green }
                Button("Blue") { backgroundColor = .blue }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("Select a new color")
            }
    }
}

struct ConfirmDialog_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmDialog()
    }
}
