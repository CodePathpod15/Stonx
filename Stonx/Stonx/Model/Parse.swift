//
//  Parse.swift
//  Stonx
//
//  Created by Angel Zambrano on 11/8/22.
//

import Foundation
import Parse

// Networking Service
// create layer

class ParseModel {
    static let shared = ParseModel()
    
    /// this is in charged of getting all of the stocks that the user owns
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
                
                // we just return an empty array if the object is nil
                if objects == nil {
                    completion(.success(stocksUserOwns))
                }
                

                if let objects = objects {
                    // if object exists but is empty we
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
    
    // get recommended stock
    // this will return the stock
    // TODO: 
    func getStockRecommendation(completion: @escaping (Result<Stock?, Error>) -> Void) {
        
    }
    
    // getting the watchlist
    //this gets the Watchlist
    func gettingUserWatchlist(bysector: String? = nil, completion: @escaping (Result<[Stock]?, Error>) -> Void) {
        
        var stocksUserOwns = [Stock]()
        let query = PFQuery(className: Watchlist.object_name)
        query.whereKey(Watchlist.user, contains:  PFUser.current()!.objectId)
        if let bysector = bysector {
            query.whereKey(Watchlist.sector, contains:  bysector)
        }
        query.findObjectsInBackground() { (objects: [PFObject]?, error: Error?) in
            // this means that there is an error
            if let error = error {
                completion(.failure(error))
            }
            // if it is nil, we just return an empty array
            if let objects = objects {
                
                if stocksUserOwns.isEmpty {
                    completion(.success(stocksUserOwns))
                }
                
                for object in objects {
                    let sector = object[Watchlist.sector] as? String
                    let ticker_symbol = object[Watchlist.ticker_symbol] as? String
                    
                    if let sector = sector, let ticker_symbol = ticker_symbol {
                        let stock = Stock(ticker: ticker_symbol, price: 0, quantity: 0, ticker_fullName: "")
                        stock.sector = sector
                        stocksUserOwns.append(stock)
                    }
                    // if they are both nil we dont really do anything
                }
                completion(.success(stocksUserOwns))
            } else {
                completion(.success(stocksUserOwns))
            }
 
        }
    }
}

//TODO: create survey model


//TODO: transaction model




/// this is the model in charged of the survey
class Survey {
    var surveyedStocks = [String]()
    
    static let shared = Survey()
    
    //
    func addingRating(rating: Int) {
        
    }
    
}
