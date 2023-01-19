//
//  StringUtil.swift
//  Bookworm
//
//  Created by Andy Wu on 1/15/23.
//

import Foundation

extension String {
    func isTrimmedEmpty() -> Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

}
