//
//  ViewController.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 30.11.2023.
//

import UIKit

class UsersViewController: UIViewController, TableConfig {
    
    @IBOutlet private weak var usersListTableView: UITableView!
    
    private var userViewModel: UsersViewModelPorotocol!
    private var idCell: String!
    
    static func initUsersList(viewModel: UsersViewModelPorotocol) -> UsersViewController {
        let view = UsersViewController()
        view.userViewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config(table: usersListTableView, xibName: "UserTableViewCell") { id in
            self.idCell = id
        }
        
        setColorControllers()
        userViewModel.viewDidLoad()
        bind(to: userViewModel)
    }
    
    private func setColorControllers() {
        
        view.backgroundColor = .darkGray
        navigationController?.navigationBar.barTintColor = .darkGray
        
        navigationController?.tabBarController?.tabBar.barTintColor = .darkGray
        navigationController?.tabBarController?.tabBar.tintColor = .systemGreen
        navigationController?.tabBarController?.tabBar.unselectedItemTintColor = .systemGray
        navigationController?.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 0)
        
        usersListTableView.backgroundColor = .darkGray
    }
    
    private func bind(to viewModel: UsersViewModelPorotocol) {
        
        viewModel.users.observe(on: self) { [weak self] _ in
            self?.usersListTableView.reloadData() }
        viewModel.error.observe(on: self) { [weak self] error in
            guard let error = error.first else { return }
            self?.errorAlert(error: error)
        }
    }
    
    private func errorAlert(error: Error) {
        let alert = UIAlertController(title: "Ошибка", message: error.localizedDescription, preferredStyle: .alert)
        let action = UIAlertAction(title: "ок", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    private func successAlert(state: State) {
        switch state {
        case .successString(let messege):
            alert(title: "Успешно", messege: "пользователь с ID \(messege) удален")
        default:
            break
        }
    }
    
    private func alert(title: String, messege: String) {
        let alert = UIAlertController(title: title, message: messege, preferredStyle: .alert)
        present(alert, animated: true)
    }
}


extension UsersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userViewModel.users.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = usersListTableView.dequeueReusableCell(withIdentifier: idCell, for: indexPath) as! UserTableViewCell
        let user = userViewModel.users.value[indexPath.row]
        cell.configureCell(users: user)
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let user = self.userViewModel.users.value[indexPath.row]
        let model = self.userViewModel
        
        let editeAction = UIContextualAction(style: .normal, title: "Edite") { action, view, completion in
            
            model?.edit(user: user)
            completion(true)
        }
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { action, view, completion in
            
            model?.deleteUserBy(id: user.id)
            completion(true)
        }
        deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0.2335082591, blue: 0.1885917783, alpha: 1)
        editeAction.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        
        let swipeConfigur = UISwipeActionsConfiguration(actions: [editeAction, deleteAction])
        swipeConfigur.performsFirstActionWithFullSwipe = false
        
        return swipeConfigur
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedUser = userViewModel.users.value[indexPath.row]
        userViewModel.didTapOnUser(selectedUser.id)
        
    }
}
