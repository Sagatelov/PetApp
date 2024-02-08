//
//  UIview + Extension.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 25.01.2024.
//

import UIKit
extension UIView {
    func addSubviews(_ views: [UIView]) {
          views.forEach { self.addSubview($0) }
      }
}
