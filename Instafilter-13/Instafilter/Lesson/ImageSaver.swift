//
//  ImageSaver.swift
//  Instafilter
//
//  Created by Andy Wu on 2/6/23.
//

import SwiftUI

class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        // #selector is a special compiler directive that asks Swift to make sure the method name exists where we say
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }
    
    // Marking this function @objc is required to generate code that can be read by Objective-C
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save finished")
    }
}
