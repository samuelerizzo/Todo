//
//  Task+AwakeFromInsert.swift
//  Todo
//
//  Created by Samuele Francesco Rizzo on 13/09/22.
//

import Foundation

extension Task {
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        createdAt = Date()
        isCompleted = false
    }
}
