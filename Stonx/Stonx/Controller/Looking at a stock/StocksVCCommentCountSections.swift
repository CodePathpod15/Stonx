//
//  StocksVCCommentCountSections.swift
//  Stonx
//
//  Created by Angel Zambrano on 11/25/22.
//

import UIKit

extension StocksVC {
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
    
    
    // changes the text of the button when no comment has been added yet.
    func enableOrDisableCommentLblAndButton(with count: Int) {
        if count == 0 {
            self.contentView.viewAllCommentsLlbl.setTitle("Add a comment", for: .normal)
        } else {
            self.contentView.viewAllCommentsLlbl.setTitle("View All \(count) Comments", for: .normal)
        }
    }
}
