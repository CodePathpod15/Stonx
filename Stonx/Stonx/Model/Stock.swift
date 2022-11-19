//
//  Stock.swift
//  Stonx
//
//  Created by Angel Zambrano on 11/8/22.
//

import UIKit

class Stock {
    var ticker_symbol: String
    var ticker_fullName: String
    var price: Double
    var quantity: Int
    var daysOfOnwerShip = 0
    var chagePercent: String = "x.x%"
    var sector: String = ""
    var rating: Double?  = nil
    
    init(ticker: String, price: Double, quantity: Int, ticker_fullName: String) {
        self.ticker_symbol = ticker
        self.price = price
        self.quantity = quantity
        self.ticker_fullName = ticker_fullName
    
    }
    
}
