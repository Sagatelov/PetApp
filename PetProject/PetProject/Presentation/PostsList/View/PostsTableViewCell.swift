//
//  UserTableViewCell.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 24.01.2024.
//

import UIKit

protocol CellViewDataSource: AnyObject {
    func configurLikeButton() -> LikeButtonForCell
}

class PostsTableViewCell: UITableViewCell {

    lazy private var titleLable: UILabel = setTitleLabel()
    lazy private var body: UILabel = setBody()
    lazy private var likeButton: LikeButtonForCell = setlikeButton()
    
    weak var delegate: CellViewDataSource?
    
    init(style: UITableViewCell.CellStyle, reuseIdentifier: String?, delegate: CellViewDataSource) {
        self.delegate = delegate
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setSelfConfig()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setSelfConfig()
        setConstraints()
    }
    
    func configCell(_ postData: PostsModel, isActive: Bool) {
        titleLable.text = postData.title
        body.text = postData.body
        likeButton.setLikeButtonId(postData.id)
        likeButton.isSelected = isActive
    }
    
    private func setTitleLabel() -> UILabel {
        let titleLable = UILabel()
        titleLable.translatesAutoresizingMaskIntoConstraints = false
        titleLable.textColor = .systemGreen
        titleLable.textAlignment = .left
        titleLable.font = UIFont(name: "Ubuntu-Regular", size: 20)
        titleLable.numberOfLines = 0
        return titleLable
    }
    
    private func setBody() -> UILabel {
        let body = UILabel()
        body.translatesAutoresizingMaskIntoConstraints = false
        body.textColor = .systemGreen
        body.textAlignment = .left
        body.font = UIFont(name: "Ubuntu-Regular", size: 20)
        body.numberOfLines = 0
        return body
    }
    
    private func setlikeButton() -> LikeButtonForCell {
        guard let delegate = delegate else { return LikeButtonForCell()}
        return delegate.configurLikeButton()
    }
    
    private func setSelfConfig() {
        self.backgroundColor = .darkGray
        self.selectionStyle = .none
        self.contentView.addSubviews([likeButton, titleLable, body])
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleLable.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 40),
            titleLable.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 40),
            titleLable.trailingAnchor.constraint(lessThanOrEqualTo: self.contentView.trailingAnchor, constant: -20),
            
            body.trailingAnchor.constraint(equalTo: titleLable.trailingAnchor),
            body.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: 20),
            body.leadingAnchor.constraint(equalTo: titleLable.leadingAnchor),
            body.bottomAnchor.constraint(equalTo: likeButton.topAnchor, constant: -20),
            
            likeButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -30),
            likeButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -30)
        ])
    }
}
