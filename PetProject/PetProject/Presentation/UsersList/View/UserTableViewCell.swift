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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(users: UsersModel) -> Void {
        Lable.text = users.name
        lableTwo.text = users.username
        lableThree.text = users.email
    }
}
