//
//  Parse.swift
//  Stonx
//
//  Created by Angel Zambrano on 11/8/22.
//

import Foundation
import Parse

// Networking Service
// that gets the stock user has
// and the latest transaction of the user
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

    
    // check if the user is

    // will return the stock
    // - with the ticker, number of shares bought and the price at which it was purcharged
    // calls method to get the number
    //the new position
    struct Transaction {
        var stockPurchaased: Stock
        var new_position: Int
        var type: Bool
    }

    func getLatestTransaction(completion: @escaping (Result<Transaction,Error>) -> Void) {
        let query = PFQuery(className: user_transaction.object_name)
        query.whereKey(user_transaction.user, contains:  PFUser.current()!.objectId).order(byDescending: "createdAt")
        query.limit = 1

        // get the balance of the use r
        // we need to get the most recent balance from the user

        // this finds the latest transaction
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if let error = error {
                // The request failed
                print(error.localizedDescription)
            } else {

                // if the object exists in the user's database
                if let objects = objects {
                    let obj = objects[0]
                    let symbol = obj[user_transaction.ticker_symbol] as? String
                    let amount  = obj[user_transaction.quantity] as? Int
                    let price = obj[user_transaction.price] as? Double
                    let transaction = obj[user_transaction.purchase] as? Bool
                    // getting the values
                    if let tt = symbol, let amount = amount, let price = price, let transaction = transaction {

                        var transaction: Transaction = Transaction(stockPurchaased: Stock(ticker: tt, price: price, quantity: amount, ticker_fullName: ""), new_position: 0, type: transaction)

                        self.getTheLengthOfTheStock(transaction: transaction) { res in
                            switch res {
                            case .success(let transaction):
                                completion(.success(transaction))
                            case .failure(let error):
                                print(error.localizedDescription)
                            }
                        }

                    } else { // there was some type of error

                    }



                }
            }
        }
    }
    
    // gettig the total length of the stock
    func getTheLengthOfTheStock(transaction: Transaction,completion: @escaping (Result<Transaction,Error>) -> Void) {
        // update the transactions table
        // using the ticker symbol we get the
        let secondQuery = PFQuery(className: "user_transaction")
        secondQuery.whereKey("user", contains:  PFUser.current()!.objectId).whereKey("ticker_symbol", contains: transaction.stockPurchaased.ticker_symbol)

        secondQuery.findObjectsInBackground(){ objects, err in

            // if there is an error, we return the error


            var totalSold = 0
            var totalBought = 0
            if let objects = objects {
                for stock in objects {
                    let symbol = stock["ticker_symbol"] as? String
                    let price = stock["price"] as? Double
                    let quantity = stock["Quantity"] as? Int
                    let purschar = stock["purchase"] as? Bool


                    if let purchase = purschar, let quantity = quantity {
                        if purchase {
                            totalBought += quantity
                        } else {
                            totalSold += quantity
                        }
                    }

                }

            }

            var trans = transaction
            let new_pos = totalBought - totalSold
            trans.new_position = new_pos

            completion(.success(trans))

        }
    }

}




