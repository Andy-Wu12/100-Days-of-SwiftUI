//
//  UIViewControllerInSwiftUI.swift
//  Instafilter
//
//  Created by Andy Wu on 2/2/23.
//

import SwiftUI
import PhotosUI

/*
 Three important things to know about PhotosUI and UIKit
 
 1. UIKit has class called UIView, which is parent of all views in the layouts.
    This includes labels, buttons, text fields, and so on.
 2. UIKit has a class called UIViewController, which is designed to hold all the code to bring views to life.
    Just like UIView, UIViewController has many subclasses that do different kinds of work.
 3. UIKit uses design pattern called delegation to decide where work happens.
    For example, if we want to decide how to respond to a text field changing
        we would create a custom class with our functionality and make that the delegate of our text field.
 
 These things matter because asking the user to select a photo from their library uses a view controller called
 PHPickerViewController, and corresponding delegate PHPickerViewControllerDelegate.
 SwiftUI can't use them directly, so we need to wrap them.
*/
struct UIViewControllerInSwiftUI: View {
    @State private var image: Image?
    @State private var showingPicker = false
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
            
            Button("Select Image") {
                showingPicker = true
            }
        }
        .sheet(isPresented: $showingPicker) {
            ImagePickerLesson()
        }
    }
}

/*
 Wrapping UIKit view controller requires struct that conforms to
    UIViewControllerRepresentable
 */
struct ImagePickerLesson: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        
        let picker = PHPickerViewController(configuration: config)
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
    }
    // Below statement can be shortcut for generating the two method stubs above (click "Fix" on Xcode error)
//    typealias UIViewControllerType = PHPickerViewController
}

struct UIViewControllerInSwiftUI_Previews: PreviewProvider {
    static var previews: some View {
        UIViewControllerInSwiftUI()
    }
}
