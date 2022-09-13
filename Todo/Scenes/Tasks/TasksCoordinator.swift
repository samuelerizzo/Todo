//
//  TasksCoordinator.swift
//  Todo
//
//  Created by Samuele Francesco Rizzo on 13/09/22.
//

import Foundation
import UIKit
import CoreData

class TasksCoordinator: Coordinator {
    var coordinators: [Coordinator] = []
    
    private let window: UIWindow
    private let navigator: UINavigationController
    
    init(window: UIWindow, viewContext: NSManagedObjectContext) {
        self.window = window
        let tasksListViewController = TaskListViewController(viewModel: .init(viewContext: viewContext))
        navigator = UINavigationController(rootViewController: tasksListViewController)
        tasksListViewController.delegate = self
    }
    
    func start() {
        window.rootViewController = navigator
    }
    
    func goBack() {
        navigator.popViewController(animated: true)
    }
}

extension TasksCoordinator: TaskListViewControllerDelegate {
    func goToNewTask(viewContext: NSManagedObjectContext) {
        let viewController = TaskDetailViewController(viewModel: .init(sceneType: .newTask(parentContext: viewContext)))
        viewController.delegate = self
        navigator.pushViewController(viewController, animated: true)
    }
    
    func goToTaskDetail(task: Task) {
        let viewController = TaskDetailViewController(viewModel: .init(sceneType: .editTask(task: task)))
        viewController.delegate = self
        navigator.pushViewController(viewController, animated: true)
    }
}

extension TasksCoordinator: TaskDetailViewControllerDelegate {}
