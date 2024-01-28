//
//  UserCreateViewController.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 22.01.2024.
//

import UIKit

class UserCreateViewController: UIViewController {

    private var viewModel: UserCreateViewModelPorotocol!
    
    static func initCreateUserScreen(viewModel: UserCreateViewModelPorotocol) -> UserCreateViewController {
        let view = UserCreateViewController()
        view.viewModel = viewModel
        return view
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
