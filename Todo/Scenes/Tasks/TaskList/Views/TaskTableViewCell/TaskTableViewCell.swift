//
//  TaskTableViewCell.swift
//  Todo
//
//  Created by Samuele Francesco Rizzo on 13/09/22.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    var onToggleStatus: (() -> Void)?
    
    @IBOutlet weak var checkboxButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        checkboxButton.isSelected = false
        titleLabel.text = nil
    }
    
    func configure(withTask task: Task) {
        checkboxButton.isSelected = task.isCompleted
        titleLabel.text = task.title
        titleLabel.textColor = task.isCompleted ? .tertiaryLabel : .label
    }
    
    @IBAction func toggleStatusAction(_ sender: Any) {
        onToggleStatus?()
    }
}
