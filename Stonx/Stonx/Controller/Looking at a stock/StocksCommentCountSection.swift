//
//  StocksCommentCountSection.swift
//  Stonx
//
//  Created by Angel Zambrano on 11/23/22.
//

import Foundation


extension StocksViewController {
    
    
    // update
    func updateTheStocksCount() {
        
        Comments.shared.gettingTheCount(ticker_id: tickerName) { result in
            switch result {
            case .success(let commentCount):
                DispatchQueue.main.async {
                    
                    self.viewAllCommentsLlbl.setTitle("View All \(commentCount) Comments", for: .normal) 
                    
                }
                print(commentCount)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        
    }
    
    
}
