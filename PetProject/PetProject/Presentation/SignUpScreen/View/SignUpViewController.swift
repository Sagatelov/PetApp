//
//  SignUpViewController.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 08.02.2024.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var errorEmail: UILabel!
    @IBOutlet weak var errorPassword: UILabel!
    @IBOutlet weak var errorName: UILabel!
    @IBOutlet weak var errorNick: UILabel!
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var nickField: UITextField!
    
    @IBOutlet weak var singButton: UIButton!
    
    private var viewModel: SignUpViewModelPorotocol!
    
    static func initSignScreen(viewModel: SignUpViewModelPorotocol) -> SignUpViewController {
        let controller = SignUpViewController()
        controller.viewModel = viewModel
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(to: viewModel)
        setViewsStyle()
    }
    
    //MARK: Privat
    private func bind(to viewModel: SignUpViewModelPorotocol) {
        viewModel.alert.observe(on: self) { [weak self] in
            if !$0.isEmpty {
                self?.alert($0) }
        }
        
        viewModel.error.observe(on: self) { [weak self] in
            if !$0.isEmpty {
                self?.alertError(message: $0) }
        }
    }
    
    private func userSuccess() {
        self.navigationController?.presentingViewController?.dismiss(animated: true)
    }
    
    private func alert(_ message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ок", style: .default) { _ in
            self.userSuccess()
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
    
    //MARK: Validation
    private func passwordValidation(data: String) -> String? {
        if data.count < 8 {
            return "Password must be at least 8 characters"
        } else if !Validation.validation(type: .digits, data: data) {
            return "Password must contain at least 1 digits"
        } else if !Validation.validation(type: .lowercase, data: data) {
            return "Password must contain at least 1 lowercase character"
        } else if !Validation.validation(type: .uppercase, data: data) {
            return "Password must contain at least 1 uppercase character"
        }
        return nil
    }
    
    private func emailValidation(data: UITextField) {
        guard let data = data.text else { return }
        
        let validation = Validation.validation(type: .email, data: data)
        
        if validation {
            errorEmail.isHidden = true
        } else {
            errorEmail.isHidden = false
            errorEmail.text = "Email not valid"
        }
        checkError()
    }
    
    private func nameValidation(data: UITextField) {
        guard let data = data.text else { return }
        
        let validation = Validation.validation(type: .name, data: data)
        
        if validation {
            errorName.isHidden = true
        } else {
            errorName.isHidden = false
            errorName.text = "Name not valid"
        }
        checkError()
    }
    
    private func nickValidation(data: UITextField) {
        guard let data = data.text else { return }
        
        let validation = Validation.validation(type: .nick, data: data)
        
        if validation {
            errorNick.isHidden = true
        } else {
            errorNick.isHidden = false
            errorNick.text = "Nick not valid"
        }
        checkError()
    }
    
    private func checkError() {
        if errorEmail.isHidden && errorName.isHidden && errorNick.isHidden && errorPassword.isHidden {
            singButton.isEnabled = true
        } else {
            singButton.isEnabled = false
        }
    }
    
    //MARK: Action
    @IBAction func emailChanged(_ sender: UITextField) {
        emailValidation(data: sender)
    }
    
    @IBAction func passwordChanged(_ sender: UITextField) {
        guard let text = sender.text else { return }
        if let password = passwordValidation(data: text) {
            errorPassword.isHidden = false
            errorPassword.text = password
        } else {
            errorPassword.isHidden = true
        }
        checkError()
    }
    
    @IBAction func nickChanged(_ sender: UITextField) {
        nickValidation(data: sender)
    }
    
    @IBAction func nameChanged(_ sender: UITextField) {
        nameValidation(data: sender)
    }
    
    @IBAction func signUp(_ sender: UIButton) {
        let newUserData = [
            "email": emailField.text ?? "",
            "password": passwordField.text ?? "",
            "name": nameField.text ?? "",
            "nick": nickField.text ?? ""
        ]
        viewModel.didTapSignUp(newUserData)
    }
}

private extension SignUpViewController {
    func configField(_ view: [UITextField]) {
        view.forEach {
            $0.backgroundColor = .opaqueSeparator
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 20
            $0.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
    func configErrorLabel(_ view: [UILabel]) {
        view.forEach {
            $0.text = "Required"
        }
    }
    
    func setViewsStyle() {
        configField([emailField,
                     passwordField,
                     nameField,
                     nickField])
        
        configErrorLabel([errorName,
                          errorNick,
                          errorEmail,
                          errorPassword])
        
        let fontsButton = FontsHalper.setFonts(name: .ubuntuRegular, size: 20)
        let normal: [NSAttributedString.Key: Any] = [
            .font: fontsButton,
            .foregroundColor: UIColor.systemGreen]
        
        let disable: [NSAttributedString.Key: Any] = [
            .font: fontsButton,
            .foregroundColor: UIColor.gray]
        
        let title = NSAttributedString(string: "Sign up", attributes: normal)
        let titleDisable = NSAttributedString(string: "Sign up", attributes: disable)
        
        singButton.isEnabled = false
        singButton.setAttributedTitle(title, for: .normal)
        singButton.setAttributedTitle(titleDisable, for: .disabled)
        singButton.titleLabel?.font = fontsButton
        singButton.layer.cornerRadius = 27
        singButton.layer.borderWidth = 3
        singButton.layer.borderColor = UIColor.gray.cgColor
        
    }
}
