//
//  LikeButtonForCell.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 26.02.2024.
//

import UIKit
class LikeButtonForCell: UIButton {
    var id: Int?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setLikeButtonId(_ id: Int) {
        self.id = id
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let margin: CGFloat = 20
        let area = self.bounds.insetBy(dx: -margin, dy: -margin)
        return area.contains(point)
    }
}
