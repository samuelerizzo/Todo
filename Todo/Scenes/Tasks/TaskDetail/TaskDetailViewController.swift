//
//  TaskDetailViewController.swift
//  Todo
//
//  Created by Samuele Francesco Rizzo on 13/09/22.
//

import UIKit

protocol TaskDetailViewControllerDelegate: AnyObject {
    func goBack()
}

class TaskDetailViewController: UIViewController {
    weak var delegate: TaskDetailViewControllerDelegate?
    private let viewModel: TaskDetailViewModel
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    init(viewModel: TaskDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        updateSaveButtonState()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        titleTextField.becomeFirstResponder()
    }
    
    private func configureUI() {
        title = viewModel.sceneType.title
        let deleteButton = UIBarButtonItem(image: .init(systemName: "trash"), style: .plain, target: self, action: #selector(removeTapped))
        deleteButton.accessibilityIdentifier = "task_detail.button.delete"
        navigationItem.rightBarButtonItem = deleteButton
        titleTextField.placeholder = "task_detail.title_text_field.placeholder".localized
        titleTextField.text = viewModel.task.title
        saveButton.setTitle("task_detail.save_button.title".localized, for: .normal)
        saveButton.setTitle("task_detail.save_button.title".localized, for: .disabled)
        
    }
    
    private func updateSaveButtonState() {
        let taskTitle = viewModel.task.title ?? ""
        saveButton.isEnabled = !taskTitle.noSpaces.isEmpty && taskTitle != viewModel.initialTitle
    }
    
    @objc func removeTapped() {
        viewModel.deleteTask()
        delegate?.goBack()
    }
    
    @IBAction func saveAction(_ sender: Any) {
        viewModel.saveTask()
        delegate?.goBack()
    }
    
    @IBAction func titleTextFieldEditingChanged(_ sender: UITextField) {
        viewModel.task.title = sender.text
        updateSaveButtonState()
    }
}
