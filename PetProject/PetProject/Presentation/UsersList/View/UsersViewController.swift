//
//  ViewController.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 30.11.2023.
//

import UIKit

class UsersViewController: UIViewController, TableConfig {
    
    @IBOutlet private weak var usersListTableView: UITableView!
    
    private var userViewModel: UsersViewModel!
    private var idCell: String!
    
    static func initUsersList(viewModel: UsersViewModel) -> UsersViewController {
        let view = UsersViewController()
        view.userViewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config(table: usersListTableView, xibName: "UserTableViewCell") { id in
            self.idCell = id }
        userViewModel.viewDidLoad()
        bind(to: userViewModel)
    }
    
    private func bind(to viewModel: UsersViewModel) {
        
        viewModel.users.observe(on: self) { [weak self] users in
            self?.usersListTableView.reloadData() }
        viewModel.error.observe(on: self) {  [weak self] error in
            guard let error = error.first else { return }
            self?.errorAlert(error: error )
        }
    }
    
    private func errorAlert(error: Error) {
        let alert = UIAlertController(title: "Warning", message: error.localizedDescription, preferredStyle: .alert)
        let action = UIAlertAction(title: "ок", style: .default)
        alert.addAction(action)
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
    
    
}

