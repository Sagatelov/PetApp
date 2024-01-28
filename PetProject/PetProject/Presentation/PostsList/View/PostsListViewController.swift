//
//  PostsListViewController.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 22.01.2024.
//

import UIKit

class PostsListViewController: UIViewController {
    
    private var postsTableView: UITableView!
    private var viewModel: PostsListViewModelPorotocol!
    
    static func initPostsList(viewModel: PostsListViewModelPorotocol) -> PostsListViewController {
        let view = PostsListViewController()
        view.viewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postsTableView = cofigTable()
        viewModel.viewDidLoad()
        bind(viewModel: viewModel)
    }

    private func cofigTable() -> UITableView {
        let table = UITableView()
        table.register(PostsTableViewCell.self, forCellReuseIdentifier: "PostsCell")
        table.backgroundColor = .darkGray
        table.delegate = self
        table.dataSource = self
        table.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(table)
        
        table.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        table.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        table.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        table.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        return table
    }
    
    private func bind(viewModel: PostsListViewModelPorotocol) {
        viewModel.posts.observe(on: self) { [weak self] _ in
            self?.postsTableView.reloadData()
        }
    }
}

extension PostsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.posts.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = postsTableView.dequeueReusableCell(withIdentifier: "PostsCell", for: indexPath) as! PostsTableViewCell
        cell.configCell(viewModel.posts.value[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selected = viewModel.posts.value[indexPath.row]
        viewModel.didTapOnPosts(selected.id)
    }
    
    
}
