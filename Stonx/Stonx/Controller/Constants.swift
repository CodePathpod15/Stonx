//
//  Constants.swift
//  Stonx
//
//  Created by Angel Zambrano on 10/29/22.
//

import Foundation
import UIKit


struct ColorConstants {
    static let gray = UIColor(red: 252/255, green: 252/255, blue: 253/255, alpha: 1)
    static let darkerGray = UIColor(red: 223/255, green: 223/255, blue: 230/255, alpha: 1)
    static let green = UIColor(red: 63/255, green: 191/255, blue: 160/255, alpha: 1)
    static let red = UIColor(red: 191/255, green: 78/255, blue: 63/255, alpha: 1)
    static let backgroundColor = UIColor.systemGray6
}

struct FontConstants {
    static let regularFont =  UIFont.systemFont(ofSize: 16)
    static let boldFont = UIFont.systemFont(ofSize: 16, weight: .bold)
    static let boldLargeFont = UIFont.systemFont(ofSize: 24, weight: .bold)
    static let cellSmallFont = UIFont.systemFont(ofSize: 12, weight: .regular)
    static let cellMediumFont = UIFont.systemFont(ofSize: 14, weight: .regular)
}
