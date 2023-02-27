//
//  PackageDependencies.swift
//  HotProspects-16
//
//  Created by Andy Wu on 2/26/23.
//

import SwiftUI
import SamplePackage

struct PackageDependencies: View {
    let possibleNumbers = Array(1...60)
    
    // Using random method from SamplePackage at https://github.com/twostraws/SamplePackage
    var results: String {
        let selected = possibleNumbers.random(7).sorted()
        let strings = selected.map(String.init)
        
        return strings.joined(separator: ", ")
    }
    
    var body: some View {
        Text(results)
    }
}

struct PackageDependencies_Previews: PreviewProvider {
    static var previews: some View {
        PackageDependencies()
    }
}
