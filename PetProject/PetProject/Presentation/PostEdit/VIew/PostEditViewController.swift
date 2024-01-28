//
//  PostEditViewController.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 22.01.2024.
//

import UIKit

class PostEditViewController: UIViewController {

    private var viewModel: PostEditViewModelPorotocol!
    
    static func initPostEditController(viewModel: PostEditViewModelPorotocol) -> PostEditViewController {
        let view = PostEditViewController()
        view.viewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
