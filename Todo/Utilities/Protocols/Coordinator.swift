//
//  Coordinator.swift
//  Todo
//
//  Created by Samuele Francesco Rizzo on 13/09/22.
//

import Foundation

protocol Coordinator: AnyObject {
    var coordinators: [Coordinator] { get set }
    func start()
}
