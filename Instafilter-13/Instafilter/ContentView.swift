//
//  ContentView.swift
//  Instafilter
//
//  Created by Andy Wu on 1/31/23.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @State private var image: Image?
    @State private var inputImage: UIImage?
    
    @State private var filterIntensity = 0.5
    @State private var filterRadius = 1.0
    @State private var filterScale = 1.0
    @State private var filterEV = 0.5
    @State private var filterAngle = 0.0
    
    @State private var showingImagePicker = false
    // Explicit CIFIlter here allows us to change filter dynamically
    // Without it, the inferred type would be CIFilter that conforms to CISepiaTone
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    // contexts are expensive to create, so best to create once and keep alive
        // if intending to render many images
    @State private var showingFilterSheet = false
    @State private var processedImage: UIImage?
    let context = CIContext()
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(.secondary)
                    
                    Text("Tap to select a picture")
                        .foregroundColor(.white)
                        .font(.headline)
                    
                    image?
                        .resizable()
                        .scaledToFit()
                }
                .onTapGesture {
                    showingImagePicker = true
                }

                Group {
                    FilterSlider(name: "Intensity", value: $filterIntensity, action: applyProcessing)
                    
                    FilterSlider(name: "Radius", value: $filterRadius, action: applyProcessing)
                    
                    FilterSlider(name: "Scale", value: $filterScale, action: applyProcessing)
                    
                    FilterSlider(name: "Exposure", value: $filterEV, action: applyProcessing)
                    
                    FilterSlider(name: "Angle", value: $filterAngle, action: applyProcessing)
                }
                
                HStack {
                    Button("Change filter") {
                        showingFilterSheet = true
                    }
                    
                    Spacer()
                    
                    Button("save", action: save)
                        .disabled(image == nil)
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
        }
        .onChange(of: inputImage) { _ in loadImage() }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
        }
        .confirmationDialog("Select a filter", isPresented: $showingFilterSheet) {
            Group {
                Button("Crystallize") { setFilter(CIFilter.crystallize()) }
                Button("Edges") { setFilter(CIFilter.edges()) }
                Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
                Button("Pixellate") { setFilter(CIFilter.pixellate()) }
                Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
                Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
            }
            Group {
                Button("Vignette") { setFilter(CIFilter.vignette()) }
                Button("Hue Adjust") { setFilter(CIFilter.hueAdjust()) }
                Button("Exposure Adjust") { setFilter(CIFilter.exposureAdjust()) }
                Button("Comic Effect") { setFilter(CIFilter.comicEffect()) }
                Button("Cancel", role: .cancel) { }
            }
        }
    }
    
    func save() {
        guard let processedImage = processedImage else { return }
        
        let imageSaver = ImageSaver()
        
        imageSaver.successHandler = {
            print("Success!")
        }
        imageSaver.errorHandler = {
            print("Error! \($0.localizedDescription)")
        }
        imageSaver.writeToPhotoAlbum(image: processedImage)
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func applyProcessing() {
//        print("""
//            processing: \n
//            intensity: \(filterIntensity) \n
//            radius: \(filterRadius) \n
//            scale: \(filterScale) \n
//            """)
        // We lose access to intensity due to explicit CIFilter annotation above
//        currentFilter.intensity = Float(filterIntensity)
        let inputKeys = currentFilter.inputKeys
        
        // https://developer.apple.com/documentation/coreimage/cifilter/filter_parameter_keys
        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterRadius, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterScale, forKey: kCIInputScaleKey) }
        if inputKeys.contains(kCIInputAngleKey) { currentFilter.setValue(filterAngle, forKey: kCIInputAngleKey) }
        if inputKeys.contains(kCIInputEVKey) { currentFilter.setValue(filterEV, forKey: kCIInputEVKey) }
        
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
}

struct FilterSlider: View {
    var name: String
    var value: Binding<Double>
    var action: (() -> Void)?
    
    var body: some View {
        HStack {
            Text(name)
            // These values could be more dynamic
            Slider(value: value, in: 0...100)
                .onChange(of: value.wrappedValue) { _ in
//                    print(value.wrappedValue)
                    action?()
                }
        }
        .padding(.vertical)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
