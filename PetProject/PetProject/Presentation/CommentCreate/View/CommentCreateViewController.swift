//
//  CommetCreateViewController.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 23.01.2024.
//

import UIKit

class CommentCreateViewController: UIViewController {

    private var viewModel: CommentCreateViewModelPorotocol!
    
    func initCommentCreate(viewModel: CommentCreateViewModelPorotocol) -> CommentCreateViewController {
        let view = CommentCreateViewController()
        view.viewModel = viewModel
        return view
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
