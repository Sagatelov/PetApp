//
//  PostsListViewController.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 22.01.2024.
//

import UIKit

class PostsListViewController: UIViewController {
    
    lazy private var postsTableView = cofigTable()
    private var viewModel: PostsListViewModelPorotocol!
    
    static func initPostsList(viewModel: PostsListViewModelPorotocol) -> PostsListViewController {
        let view = PostsListViewController()
        view.viewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postsTableView = cofigTable()
        navBarViews()
        viewModel.viewDidLoad()
        bind(viewModel: viewModel)
    }
    
    @objc func likeButtonTapped(_ sender: LikeButtonForCell) {
        guard let id = sender.id else { return }
        if !sender.isSelected {
            self.viewModel.favoritesButtonDidTap(state: true, id: id)
        } else {
            self.viewModel.favoritesButtonDidTap(state: false, id: id)
        }
        sender.isSelected = !sender.isSelected
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
        let cell = PostsTableViewCell(style: .default, reuseIdentifier: "PostsCell", delegate: self)
        //        let cell = postsTableView.dequeueReusableCell(withIdentifier: "PostsCell", for: indexPath) as! PostsTableViewCell
        let selectedPost = viewModel.posts.value[indexPath.row]
        let favoritesButtonState  = viewModel.favoritesLoadDataWith(id: selectedPost.id)
        cell.configCell(selectedPost,isActive: favoritesButtonState)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selected = viewModel.posts.value[indexPath.row]
        viewModel.didTapOnPosts(selected.id)
    }
}

extension PostsListViewController: CellViewDataSource {
    func configurLikeButton() -> LikeButtonForCell {
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 30)
        let likeOffImage = UIImage(systemName: "heart", withConfiguration: symbolConfiguration)
        let likeOnImage = UIImage(systemName: "heart.fill", withConfiguration: symbolConfiguration)
        let likeButton = LikeButtonForCell(type: .custom)
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likeButton.setImage(likeOffImage, for: .normal)
        likeButton.setImage(likeOnImage, for: .selected)
        likeButton.addTarget(self, action: #selector(likeButtonTapped(_:)), for: .touchUpInside)
        return likeButton
    }
    
    private func navBarViews() {
        title = "Posts"
        let titleLargeFont = FontsHalper.setFonts(name: .bigApple3PM, size: 50)
        let titleFont = FontsHalper.setFonts(name: .ubuntuRegular, size: 20)
        
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: titleFont,
            NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.font: titleLargeFont,
            NSAttributedString.Key.foregroundColor: UIColor.systemGreen]
    }
}
