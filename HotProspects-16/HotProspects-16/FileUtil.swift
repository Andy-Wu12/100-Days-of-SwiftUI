//
//  FileUtil.swift
//  HotProspects-16
//
//  Created by Andy Wu on 3/4/23.
//

import Foundation

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    
    return paths[0]
}

func writeDocument<T: Codable>(name filename: String, for data: T) throws -> Void {
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    let jsonData = try encoder.encode(data)
    try jsonData.write(to: getDocumentsDirectory().appendingPathComponent(filename))
}

func readDocument<T: Codable>(name filename: String) throws -> T? {
    let url: URL = getDocumentsDirectory().appendingPathComponent(filename)
    if documentExists(at: filename) {
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let loaded = try decoder.decode(T.self, from: data)
            return loaded
        } catch {
            throw error
        }
    }
    return nil
}

func documentExists(at filename: String) -> Bool {
    // .absoluteString does not work here
    return FileManager.default.fileExists(atPath: getDocumentsDirectory().appendingPathComponent(filename).path())
}
