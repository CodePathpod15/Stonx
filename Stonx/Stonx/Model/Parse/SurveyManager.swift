//
//  SurveyManager.swift
//  Stonx
//
//  Created by Angel Zambrano on 11/25/22.
//

import Foundation
import Parse


/// this is the model in charged of the survey
class Survey {
    static let shared = Survey()
    let recommendedStr: String? = nil
    var surveyedStocks = [String]()
    var stockBeingSurvyed: Stock? = nil

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

    // check if the person can be surveyed
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
                    completion(.success(true))
                }

                let diffInDays = Calendar.current.dateComponents([.day], from:  last_survey_Date!, to: Date()).day

                if diffInDays! >= 7 {
                    completion(.success(true))
                    return
                }

                completion(.success(false))
                return
            } else {
                // if user object doesnt exsit
                completion(.success(false))
                return
            }
        }
    }


    // check if they can be surveyed

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
                           return
                       }

                       // at this point the we know we have stocks we can survey
                       let stockToSuvey = stocks.first!


                       // save the the date of the survey
                       self.saveTheSurveyDateAndSurveyedStocks { res in
                           switch res {
                           case .failure(let err):
                               completion(.failure(err))
                           case .success(let re):
                               print("he")
                           }
                       }

                       // survey the user
                       self.stockBeingSurvyed = stockToSuvey
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
    // complete the survey
    func completeSurvey(rating: Int, completion: @escaping (Result<Bool?, Error>)-> Void) {

        guard let stockBeingSurvyed =  stockBeingSurvyed else {return}
        // this saves the ticker to the ratings table
        saveTickerRatingToRatingsTable(ticker: stockBeingSurvyed.ticker_symbol, rating: rating) { res in
            switch res {
            case .failure(let c):
                completion(.failure(c))
            case .success(let b):
                completion(.success(true))
            }
        }

        saveTheSurveyDateAndSurveyedStocks(ticker: stockBeingSurvyed.ticker_symbol) { res in
            switch res {
            case .failure(let c):
                completion(.failure(c))
            case .success(let b):
                completion(.success(true))
            }
        }

    }



    // saving the the content
    func saveTheSurveyDateAndSurveyedStocks(ticker: String? = nil, completion: @escaping (Result<Bool, Error>)-> Void) {
        let usr = PFUser.current()!
        usr["last_surveyed"] = Date()

        if let ticker = ticker {
            surveyedStocks.append(ticker)
            usr["Surveyed"] = surveyedStocks
        }

        usr.saveInBackground() { success, error in
            if success {
                // do nothing
                print("survey date was done")
                completion(.success(true))
            }

            if let error = error {
                completion(.failure(error))
            }

        }
    }




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

                return
            }
        }
    }

}
