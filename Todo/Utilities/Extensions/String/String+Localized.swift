//
//  String+Localized.swift
//  Todo
//
//  Created by Samuele Francesco Rizzo on 13/09/22.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: self)
    }
}
