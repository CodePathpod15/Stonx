//
//  Parse.swift
//  Stonx
//
//  Created by Angel Zambrano on 11/8/22.
//

import Foundation
import Parse



class ParseModel {
    static let shared = ParseModel()
    
    func getStockUserOwns(completion: @escaping (Result<[Stock]?, Error>) -> Void) {
            // this contains all of the stocks the user owns
            var stocksUserOwns = [Stock]()
            let query = PFQuery(className: user_transaction.object_name)
            query.whereKey(user_transaction.user, contains:  PFUser.current()!.objectId)
        
            
            var tickerToOwn:[String: Int] = [String: Int]()
            // hash map: key =  ticker, value is the date
            var tickerToHash:[String: Date] = [:]
            
            query.findObjectsInBackground() { (objects: [PFObject]?, error: Error?) in
                
                // printing the errror
                if let error = error {
                    completion(.failure(error))
                }
                
                // return nil
                if objects == nil {
                    completion(.success(stocksUserOwns))
                }
                
                if let objects = objects {
                    if objects.isEmpty {
                        completion(.success(stocksUserOwns))
                    }
                    
                    for obj in objects {
                        let tt = obj[user_transaction.ticker_symbol] as? String
                        let amount  = obj[user_transaction.quantity] as? Int
                        let price = obj[user_transaction.price] as? Double
                        let transaction = obj[user_transaction.purchase] as! Bool
                        
                        if transaction {
                            tickerToOwn[tt!, default: 0] += amount!
                        } else {
                            tickerToOwn[tt!, default: 0] -= amount!
                        }
                        
                        // put all of the the stocks inside of the ticker to hashDate table
                        if tickerToHash[tt!] != nil {
                            // comparing the two dates,
                            if tickerToHash[tt!]! > obj.createdAt! {
                                tickerToHash[tt!] = obj.createdAt!
                            }
                            // you keeep the same one
                        } else {
                            tickerToHash[tt!] = obj.createdAt!
                        }
                    }
                    
                    for (key, val) in tickerToOwn {
                        stocksUserOwns.append(Stock(ticker: key, price: 0, quantity: val, ticker_fullName: "x"))
                    }
                    // removes the quantities that have zero
                    stocksUserOwns.removeAll(where: {
                        // this gets rid of
                        if $0.quantity == 0 {
                            tickerToHash.removeValue(forKey: $0.ticker_symbol)
                        }
                        
                        return $0.quantity == 0
                    })

                    // this initializes each stock with the number of days they have owned each stock
                    for stock in stocksUserOwns {
                        if let dateOfLastTransaction = tickerToHash[stock.ticker_symbol] {
                            let diffInDays = Calendar.current.dateComponents([.day], from:  dateOfLastTransaction, to: Date()).day
                            stock.daysOfOnwerShip = diffInDays!
                        }
                    }
                    completion(.success(stocksUserOwns))
                }
            }
        }

}
