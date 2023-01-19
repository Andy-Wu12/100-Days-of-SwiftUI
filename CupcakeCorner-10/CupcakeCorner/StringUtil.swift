//
//  StringUtil.swift
//  CupcakeCorner
//
//  Created by Andy Wu on 1/10/23.
//

import Foundation

extension String {
    func isTrimmedEmpty() -> Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var isNumber: Bool {
        for c in self {
            if !c.isWholeNumber { return false }
        }
        return true
    }
}
