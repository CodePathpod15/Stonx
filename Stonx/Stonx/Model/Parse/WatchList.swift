//
//  WatchList.swift
//  Stonx
//
//  Created by Angel Zambrano on 11/25/22.
//

import Foundation
import Parse

//
// networking layer for the watchlist
class WatchList {
    
    static let shared  = WatchList()
    var stockObject: PFObject?
    
    
    
    func gettingUserWatchlist(bysector: String? = nil, completion: @escaping (Result<[Stock]?, Error>) -> Void) {
 
         var stocksUserOwns = [Stock]()
         let query = PFQuery(className: WatchlistConstants.object_name)
         query.whereKey(WatchlistConstants.user, contains:  PFUser.current()!.objectId)
         if let bysector = bysector {
             query.whereKey(WatchlistConstants.sector, contains:  bysector)
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
                     let sector = object[WatchlistConstants.sector] as? String
                     let ticker_symbol = object[WatchlistConstants.ticker_symbol] as? String
 
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
    
    
    // checking if the user has watchedlisted the stock
    func stockisWatchlisted(tickerName: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        let query = PFQuery(className: "stocks_booked")
        query.whereKey("ticker_symbol", equalTo: tickerName).whereKey("user", contains: PFUser.current()!.objectId)

        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if let error = error {
                // The request failed
                completion(.failure(error))
            } else {
                // if the object exists in the user's database
                if let objects = objects {
                    // if it doesnt exist in the database
                    // Can probably clean this up as well
                    if objects.isEmpty {
                        completion(.success(false))
                    } else {
                        completion(.success(true))
                        self.stockObject = objects[0]
                    }
                }
            }
        }

        
    }
    
    // watchlisting a stock
    func addToWatchlist(tickerName: String, sect: String?, completion: @escaping (Result<Bool, Error>) -> Void) {
        let watchlist = PFObject(className: "stocks_booked")
        // saves the ticker name
        watchlist["ticker_symbol"] = tickerName
        // saves it to the current user
        watchlist["user"] = PFUser.current()!

        // adding the sector
        if let sect = sect {
            watchlist["sector"] = sect
        }

        // saves the sector
        watchlist.saveInBackground { success, error in
            
            if let error = error {
                completion(.failure(error))
            }
            
            if success {
                self.stockObject = watchlist
                completion(.success(true))
            } else {
                completion(.success(false))
            }
    }

}
    // removing from watchlist
    func removeFromWatchlist(completion: @escaping (Result<Bool, Error>) -> Void) {
        if let stockObject = stockObject {
            let array = [stockObject]

            PFObject.deleteAll(inBackground: array) { succeeded, error in
                
                if let error = error {
                    completion(.failure(error))
                }

                if succeeded {
                    completion(.success(true))
                } else {
                    completion(.success(true))
                }
                
                
            }
        }
    }
}
