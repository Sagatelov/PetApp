//
//  CommentTableViewCell.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 25.01.2024.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    
    private var nameLabel: UILabel!
    private var emailLabel: UILabel!
    private var bodyLabel: UILabel!
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLabel()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setLabel()
        setConstraints()
    }
    
    func configCell(_ commentData: CommentsModel) {
        nameLabel.text = commentData.name
        emailLabel.text = commentData.email
        bodyLabel.text = commentData.body
    }
    
    private func setLabel() {
        let font = UIFont(name: "Ubuntu-Regular", size: 20)
        
        nameLabel = UILabel()
        nameLabel.textColor = .systemGreen
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .left
        nameLabel.font = font
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        emailLabel = UILabel()
        emailLabel.textColor = .systemGreen
        emailLabel.numberOfLines = 0
        emailLabel.textAlignment = .left
        emailLabel.font = font
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        
        bodyLabel = UILabel()
        bodyLabel.textColor = .systemGreen
        bodyLabel.numberOfLines = 0
        bodyLabel.textAlignment = .left
        bodyLabel.font = font
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubviews([nameLabel,emailLabel,bodyLabel])
        self.backgroundColor = .darkGray
        self.selectionStyle = .none
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 40),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            nameLabel.bottomAnchor.constraint(equalTo: emailLabel.topAnchor, constant: -30),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -20),
            
            emailLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            emailLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            emailLabel.bottomAnchor.constraint(equalTo: bodyLabel.topAnchor, constant: -30),
            
            bodyLabel.leadingAnchor.constraint(equalTo: emailLabel.leadingAnchor),
            bodyLabel.trailingAnchor.constraint(equalTo: emailLabel.trailingAnchor),
            bodyLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -40)
        ])
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
