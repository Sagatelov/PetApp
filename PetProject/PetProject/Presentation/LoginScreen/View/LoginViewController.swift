//
//  LoginViewController.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 08.02.2024.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var errorLable: UILabel!
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    
    private var viewModel: LoginViewModelPorotocol!
    
    static func initLoginScreen(viewModel: LoginViewModelPorotocol) -> LoginViewController {
        let controller = LoginViewController()
        controller.viewModel = viewModel
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(to: viewModel)
        viewsStyle()
    }
    
    //MARK: Bind to ViewModel
    private func bind(to viewModel: LoginViewModelPorotocol) {
        viewModel.alert.observe(on: self) { [weak self] in
            if !$0.isEmpty {
                self?.alert(message: $0) } }
        
        viewModel.error.observe(on: self) { [weak self] in
            if !$0.isEmpty {
                self?.alertError(message: $0) }
        }
    }
    
    //MARK: Private
    private func sussesLogin() {
        viewModel.userSuccessDidLogin()
        navigationController?.presentingViewController?.dismiss(animated: true)
    }
    
    private func alert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) {_ in
            self.sussesLogin()
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    private func alertError(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    
    private func emailValidation(data: String) -> String? {
        if !Validation.validation(type: .email, data: data) {
            return "Email is not valid"
        } else if data.isEmpty {
            return "Email field is empty"
        } else if let password = passwordField.text, password.isEmpty {
            return "Enter the password field"
        }
        return nil
    }
    
    private func passwordValidation(data: String) -> String? {
        if data.count < 8 {
            return "Password must be at least 8 characters"
        } else if !Validation.validation(type: .uppercase, data: data) {
            return "Password must contain at least 1 uppercase character"
        } else if !Validation.validation(type: .lowercase, data: data) {
            return "Password must contain at least 1 lowercase character"
        } else if !Validation.validation(type: .digits, data: data) {
            return "Password must contain at least 1 digits"
        } else if let email = emailField.text, email.isEmpty {
            return "Enter the email field"
        }
        return nil
    }
    
    private func checkError() {
        submitButton.isEnabled = errorLable.isHidden
    }
    
    @IBAction func emailChanged(_ sender: UITextField) {
        guard let text = sender.text else { return }
        
        if let text = emailValidation(data: text) {
            errorLable.isHidden = false
            errorLable.text = text
        } else {
            errorLable.isHidden = true
        }
        checkError()
    }
    
    @IBAction func passwordChanged(_ sender: UITextField) {
        guard let text = sender.text else { return }
        if let text = passwordValidation(data: text) {
            errorLable.isHidden = false
            errorLable.text = text
        } else {
            errorLable.isHidden = true
        }
        checkError()
    }
    
    @IBAction func didTapSubmit(_ sender: UIButton) {
        let loginData = [
            "email": emailField.text ?? "",
            "password": passwordField.text ?? ""
        ]
        
        viewModel.didTabLoginWith(data: loginData)
    }
}

private extension LoginViewController {
    func viewsStyle() {
        
        let fontsButton = FontsHalper.setFonts(name: .ubuntuRegular, size: 20)
        let normal: [NSAttributedString.Key: Any] = [
            .font: fontsButton,
            .foregroundColor: UIColor.systemGreen]
        
        let disable: [NSAttributedString.Key: Any] = [
            .font: fontsButton,
            .foregroundColor: UIColor.gray]
        
        let title = NSAttributedString(string: "Sign up", attributes: normal)
        let titleDisable = NSAttributedString(string: "Sign up", attributes: disable)
        
        submitButton.isEnabled = false
        submitButton.setAttributedTitle(title, for: .normal)
        submitButton.setAttributedTitle(titleDisable, for: .disabled)
        submitButton.titleLabel?.font = fontsButton
        submitButton.layer.cornerRadius = 27
        submitButton.layer.borderWidth = 3
        submitButton.layer.borderColor = UIColor.gray.cgColor
        
        errorLable.text = "Please complete all fields."
        
        emailField.placeholder = "Fake email"
        emailField.backgroundColor = .opaqueSeparator
        emailField.clipsToBounds = true
        emailField.layer.cornerRadius = 20
        
        passwordField.placeholder = "Password"
        passwordField.backgroundColor = .opaqueSeparator
        passwordField.clipsToBounds = true
        passwordField.layer.cornerRadius = 20
        
    }
}
