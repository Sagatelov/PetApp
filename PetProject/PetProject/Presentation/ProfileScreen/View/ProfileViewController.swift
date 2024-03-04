//
//  ProfileViewController.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 14.02.2024.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileTable: UITableView!
    
    private var tableCells = [SettingsSection]()
    private var reuseId = "ProfileCell"
    
    private var viewModel: ProfileViewModelPorotocol!
    
    static func initProfileController(viewModel: ProfileViewModelPorotocol) -> ProfileViewController {
        let controller = ProfileViewController()
        controller.viewModel = viewModel
        return controller
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        let config = UIImage.SymbolConfiguration(pointSize: 20)
        let image = UIImage(systemName: "person.circle", withConfiguration: config)
        tabBarItem = UITabBarItem(title: "Profile", image: image, tag: 0)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarStyle()
        navBarStyte()
        controllerStyle()
        configTable()
        configCells()
        bind(to: viewModel)
    }
    
    private func bind(to viewModel: ProfileViewModelPorotocol) {
        self.viewModel.user.observe(on: self) { [weak self] _ in
            self?.profileTable.reloadData()
        }
    }
}

//MARK: Configur controllers style
private extension ProfileViewController {
    func controllerStyle() {
        view.backgroundColor = .darkGray
    }
    
    func navBarStyte() {
        let titleLargeFont = FontsHalper.setFonts(name: .bigApple3PM, size: 50)
        let titleFont = FontsHalper.setFonts(name: .ubuntuRegular, size: 20)
        
        navigationController?.navigationBar.topItem?.title = "Profile"
        navigationController?.navigationBar.barTintColor = .darkGray
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: titleFont,
            NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.font: titleLargeFont,
            NSAttributedString.Key.foregroundColor: UIColor.systemGreen]
    }
    
    func tabBarStyle() {
        tabBarController?.tabBar.tintColor = .systemGreen
        tabBarController?.tabBar.unselectedItemTintColor = .brown
    }
}

//MARK: Configur table and cells
private extension ProfileViewController {
    func configTable() {
        profileTable.delegate = self
        profileTable.dataSource = self
        profileTable.sectionHeaderHeight = 130
        profileTable.backgroundColor = .darkGray
        profileTable.separatorStyle = .none
        
    }
    
    func symbolSetting(name: String, pointSize: CGFloat) -> UIImage? {
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: pointSize)
        let symbol = UIImage(systemName: name, withConfiguration: symbolConfiguration)
        return symbol
    }
    
    func configCells() {
        
        let symbolFavorites = symbolSetting(name: "heart.fill", pointSize: 20)
        let symbolPosts = symbolSetting(name: "book.pages.fill", pointSize: 20)
        
        let favorites = setCell(lable: "Your Favorites",
                                image: symbolFavorites,
                                acton: { [weak self] _ in self?.viewModel.favoritesCellDidTap() })
        
        let posts = setCell(lable: "Your Posts",
                            image: symbolPosts,
                            acton: { [weak self] _ in self?.viewModel.postsCellDidTap() })
        
        let section = SettingsSection(title: nil, cells: [favorites, posts])
        tableCells.append(section)
    }
    
    func setCell(lable: String,
                 image: UIImage?,
                 acton: ((SettingsSection.SettingsItem) -> Void)? = nil) -> SettingsSection.SettingsItem {
        
        let cell = {
            let cell = UITableViewCell(style: .default, reuseIdentifier: self.reuseId)
            cell.backgroundColor = .darkGray
            cell.selectionStyle = .none
            cell.contentConfiguration = {
                var content = cell.defaultContentConfiguration()
                content.text = lable
                content.textProperties.color = .lightText
                content.textProperties.font = FontsHalper.setFonts(name: .ubuntuRegular, size: 20)
                content.image = image
                content.imageProperties.tintColor = .systemGreen
                return content
            }()
            return cell
        }
        let cellCreated = SettingsSection.SettingsItem(createdCell: cell, action: acton)
        return cellCreated
    }
}

//MARK: Delegate method
extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableCells.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableCells[section].cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableCells[indexPath.section].cells[indexPath.row]
        return cell.createdCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableCells[indexPath.section].cells[indexPath.row]
        cell.action?(cell)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let email = self.viewModel.user.value.email
        let name = self.viewModel.user.value.name
        
        let headerView = HeaderSectionView()
        headerView.set(name: name, email: email)
        return headerView
    }
}
