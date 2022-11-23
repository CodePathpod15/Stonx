//
//  Comments.swift
//  Stonx
//
//  Created by Angel Zambrano on 11/23/22.
//

import Foundation
import Parse


// this is in charged of all of the API calls for the comments
class Comments {
    static var shared  = Comments()

    var selectedStock = [PFObject]()
    var stockName = ""

    
    // this retuns the count for the specific stock
    func gettingTheCount(ticker_id: String,  completion: @escaping (Result<Int, Error>) -> Void) {
        let stock = PFObject(className: "Stocks")
        let query = PFQuery(className: "Stocks")
        query.whereKey("symbol", equalTo: ticker_id)
        query.includeKeys(["Comments", "Comments.author"])
        // The query should only find one match as every stock will be unique
        query.findObjectsInBackground { result, _ in
            
            if result != nil {
                self.selectedStock = result!
                
                // If the stock entry hasn't been made, make the entry and save it as the current stock
                
                if let stock = self.selectedStock.first {
                    let comments = (stock["Comments"] as? [PFObject]) ?? []
                    completion(.success(comments.count))
                }
                
            }
            else {
                completion(.success(0))
                print("QUERY RETURNED NULL")
            }
        }
    }
    
    
    
    
    
}
