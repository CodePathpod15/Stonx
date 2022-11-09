//
//  Constants.swift
//  Stonx
//
//  Created by Angel Zambrano on 10/29/22.
//

import Foundation
import UIKit

//Look into this: https://alpaca.markets/docs/market-data/

struct ColorConstants {
    static let gray = UIColor(red: 252/255, green: 252/255, blue: 253/255, alpha: 1)
    static let darkerGray = UIColor(red: 223/255, green: 223/255, blue: 230/255, alpha: 1)
    static let green = UIColor(red: 63/255, green: 191/255, blue: 160/255, alpha: 1)
    static let lightGreen = UIColor(red: 238/255, green: 254/255, blue: 242/255, alpha: 1)
    static let red = UIColor(red: 191/255, green: 78/255, blue: 63/255, alpha: 1)
    static let backgroundColor = UIColor.systemGray6
    static let yellow = UIColor(red: 245/255, green: 191/255, blue: 65/255, alpha: 1)
}

struct FontConstants {
    static let regularFont =  UIFont.systemFont(ofSize: 16)
    static let boldFont = UIFont.systemFont(ofSize: 16, weight: .bold)
    static let boldLargeFont = UIFont.systemFont(ofSize: 24, weight: .bold)
    static let cellSmallFont = UIFont.systemFont(ofSize: 12, weight: .regular)
    static let cellMediumFont = UIFont.systemFont(ofSize: 14, weight: .regular)
}


// related to parse column
class UserConstants {
    static let object_name = "User"
     static let username = "username"
     static let password = "password"
     static let fullname = "full_name"
     static let email = "email"
     static let last_surveyed = "last_surveyed"
     static let balance = "Balance"
     static let surveyed = "Surveyed"
 }

class ticker_rating {
    static let object_name = "ticker_rating"
    static let ticker_symbol = "ticker_symbol"
    static let user = "user"
    static let rating = "rating"
}

class user_transaction {
    static let object_name = "user_transaction"
    static let user = ticker_rating.user
    static let ticker_symbol = ticker_rating.ticker_symbol
    static let price = "price"
    static let quantity = "Quantity"
    static let purchase = "purchase"
}

// the
class Watchlist {
    static let object_name = "stocks_booked"
    static let user = ticker_rating.user
    static let sector = "sector"
    static let ticker_symbol = ticker_rating.ticker_symbol
}


