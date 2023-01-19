//
//  ShowHideViews.swift
//  iExpense
//
//  Created by Andy Wu on 12/15/22.
//

import SwiftUI

struct ShowHideViews: View {
    @State private var showingSheet = false
    
    var body: some View {
        Button("Show Sheet") {
            showingSheet.toggle()
        }.sheet(isPresented: $showingSheet) {
            SecondView(name: "Andy")
        }
    }
}

struct SecondView: View {
    ///@Environment allows us to create properties that store values provided to us externally
    /// User in dark mode? Light mode? Small fonts or large fonts? Timezone?
    /// We need to ask the environment to dismiss our view because
    /// it might have been presented in any number of different ways
    /// "Hey, figure out how my view was presented, then dismiss it appropriately"
    @Environment(\.dismiss) var dismiss
    
    let name: String
    
    var body: some View {
        Button("Dismiss") {
            dismiss()
        }
    }
}

struct ShowHideViews_Previews: PreviewProvider {
    static var previews: some View {
        ShowHideViews()
    }
}
