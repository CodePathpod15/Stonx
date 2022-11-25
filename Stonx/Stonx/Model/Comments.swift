//
//  Comments.swift
//  Stonx
//
//  Created by Angel Zambrano on 11/23/22.
//

import Foundation
import Parse


// this is in charged of all of the API calls for the comments

struct StocksConstants {
    static let objectName = "Stocks"
    static let symbol = "symbol"
    static let comments = "Comments"
    static let comment_Author = "Comments.author"
}

struct CommentsConstants {
    static let objectName = "comments"
    static let author = "author"
    static let text = "text"
    static let stock = "stock"
}



// this is in charged of the comment feature inside of the
class Comments {
    static var shared  = Comments()
    // this retuns the count for the specific stock
    func gettingTheCount(ticker_id: String,  completion: @escaping (Result<Int, Error>) -> Void) {
        var selectedStock = [PFObject]()
        let query = PFQuery(className: StocksConstants.objectName)
        query.whereKey(StocksConstants.symbol, equalTo: ticker_id)
        query.includeKeys([StocksConstants.comments, StocksConstants.comment_Author])
        // The query should only find one match as every stock will be unique
        query.findObjectsInBackground { result, error in
            // returns an error
            if let error = error {
                completion(.failure(error))
            }
            
            if result != nil {
                selectedStock = result!
                
                // If the stock entry hasn't been made, make the entry and save it as the current stock
                if let stock = selectedStock.first {
                    let comments = (stock["Comments"] as? [PFObject]) ?? []
                    completion(.success(comments.count))
                } else {
                    // means we have have an object with no comments
                    completion(.success(0))
                    
                }
   
            }
            else {
                completion(.success(0))
            }
        }
    }
    
    
    var selectedStock = [PFObject]()

    
//    struct StocksConstants {
//        static let objectName = "Stocks"
//        static let symbol = "symbol"
//        static let comments = "Comments"
//        static let comment_Author = "Comments.author"
//    }
//
//    struct CommentsConstants {
//        static let objectName = "comments"
//        static let author = "author"
//        static let text = "text"
//        static let stock = "stock"
//    }
    
    
    // TODO: add pagination to the comments
    // getting the comments for an objec
    func gettingComments(stockName: String, completion: @escaping (Result<[Comment], Error>)-> Void) {
        let stock = PFObject(className: StocksConstants.objectName)
        let query = PFQuery(className: StocksConstants.objectName)
        query.whereKey(StocksConstants.symbol, equalTo: stockName)
        query.includeKeys([StocksConstants.comments, StocksConstants.comment_Author])
        // The query should only find one match as every stock will be unique
        query.findObjectsInBackground { result, error in
            if result != nil {
                self.selectedStock = result!
                
                // If the stock entry hasn't been made, make the entry and save it as the current stock
                if self.selectedStock.count == 0 {
                    stock[StocksConstants.symbol] = stockName
                    stock[CommentsConstants.objectName] = [PFObject]()
                    stock.saveInBackground { success, error in
                        if success {
                            query.findObjectsInBackground { result, _ in
                                if result != nil {
                                    self.selectedStock = result!
                                }
                            }
                        }
                        // returns an error
                        if let error = error {
                            completion(.failure(error))
                        }

                    }
                }
                
                var commentObjects = [Comment]()
                
                if let stock = self.selectedStock.first {
                    
                    let comments = (stock[StocksConstants.comments] as? [PFObject]) ?? []
                    
                    for comment in comments {
                        let profile = comment[CommentsConstants.author] as! PFUser
                        let comment = comment[CommentsConstants.text] as! String
                        
                        // create the comment
                        if let username = profile.username  {
                            
                            commentObjects.append(Comment(username: username, comment: comment))
                        }
                    }
                    
                }
                completion(.success(commentObjects))
            }
            else {
                print("QUERY RETURNED NULL")
            }
        }
    }
    
    
    // this is in charged of creating a comment
    func creatingAComment(with text: String,completion: @escaping (Result<Comment, Error>)-> Void) {
        let comment = PFObject(className: "comments")
        let stock = selectedStock.first!
        comment["text"] = text
        comment["author"] = PFUser.current()!
        comment["stock"] = stock

        stock.add(comment, forKey: "Comments")
        stock.saveInBackground { success, error in
            // check if there are any errors
            if let error = error {
                completion(.failure(error))
            }
            
            if success {
                if let username = PFUser.current()?.username {
                 completion(.success(Comment(username: username, comment: text)))
                }
                
            }
        }
    }
    
    
    

}
