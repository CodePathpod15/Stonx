//
//  StockVCFromRecommended.swift
//  Stonx
//
//  Created by Angel Zambrano on 11/25/22.
//

import UIKit

// created this initializer so that I can use it the recommended stocksVC
extension StocksVC {
    
    convenience init(symbol: String, full_name: String) {
        
        
        let bestMatch = BestMatch(the1Symbol: symbol, the2Name: full_name, the3Type: "", the4Region: "", the5MarketOpen: "", the6MarketClose: "", the7Timezone: "", the8Currency: "", the9MatchScore: "")
        self.init(stockInfo: bestMatch)
    }
}
