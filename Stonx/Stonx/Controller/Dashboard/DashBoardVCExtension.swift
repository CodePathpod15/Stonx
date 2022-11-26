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
        API.getStockAboutMe(tickerSymbol:   recommendedStr) { result in
            switch result {
            case .success(let items):
                if let items = items {
                    DispatchQueue.main.async {            
                        // TOODO: fix items.name
                        self.navigationController?.pushViewController(StocksVC(symbol: self.recommendedStr, full_name:  items.name ?? "xx" ), animated: true)
                        }
                } else {
                    self.showAlert(with: "error: ")
                    print("error: heheh")
                }
                
            case .failure(let error):
                // otherwise, print an error to the console
                self.showAlert(with: "error: ")
            }
        }
    }
    
    
}
