//
//  TaskListViewModel.swift
//  Todo
//
//  Created by Samuele Francesco Rizzo on 13/09/22.
//

import Foundation
import CoreData

class TaskListViewModel: NSObject {
    let viewContext: NSManagedObjectContext
    
    @Published var tasks = [Task]()
    
    private lazy var fetchedResultsController: NSFetchedResultsController<Task> = {
        let request = NSFetchRequest<Task>(entityName: "Task")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Task.createdAt, ascending: true)]
        let controller = NSFetchedResultsController(fetchRequest: request, managedObjectContext: viewContext, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self
        return controller
    }()
    
    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
    }
    
    private func persist() {
        do {
            try viewContext.save()
        } catch let error {
            print("Error saving: \(error)")
        }
    }
    
    func fetchTasks() {
        do {
            try fetchedResultsController.performFetch()
            tasks = fetchedResultsController.fetchedObjects ?? []
        } catch let error {
            print("Error fetching: ", error)
        }
    }
    
    func newTask() {
        let task = Task(context: viewContext)
        task.title = "A new task"
        persist()
    }
    
    func deleteTask(at index: Int) {
        viewContext.delete(tasks[index])
        persist()
    }
    
    func toggleTaskStatus(at index: Int) {
        tasks[index].isCompleted.toggle()
        persist()
    }
}

extension TaskListViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let tasks = controller.fetchedObjects as? [Task] else { return }
        self.tasks = tasks
    }
}
