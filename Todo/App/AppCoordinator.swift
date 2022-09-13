//
//  AppCoordinator.swift
//  Todo
//
//  Created by Samuele Francesco Rizzo on 13/09/22.
//

import Foundation
import UIKit
import CoreData

class AppCoordinator: Coordinator {
    var coordinators: [Coordinator] = []
    
    private let window: UIWindow
    private let viewContext: NSManagedObjectContext
    
    init(window: UIWindow, viewContext: NSManagedObjectContext) {
        self.window = window
        self.viewContext = viewContext
    }
    
    func start() {
        showTasks()
    }
    
    private func showTasks() {
        let coordinator = TasksCoordinator(window: window, viewContext: viewContext)
        coordinator.start()
        coordinators.append(coordinator)
    }
}

