//
//  StringExt.swift
//  BreakingBadQuotes
//
//  Created by Victor Emanuel Ribeiro Silva on 26/03/25.
//

extension String {
    func removeSpaces() -> String {
        replacingOccurrences(of: " ", with: "")
    }

    func removeCaseAndSpaces() -> String {
        lowercased().removeSpaces()
    }
}
