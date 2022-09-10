//
//  String+Validation.swift
//

import Foundation

extension String {
    func trimmedWhiteSpaceString() -> Self {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func isNotEmptyString() -> Bool {
        return (!self.isEmpty && self.trimmedWhiteSpaceString().count > 0)
    }
}
