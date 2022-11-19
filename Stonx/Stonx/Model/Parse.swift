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




/// this is the model in charged of the survey
class Survey {
    static let shared = Survey()
    let recommendedStr: String? = nil
    var surveyedStocks = [String]()
    private var surveyedTicker = ""
    
    // returns nil if there is no symbol to recommend
     func getTheRecommendedTickerSymbol(completion: @escaping (Result<Stock?, Error>) -> Void) {
        let query = PFQuery(className: Ticker_rating.object_name)
        
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            
            // check if there is any error
            if let error = error {
                completion(.failure(error))
            }
           
            // this maps a symbol to the added overall added rating
            var symbolToRating = [String: Int]()
            // this maps the symbol to the amount of ratings the symbol has received.
            var symbolToAmountOfRatings = [String: Int]()
            
            // this is calculted by diving a symbolToRating[sym] / symbolToAmountOfRatings[symbol]
            var symtolToAvgRating = [String:Double]()
            
            if let objects = objects {
                
                if objects.isEmpty {
                    // returns an ampty array
                    completion(.success(nil))
                }
                
                
                for object in objects {
                    let symbol = object["ticker_symbol"] as! String
                    let rating = object["rating"]  as! Int
                    symbolToRating[symbol, default: 0] += rating
                    symbolToAmountOfRatings[symbol, default: 0] += 1
                }
            
                
                for (tik, rating) in symbolToRating {
                    symtolToAvgRating[tik] = Double(symbolToRating[tik]!) / Double(symbolToAmountOfRatings[tik]!)
                }
                
                // check if there is any recommended symbol to recommend
                // there is no symbol to recommend
                if symtolToAvgRating.isEmpty {
                    completion(.success(nil))
                }
                
                
                // this gets the max rating of them all
                let recommendedSymbol = symtolToAvgRating.max { $0.value < $1.value }
                
                if let recommendedSymbol = recommendedSymbol {
                    let stock = Stock(ticker: recommendedSymbol.key, price: 0, quantity: 0, ticker_fullName: "")
                    stock.rating = recommendedSymbol.value
                    completion(.success(stock))
                } else {
                    completion(.success(nil))
                }
            }
        }
    }
    
    
    // saves the rating to ticker rating table
    func saveTickerRatingToRatingsTable(ticker: String, rating: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        // we perform the transaction
        let obj = PFObject(className: "ticker_rating")
        obj["user"] = PFUser.current()!
        obj["ticker_symbol"] = ticker
        obj["rating"] = rating
        
        // TODO: fix the
        obj.saveInBackground { success, error in
            if let error = error {
                completion(.success(true))
            }
            
            if success {
                // do nothing
                completion(.success(true))
            } else {
                completion(.success(false))
//                self.showAlert(with: error?.localizedDescription ?? "Errror")
                return
            }
        }
    }
    
   

   
    
    
    
    
}


class Survey2 {
    var surveyedStocks = [String]()
    
    init() {
        
        
        
    }
    
    func canBeSurveyed(completion: @escaping (Result<Bool, Error>)-> Void)  {
        let user  = PFUser.current()!
        user.fetchInBackground() {obj,err in
            if let err = err {
                completion(.failure(err))
            }
            
            if let obj = obj {
                let surveyed = obj.value(forKey: "Surveyed") as? [String]
                self.surveyedStocks = surveyed ?? []
                
                let last_survey_Date =  user["last_surveyed"] as? Date
                
                // no need to survey the user
                if last_survey_Date == nil {
//                    self.surveyUser()
                    completion(.success(true))
                }
  
                let diffInDays = Calendar.current.dateComponents([.day], from:  last_survey_Date!, to: Date()).day
                
                if diffInDays! >= 7 {
//                    self.surveyUser()
                    completion(.success(true))
                }
                
                completion(.success(false))
            } else {
                // if user object doesnt exsit
                completion(.success(false))
            }
        }
        
        
    }
    
    
    
    
    func getSurveyEyedStock()->Stock? {
        
        canBeSurveyed { result in
            switch result {
            case .success(let reType):
                if reType {
                  
                }
            
            print("hehe")
            case .failure(let err):
            print("hehe")
            
            }
        }
        
        // check the last time the user was surveyed
        
        
        
        
        return nil
    }
    
    
    func surveyUser(completion: @escaping (Result<Stock?, Error>)-> Void) {
       var stocks = [Stock]()
        ParseModel.shared.getStockUserOwns { result in
           switch result {
               case .success(let items):
                   if let items = items {
                       stocks = items
                       
                       // we remove all of the stocks the use has been surveyed from the
                       self.surveyedStocks.forEach { ticker in
                           stocks.removeAll(where: {$0.ticker_symbol == ticker})
                       }
                       // we remove all of the stocks that the user has owned for less than 7 days
                       stocks.removeAll(where: {$0.daysOfOnwerShip < 7})
                       
                       // no need to survey the user if the stock is empty
                       if stocks.isEmpty {
                           completion(.success(nil))
                       }
                       
                       // at this point the we know we have stocks we can survey
                       let stockToSuvey = stocks.first!
                    
                       completion(.success(stockToSuvey))
                   } else {
                       // it is nil so we return
                       // no need to survey the user if they dont own any stock
                       return
                       
                   }
             case .failure(let error):
                 // otherwise, print an error to the console
                 print(error)
             }
       }
        
   }
    
    
    
    
}
