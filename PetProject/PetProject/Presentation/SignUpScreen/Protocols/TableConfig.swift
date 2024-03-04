//
//  TableConfig.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 22.12.2023.
//

import Foundation
import UIKit

protocol TableConfig {}
extension TableConfig where Self: UIViewController {
    func config(table: UITableView, xibName: String, completion: (String) -> Void) -> Void {
        
        table.dataSource = self as? UITableViewDataSource
        table.delegate = self as? UITableViewDelegate
        let cell = xibName + "id"
        let nib = UINib(nibName: xibName, bundle: nil)
        table.register(nib, forCellReuseIdentifier: cell)
        completion(cell)
    }
}

