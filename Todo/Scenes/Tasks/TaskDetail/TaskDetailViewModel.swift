//
//  TaskDetailViewModel.swift
//  Todo
//
//  Created by Samuele Francesco Rizzo on 13/09/22.
//

import Foundation
import CoreData

class TaskDetailViewModel {
    enum SceneType {
        case newTask(parentContext: NSManagedObjectContext)
        case editTask(task: Task)
        
        var title: String {
            switch self {
            case .newTask:
                return "task_detail.new.title".localized
            case .editTask:
                return "task_detail.edit.title".localized
            }
        }
    }
    
    private let parentContext: NSManagedObjectContext
    private let childContext: NSManagedObjectContext
    
    let sceneType: SceneType
    let task: Task
    let initialTitle: String
    
    init(sceneType: SceneType) {
        self.sceneType = sceneType
        
        switch sceneType {
        case .newTask(let parentContext):
            self.parentContext = parentContext
            let childContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
            childContext.parent = parentContext
            self.childContext = childContext
            self.task = Task(context: childContext)
        case .editTask(let task):
            guard let parentContext = task.managedObjectContext else { fatalError("Unable to get note context") }
            self.parentContext = parentContext
            let childContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
            childContext.parent = parentContext
            self.childContext = childContext
            guard let childObject = try? childContext.existingObject(with: task.objectID) as? Task else { fatalError("Unable to create child object") }
            self.task = childObject
        }
        self.initialTitle = task.title ?? ""
    }
    
    private func persist() {
        guard childContext.hasChanges else { return }
        do {
            try childContext.save()
        } catch {
            print("Something went wrong when saving the child context:", error)
            return
        }
        do {
            try parentContext.save()
        } catch {
            print("Something went wrong when saving the parent context:", error)
            return
        }
    }
    
    func saveTask() {
        persist()
    }
    
    func deleteTask() {
        childContext.delete(task)
        persist()
    }
}
