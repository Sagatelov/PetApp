//
//  TableCellModel.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 14.02.2024.
//

import UIKit

    struct SettingsSection {
        var title: String?
        var cells: [SettingsItem]
        
        struct SettingsItem {
            var createdCell: () -> UITableViewCell
            var action: ((SettingsItem) -> Void)?
        }
    }
