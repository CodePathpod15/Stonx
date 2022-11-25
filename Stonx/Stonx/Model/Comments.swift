//
//  Comments.swift
//  Stonx
//
//  Created by Angel Zambrano on 11/23/22.
//

import Foundation
import Parse


// this is in charged of all of the API calls for the comments

struct stocksConstants {
    static let objectName = "Stocks"
    static let symbol = "symbol"
    static let comments = "Comments"
    static let comment_Author = "Comments.author"
}




class Comments {
    static var shared  = Comments()
    // this retuns the count for the specific stock
    func gettingTheCount(ticker_id: String,  completion: @escaping (Result<Int, Error>) -> Void) {
        var selectedStock = [PFObject]()
        let query = PFQuery(className: "Stocks")
        query.whereKey("symbol", equalTo: ticker_id)
        query.includeKeys(["Comments", "Comments.author"])
        // The query should only find one match as every stock will be unique
        query.findObjectsInBackground { result, _ in
            
            if result != nil {
                selectedStock = result!
                
                // If the stock entry hasn't been made, make the entry and save it as the current stock
                if let stock = selectedStock.first {
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
    
    
    var selectedStock = [PFObject]()
    // getting the comments for an objec
    func gettingComments(stockName: String, completion: @escaping (Result<[Comment], Error>)-> Void) {
       
        let stock = PFObject(className: "Stocks")
        let query = PFQuery(className: "Stocks")
        query.whereKey("symbol", equalTo: stockName)
        query.includeKeys(["Comments", "Comments.author"])
        // The query should only find one match as every stock will be unique
        query.findObjectsInBackground { result, _ in
            if result != nil {
                self.selectedStock = result!
                
                // If the stock entry hasn't been made, make the entry and save it as the current stock
                if self.selectedStock.count == 0 {
                    stock["symbol"] = stockName
                    stock["comments"] = [PFObject]()
                    stock.saveInBackground { success, error in
                        if success {
                            query.findObjectsInBackground { result, _ in
                                if result != nil {
                                    self.selectedStock = result!
                                }
                            }
                            print("SAVING DATA SUCCESSFUL")
                        }
                        else {
                            print("ERROR: \(String(describing: error?.localizedDescription))")
                        }
                    }
                }
                
                var commentObjects = [Comment]()
                
                if let stock = self.selectedStock.first {
                    
                    let comments = (stock["Comments"] as? [PFObject]) ?? []
                    
                    for comment in comments {
                        let profile = comment["author"] as! PFUser
                        let comment = comment["text"] as! String
                        
                        // create the comment
                        if let username = profile.username  {
                            
                            commentObjects.append(Comment(username: username, comment: comment, imageUrl: nil))
                        }
                    }
                    
                }
                
                completion(.success(commentObjects))
                
                
    
//                self.tableView.reloadData()
            }
            else {
                print("QUERY RETURNED NULL")
            }
        }
    }
    
    // helper method to get
//    func
    
    
    
    
    
    
    
    
}
