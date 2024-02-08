//
//  UserTableViewCell.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 24.01.2024.
//

import UIKit

class PostsTableViewCell: UITableViewCell {

    var titleLable: UILabel!
    var body: UILabel!

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLables()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setLables()
        setConstraints()
    }
    
    func configCell(_ postData: PostsModel) {
        titleLable.text = postData.title
        body.text = postData.body
    }
    
    private func setLables() {
        let font = UIFont(name: "Ubuntu-Regular", size: 20)
        
        titleLable = UILabel()
        titleLable.textColor = .systemGreen
        titleLable.textAlignment = .left
        titleLable.translatesAutoresizingMaskIntoConstraints = false
        titleLable.font = font
        titleLable.numberOfLines = 0
        
        body = UILabel()
        body.textColor = .systemGreen
        body.textAlignment = .left
        body.translatesAutoresizingMaskIntoConstraints = false
        body.font = font
        body.numberOfLines = 0
        
        self.backgroundColor = .darkGray
        self.selectionStyle = .none
        self.addSubview(titleLable)
        self.addSubview(body)
    }

    private func setConstraints() {
        titleLable.topAnchor.constraint(equalTo: self.topAnchor, constant: 40).isActive = true
        titleLable.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40).isActive = true
        titleLable.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -20).isActive = true
        
        body.trailingAnchor.constraint(equalTo: titleLable.trailingAnchor).isActive = true
        body.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: 20).isActive = true
        body.leadingAnchor.constraint(equalTo: titleLable.leadingAnchor).isActive = true
        body.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -40).isActive = true
        
    }
}
