//
//  CommentsListViewController.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 22.01.2024.
//

import UIKit

class CommentsListViewController: UIViewController {
    
    private var commentsTableView: UITableView!
    private var viewModel: CommentsListViewModelPorotocol!
    
    static func initCommentsList(viewModel: CommentsListViewModelPorotocol) -> CommentsListViewController {
        let view = CommentsListViewController()
        view.viewModel = viewModel
        return view
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBarViews()
        commentsTableView = configTable()
        viewModel.viewDidLoad()
        bind(to: viewModel)
    }
    
    private func navBarViews() {
        title = "Comments"
        let titleLargeFont = FontsHalper.setFonts(name: .bigApple3PM, size: 50)
        let titleFont = FontsHalper.setFonts(name: .ubuntuRegular, size: 20)
        
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: titleFont,
            NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.font: titleLargeFont,
            NSAttributedString.Key.foregroundColor: UIColor.systemGreen]
    }
    
    private func configTable() -> UITableView {
        let table = UITableView()
        table.register(CommentTableViewCell.self, forCellReuseIdentifier: "CommentsCell")
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
    
    private func bind(to viewModel: CommentsListViewModelPorotocol) {
        viewModel.comments.observe(on: self) { [weak self] _ in
            self?.commentsTableView.reloadData()
        }
    }
    
}

extension CommentsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.comments.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = commentsTableView.dequeueReusableCell(withIdentifier: "CommentsCell", for: indexPath) as! CommentTableViewCell
        let comment = viewModel.comments.value[indexPath.row]
        cell.configCell(comment)
        return cell
    }
    
}
