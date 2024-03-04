//
//  HeaderSectionView.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 15.02.2024.
//

import UIKit

class HeaderSectionView: UIView {
    private var name: UILabel!
    private var email: UILabel!
    private var profileIcon: UIImage!
    private var imageProfile: UIImageView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setLabel()
        setConstraints()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLabel()
        setConstraints()
    }
    
    private func setLabel() {
        let nameFont = FontsHalper.setFonts(name: .ubuntuRegular, size: 35)
        let emailFont = FontsHalper.setFonts(name: .ubuntuRegular, size: 20)
        
        name = UILabel()
        name.textColor = .systemGreen
        name.numberOfLines = 0
        name.textAlignment = .left
        name.font = nameFont
        name.translatesAutoresizingMaskIntoConstraints = false
                
        email = UILabel()
        email.textColor = .lightGray
        email.numberOfLines = 0
        email.textAlignment = .left
        email.font = emailFont
        email.translatesAutoresizingMaskIntoConstraints = false
        
        profileIcon = UIImage(systemName: "person.circle.fill")
        
        imageProfile = UIImageView(image: profileIcon)
        imageProfile.tintColor = .lightGray
        imageProfile.contentMode = .scaleToFill
        imageProfile.translatesAutoresizingMaskIntoConstraints = false
        
        self.backgroundColor = .darkGray
        self.addSubviews([name, email, imageProfile])
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            imageProfile.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            imageProfile.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            imageProfile.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50),
            imageProfile.widthAnchor.constraint(equalTo: imageProfile.heightAnchor, multiplier: 1/1),
            
            name.leadingAnchor.constraint(equalTo: imageProfile.trailingAnchor, constant: 20),
            name.topAnchor.constraint(equalTo: imageProfile.topAnchor),
            
            email.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            email.bottomAnchor.constraint(equalTo: imageProfile.bottomAnchor)
  
        ])
    }
    
    func set(name: String, email: String) {
        self.name.text = name
        self.email.text = email
    }
    
}
