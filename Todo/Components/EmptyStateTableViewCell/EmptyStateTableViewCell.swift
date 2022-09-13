//
//  EmptyStateTableViewCell.swift
//  Todo
//
//  Created by Samuele Francesco Rizzo on 13/09/22.
//

import UIKit

class EmptyStateTableViewCell: UITableViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(image: UIImage? = .init(systemName: "square.stack.3d.up.slash"), title: String = "empty_state.title".localized) {
        iconImageView.image = image
        titleLabel.text = title
    }
}
