//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Andy Wu on 12/19/22.
//

import Foundation

extension Bundle {
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) in bundle.")
        }
        
        let decoder = JSONDecoder()
        // Specify format to parse dates
        let formatter = DateFormatter()
        /// Note that DateFormat is case-sensitive.
        /// "mm" means "zero-padded minute" while "MM" means "zero-padded month"
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) in bundle.")
        }
        
        return loaded
    }
}
