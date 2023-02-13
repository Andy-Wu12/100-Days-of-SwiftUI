//
//  FileManager-DocumentsDirectory.swift
//  BucketList-14
//
//  Created by Andy Wu on 2/13/23.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

