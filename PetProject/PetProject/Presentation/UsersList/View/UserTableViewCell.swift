//
//  UserTableViewCell.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 20.12.2023.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lableThree: UILabel!
    @IBOutlet weak var lableTwo: UILabel!
    @IBOutlet weak var Lable: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setColorStyle()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setColorStyle()
    }
    
    func configureCell(users: UsersModel) -> Void {
        Lable.text = users.name
        lableTwo.text = users.username
        lableThree.text = users.email
    }
    
    private func setColorStyle() {
        backgroundColor = .darkGray
        selectionStyle = .none
    }
}
