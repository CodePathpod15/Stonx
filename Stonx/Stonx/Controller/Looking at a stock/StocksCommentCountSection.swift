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
                    // TODO:
                    self.enableOrDisableCommentLblAndButton(with: commentCount)
                }
                print(commentCount)
            case .failure(let error):
                self.showAlert(with: error.localizedDescription)
            }
        }
        
        
    }
    
    func enableOrDisableCommentLblAndButton(with count: Int) {
        if count == 0 {
            self.viewAllCommentsLlbl.setTitle("Add a comment", for: .normal)

            
        } else {

            self.viewAllCommentsLlbl.setTitle("View All \(count) Comments", for: .normal)

        }
    }
    
    
}
