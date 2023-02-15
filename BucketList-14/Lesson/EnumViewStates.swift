//
//  EnumViewStates.swift
//  BucketList-14
//
//  Created by Andy Wu on 2/9/23.
//

import SwiftUI


/*
 Conditional views are very useful when we want to show one of several differnet states
 If we plan correctly, we can keep our view code small and easy to maintain
*/

/*
 There are two parts to this solution.
 
 1. Define an enum for various view states you want to represent. (LoadingState enum below)
 2. Create individual views for those states. (Load, Success, Failed structs below)
*/
enum LoadingState {
        case loading, success, failed
}

struct LoadingView: View {
    var body: some View {
        Text("Loading...")
    }
}

struct SuccessView: View {
    var body: some View {
        Text("Success!")
    }
}

struct FailedView: View {
    var body: some View {
        Text("Failed.")
    }
}

/*
    Our "Main" view can now be used as a wrapper that tracks the current app state
    and shows the relevant child view.
*/
struct EnumViewStates: View {
    // Store the current LoadingState value
    var loadingState = LoadingState.loading
    
    // Show the correct view based on the enum value
    var body: some View {
        if loadingState == .loading {
            LoadingView()
        } else if loadingState == .success {
            SuccessView()
        } else if loadingState == .failed {
            FailedView()
        }
    }
}

struct EnumViewStates_Previews: PreviewProvider {
    static var previews: some View {
        EnumViewStates()
    }
}
