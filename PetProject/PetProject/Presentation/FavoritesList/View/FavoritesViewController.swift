//
//  FavoritesViewController.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 26.02.2024.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    private var viewModel: FavoritesViewModelPorotocol!
    lazy private var favoritesTabel: UITableView = configTable()
    
    static func initFavoritesController(viewModel: FavoritesViewModelPorotocol) -> FavoritesViewController {
        let controller = FavoritesViewController()
        controller.viewModel = viewModel
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBarStyle()
        viewModel.viewDidLoad()
        bind(to: viewModel)
    }
    
    //MARK: Privat method
    private func bind(to viewModel: FavoritesViewModelPorotocol) {
        viewModel.favoritesPosts.observe(on: self) { [weak self] _ in
            guard let self = self else { return }
            self.favoritesTabel.reloadData()
        }
    }
    
    @objc private func favoritesButtonTapped(_ sender: LikeButtonForCell) {
        guard let id = sender.id,
              let cell = sender.superview?.superview as? PostsTableViewCell,
              let indexPath = favoritesTabel.indexPath(for: cell) else { return }
        
        if sender.isSelected {
            viewModel.favoritesPosts.remove(observer: self)
            viewModel.favoritesPosts.value.remove(at: indexPath.row)
            viewModel.removeFavoritesDidTap(state: false, id: id)
            favoritesTabel.deleteRows(at: [indexPath], with: .automatic)
        }
        sender.isSelected = !sender.isSelected
    }
}

//MARK: Config views style
private extension FavoritesViewController {
    func setNavBarStyle() {
        title = "Favorites"
        let titleLargeFont = FontsHalper.setFonts(name: .bigApple3PM, size: 50)
        let titleFont = FontsHalper.setFonts(name: .ubuntuRegular, size: 20)
        
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: titleFont,
            NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.font: titleLargeFont,
            NSAttributedString.Key.foregroundColor: UIColor.systemGreen]
    }
    
    func configTable() -> UITableView {
        let table = UITableView()
        table.register(PostsTableViewCell.self, forCellReuseIdentifier: "FaforitesCell")
        table.backgroundColor = .darkGray
        table.dataSource = self
        table.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(table)
        
        table.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        table.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        table.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        table.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        return table
    }
}

//MARK: Delegate
extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.favoritesPosts.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PostsTableViewCell(style: .default, reuseIdentifier: "FaforitesCell", delegate: self)
        let favoritList = viewModel.favoritesPosts.value[indexPath.row]
        cell.configCell(favoritList, isActive: true)
        return cell
    }
    
}

extension FavoritesViewController: CellViewDataSource {
    func configurLikeButton() -> LikeButtonForCell {
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 30)
        let likeOffImage = UIImage(systemName: "heart", withConfiguration: symbolConfiguration)
        let likeOnImage = UIImage(systemName: "heart.fill", withConfiguration: symbolConfiguration)
        let likeButton = LikeButtonForCell(type: .custom)
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likeButton.setImage(likeOffImage, for: .normal)
        likeButton.setImage(likeOnImage, for: .selected)
        likeButton.addTarget(self, action: #selector(favoritesButtonTapped(_:)), for: .touchUpInside)
        return likeButton
    }
}
