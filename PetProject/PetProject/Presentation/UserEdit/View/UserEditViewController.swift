//
//  UserEditViewController.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 27.12.2023.
//

import UIKit

protocol ConectViewModelDelegat: AnyObject {
    func didReceveData()
}

class UserEditViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var validationLabel: UILabel!
    
    
    private var viewModel: UserEditViewModelPorotocol!
    private var updateBarButton: UIBarButtonItem!
    
    
    weak var delegat: ConectViewModelDelegat?
    
    static func initUserEdit(viewModel: UserEditViewModelPorotocol) -> UserEditViewController {
        let controler = UserEditViewController()
        controler.viewModel = viewModel
        return controler
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextField([
            nameTextField,
            userNameTextField,
            emailTextField ])
        
        setColor()
        setDelegate()
        configValidationLabel()
        configBarButton()
        bind(to: viewModel)
    }
    
    // MARK: - Private
    private func setTextField(_ fields: [UITextField]) {
        let font = UIFont(name: "Ubuntu-Regular", size: 16)
        fields.forEach {
            $0.layer.cornerRadius = 18
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.systemGray.cgColor
            $0.clipsToBounds = true
            $0.font = font
        }
    }
    
    private func setDelegate() {
        nameTextField.delegate = self
        userNameTextField.delegate = self
        emailTextField.delegate = self
    }
    
    private func setColor() {
        view.backgroundColor = .darkGray
    }
    
    private func configValidationLabel() {
        validationLabel.textColor = #colorLiteral(red: 1, green: 0.4932563305, blue: 0.4739957452, alpha: 1)
        validationLabel.isHidden = true
    }
    
    private func configBarButton() {
        updateBarButton = UIBarButtonItem()
        updateBarButton.tintColor = UIColor.systemGreen
        updateBarButton.title = "Update"
        updateBarButton.isEnabled = true
        updateBarButton.isHidden = true
        navigationItem.rightBarButtonItem = updateBarButton
        updateBarButton.target = self
        updateBarButton.action = #selector(action)
    }
    
    @objc private func action() {
        var editUser = [String:String]()
        editUser.updateValue(nameTextField.text ?? "", forKey: "name")
        editUser.updateValue(userNameTextField.text ?? "", forKey: "username")
        editUser.updateValue(emailTextField.text ?? "", forKey: "email")
        viewModel.editingUser(data: editUser)
    }
    
    private func bind(to viewModel: UserEditViewModelPorotocol) {
        viewModel.user.observe(on: self) { [weak self] user in
            self?.userTextField(user: user) }
        viewModel.state.observe(on: self) { [weak self] in
            self?.editingResultAlert($0)
        }
    }
    
    private func userTextField(user: UsersModel) {
        self.nameTextField.text = user.name
        self.userNameTextField.text = user.username
        self.emailTextField.text = user.email
    }
    
    private func editingResultAlert(_ state: State?) {
        if case .successString((_)) = state {
            alert(title: "Пользователь обновлен", messege: "Редактирование прошло успешно")}
        if case .errorString(let error) = state {
            alert(title: "Ошибка редактирования", messege: error)
        }
    }
    
    private func alert(title: String, messege: String) {
        let alert = UIAlertController(title: title, message: messege, preferredStyle: .alert)
        present(alert, animated: true)
    }
    
    
    //MARK: - Logic for editing fields
    
    private func handleEmailTextFieldValidation(_ textField: UITextField, _ range: NSRange, _ string: String) -> Bool {
        
        guard let text = textField.text, let range = Range(range, in: text) else { return true }
        
        let newString = text.replacingCharacters(in: range, with: string)
        
        let isEmailvalidated = Validation.validation(type: .email, data: newString)
        
        if isEmailvalidated {
            updateBarButton.isEnabled = true
            validationLabel.isHidden = true
        } else {
            updateBarButton.isEnabled = false
            validationLabel.isHidden = false
            validationLabel.text = "Invalid email format. \nPlease use the format: \nyourname@example.com."
        }
        return true
    }
    
    
    private func handleTextFields(_ textField: UITextField, _ range: NSRange, _ string: String) -> Bool {
        
        guard let text = textField.text, let range = Range(range, in: text), textField != emailTextField else { return false }
        
        let newString = text.replacingCharacters(in: range, with: string)
        
        let checkString = CharacterSet.letters
        let space = CharacterSet.whitespaces
        
        let existStringField = CharacterSet(charactersIn: string)
        let isContainingCharacters = checkString.isSuperset(of: existStringField)
        let isWhitespacesOn = space.isSuperset(of: existStringField)
        
        let textFields = [userNameTextField.text ?? "", nameTextField.text ?? ""]
        
        //logics for textfield
        ///input restriction if the field is empty and the user tries to enter a space or number
        if newString.isEmpty || (text.isEmpty && !isContainingCharacters) {
            
            updateBarButton.isEnabled = false
            
            ///restriction if the same data is entered in both fields
        } else if (Set(textFields).count != textFields.count && !isContainingCharacters && !isWhitespacesOn) || textFields.contains(newString) {
            
            updateBarButton.isEnabled = false
            
        } else if isWhitespacesOn {
            
            updateBarButton.isEnabled = true
            updateBarButton.isHidden = false
            return true
            
        } else {
            updateBarButton.isEnabled = true
            updateBarButton.isHidden = false
        }
        
        return isContainingCharacters
    }
    
    private func isFieldEmpty(_ textField: UITextField) -> Bool {
        guard let text = textField.text, !text.isEmpty else { return false }
        return true
    }
    
    
    //MARK: - Delegate
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        let isEmail = textField == emailTextField
        
        if isEmail {
            return validationLabel.isHidden
        } else {
            return isFieldEmpty(textField)
        }
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let isEmail = textField == emailTextField
        
        if isEmail {
            return handleEmailTextFieldValidation(textField, range, string)
        } else {
            return handleTextFields(textField, range, string)
        }
    }
}
