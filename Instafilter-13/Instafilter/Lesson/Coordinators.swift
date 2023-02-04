//
//  Coordinators.swift
//  Instafilter
//
//  Created by Andy Wu on 2/3/23.
//

import SwiftUI
import PhotosUI

/*
 Coordinators in SwiftUI act as delegates for UIKit view controllers.
 Remember "delegates" are objects that respond to events that occur elsewhere.
 */
struct Coordinators: View {
    @State private var image: Image?
    @State private var showingImagePicker = false
    
    @State private var inputImage: UIImage?
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
            
            Button("Select Image") {
                showingImagePicker = true
            }
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker2(image: $inputImage)
        }
        .onChange(of: inputImage) { _ in loadImage() }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
}

struct ImagePicker2: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    
    /*
     1. Inherit NSObject to allow Objective-C to ask the object what functionality it supports at runtime
     2. Conform to PHPickerViewControllerDelegate which adds functionality for detecting
        when the user selects an image.
        NSobject lets objective-c CHECK for the functionality, this protocol actually provides it
    */
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            // Tell the picker to go away
            picker.dismiss(animated: true)
            
            // Exit if no selection was made
            guard let provider = results.first?.itemProvider else { return }
            
            // If this has an image we can use, use it
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    self.parent.image = image as? UIImage
                }
            }
        }
        
        var parent: ImagePicker2
        
        init(_ parent: ImagePicker2) {
            self.parent = parent
        }
    }
    
    /*
    Automatically called by SwiftUI when instance of ImagePicker2 created
    Even better, SwiftUI automatically associated the coordinator it created with our struct.
    So when it calls makeUIViewController() and updateUIViewController(),
     it will automatically pass the coordinator object to us
    Anytime something happens inside the photopicker controller, it will reportthat action to our Coordinator
    */
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
    }
    // Below statement can be shortcut for generating the two method stubs above (click "Fix" on Xcode error)
//    typealias UIViewControllerType = PHPickerViewController
}

struct Coordinators_Previews: PreviewProvider {
    static var previews: some View {
        Coordinators()
    }
}
