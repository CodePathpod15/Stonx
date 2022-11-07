//
//  DashBoardVCExtension.swift
//  Stonx
//
//  Created by Angel Zambrano on 11/6/22.
//

import Foundation
import Parse

extension DashboardVCViewController: RecommendedStockDelegate {
    
    // TODO: display the the stock
    func userWantsToBuy() {
        
        navigationController?.pushViewController(StocksViewController(), animated: true)
    }
    
    
}
