//
//  FontsHalper.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 01.03.2024.
//

import Foundation
import UIKit

final class FontsHalper {
    enum TypeFonts: String {
        case ubuntuRegular = "Ubuntu-Regular"
        case bigApple3PM = "Big Apple 3PM"
    }
    
    static func setFonts(name: TypeFonts, size: CGFloat) -> UIFont {
        let systemFont = UIFont.systemFont(ofSize: size)
        let fontsName = name.rawValue
        guard let nameFont = UIFont(name: fontsName, size: size ) else { return systemFont }
        return nameFont
    }
}
