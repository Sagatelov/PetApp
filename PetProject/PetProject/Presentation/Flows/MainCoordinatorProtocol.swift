//
//  MainCoordinatorProtocol.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 11.02.2024.
//

import UIKit

protocol MainCoordinatorProtocol {
    var navigation: UINavigationController { get }
    var screenBuilder: ScreenBuilderProtocol { get }
}
