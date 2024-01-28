//
//  PostCreateViewController.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 22.01.2024.
//

import UIKit

class PostCreateViewController: UIViewController {

    private var viewModel: PostCreateViewModelPorotocol!
    
    func initPostCreate(viewModel: PostCreateViewModelPorotocol) -> PostCreateViewController {
        let view = PostCreateViewController()
        view.viewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
