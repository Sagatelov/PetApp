//
//  WelcomeViewController.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 08.02.2024.
//

import UIKit

final class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var welcomeLable: UILabel!
    
    private var viewModel: WelcomeViewModelPorotocol!
    
    static func initWelcomeScreen(viewModel: WelcomeViewModelPorotocol) -> WelcomeViewController {
        let controller = WelcomeViewController()
        controller.viewModel = viewModel
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewsStyle()
        controllerStyle()
    }
    
    //MARK: Action
    @IBAction func didTapSignUp(_ sender: UIButton) {
        viewModel.signUp()
    }
    
    @IBAction func didTapLogin(_ sender: UIButton) {
        viewModel.login()
    }
}

private extension WelcomeViewController {
    func controllerStyle() {
        view.backgroundColor = .darkGray
    }
    
    func viewsStyle() {
        let fontsButton = FontsHalper.setFonts(name: .ubuntuRegular, size: 20)
        let attributes: [NSAttributedString.Key: Any] = [
                    .font: fontsButton,
                    .foregroundColor: UIColor.systemGreen]
        let signUpTitle = NSAttributedString(string: "Sign up", attributes: attributes)
        let logIn  = NSAttributedString(string: "Log in", attributes: attributes)
        
        signUpButton.setAttributedTitle(signUpTitle, for: .normal)
        signUpButton.titleLabel?.font = fontsButton
        signUpButton.layer.cornerRadius = 27
        signUpButton.layer.borderWidth = 3
        signUpButton.layer.borderColor = UIColor.gray.cgColor
        
        loginButton.setAttributedTitle(logIn, for: .normal)
        loginButton.titleLabel?.font = fontsButton
        loginButton.layer.cornerRadius = 27
        loginButton.layer.borderWidth = 3
        loginButton.layer.borderColor = UIColor.gray.cgColor

        welcomeLable.text = "Welcome to PetApp"
        welcomeLable.textColor = .systemGreen
        welcomeLable.font = FontsHalper.setFonts(name: .bigApple3PM, size: 35)
    }
}
