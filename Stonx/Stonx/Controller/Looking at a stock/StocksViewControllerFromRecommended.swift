//
//  StocksViewControllerFromRecommended.swift
//  Stonx
//
//  Created by Angel Zambrano on 11/6/22.
//

import UIKit


// here is the implementation of the

// created this initializer so that I can use it the recommended stocksVC
extension StocksViewController {
    convenience init(symbol: String, full_name: String) {
        let bestMatch = BestMatch(the1Symbol: symbol, the2Name: full_name, the3Type: "", the4Region: "", the5MarketOpen: "", the6MarketClose: "", the7Timezone: "", the8Currency: "", the9MatchScore: "")
        self.init(stockInfo: bestMatch)
    }
    
}
