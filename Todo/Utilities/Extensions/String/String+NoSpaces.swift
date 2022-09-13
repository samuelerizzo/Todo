//
//  String+NoSpaces.swift
//  Todo
//
//  Created by Samuele Francesco Rizzo on 13/09/22.
//

import Foundation

extension String {
    var noSpaces: String {
        replacingOccurrences(of: " ", with: "")
    }
}
