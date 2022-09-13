//
//  UITableView+Register.swift
//  Todo
//
//  Created by Samuele Francesco Rizzo on 13/09/22.
//

import Foundation
import UIKit

extension UITableView {
    func register<T: UITableViewCell>(_ type: T.Type) {
        let name = String(describing: type)
        register(UINib(nibName: name, bundle: nil), forCellReuseIdentifier: type.description())
    }
    
    func dequeue<T: UITableViewCell>(_ type: T.Type, _ index: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: type.description(), for: index) as? T else { fatalError("Unable to dequeue cell") }
        return cell
    }
}
