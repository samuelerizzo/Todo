//
//  TaskListViewController.swift
//  Todo
//
//  Created by Samuele Francesco Rizzo on 13/09/22.
//

import UIKit
import CoreData
import Combine

protocol TaskListViewControllerDelegate: AnyObject {
    func goToNewTask(viewContext: NSManagedObjectContext)
    func goToTaskDetail(task: Task)
}

class TaskListViewController: UIViewController {
    private var cancellables = Set<AnyCancellable>()
    
    weak var delegate: TaskListViewControllerDelegate?
    private let viewModel: TaskListViewModel
    
    @IBOutlet weak var tableView: UITableView!
    
    init(viewModel: TaskListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TaskTableViewCell.self)
        tableView.register(EmptyStateTableViewCell.self)
        
        viewModel.fetchTasks()
        
        configureUI()
        bind()
    }
    
    private func configureUI() {
        title = "task_list.title".localized
        navigationController?.navigationBar.prefersLargeTitles = true
        let addButton = UIBarButtonItem(image: .add, style: .plain, target: self, action: #selector(addTapped))
        addButton.accessibilityIdentifier = "task_list.button.add_task"
        navigationItem.rightBarButtonItem = addButton
    }
    
    private func bind() {
        viewModel.$tasks
            .sink { [weak self] _ in
                DispatchQueue.main.async {
                    self?.tableView?.reloadData()
                }
            }
            .store(in: &cancellables)
    }
    
    @objc func addTapped() {
        delegate?.goToNewTask(viewContext: viewModel.viewContext)
    }
}

extension TaskListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return !viewModel.tasks.isEmpty ? viewModel.tasks.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !viewModel.tasks.isEmpty {
            let cell = tableView.dequeue(TaskTableViewCell.self, indexPath)
            cell.configure(withTask: viewModel.tasks[indexPath.row])
            cell.onToggleStatus = { [weak self] in
                self?.viewModel.toggleTaskStatus(at: indexPath.row)
            }
            return cell
        } else {
            let cell = tableView.dequeue(EmptyStateTableViewCell.self, indexPath)
            cell.configure(title: "task_list.empty_state.title".localized)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard tableView.cellForRow(at: indexPath) is TaskTableViewCell else { return }
        delegate?.goToTaskDetail(task: viewModel.tasks[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return tableView.cellForRow(at: indexPath) is TaskTableViewCell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard tableView.cellForRow(at: indexPath) is TaskTableViewCell else { return }
        guard editingStyle == .delete else { return }
        viewModel.deleteTask(at: indexPath.row)
    }
}

