//
//  APi.swift
//  Stonx
//
//  Created by Angel Zambrano on 10/22/22.
//

import Foundation



// MARK: all the ticker symbols have to be either all upper case or all lower case


// TODO: refactor this
struct FunctionConstants {
    static let global =  "GLOBAL_QUOTE"
    static let overview = "OVERVIEW"
    static let time_series = "TIME_SERIES_INTRADAY"
}

enum APIERRORS: Error {
    case limit
}

// another API Key
// LNPPEUV5LWE3TLLZ (5 API Calls per minute)
// TODO: refactor this into one function
// made different methods for simplicity
/// this API is in charge of fetching data from the stocks API
/// for more info: https://www.alphavantage.co/documentation/#symbolsearch
struct API {
    
    private static let key  = "JPHF6VLB2O59XH8K"
    /// this is our base url
    let baseUrl = "https://www.alphavantage.co/query"
    
    // get the latest price of the stock
    static func getLatestStockPrice(tickerSymbol:String, completion: @escaping (Result<GlobalQuote?, Error>) -> Void) {
        guard var url  = URLComponents(string: "https://www.alphavantage.co/query") else {return}
        
        let queryItems = [
            URLQueryItem(name: "function", value: "GLOBAL_QUOTE"),
            URLQueryItem(name: "symbol", value: tickerSymbol),
            URLQueryItem(name: "apikey", value: "ETTY470QGQK5ZLSQ")
        ]
        
        url.queryItems = queryItems
        
        var request = URLRequest(url: url.url!)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let searchResponse = try decoder.decode(GlobalQuote.self, from: data) // gets the artists
                    
                    // added the error for when we are given an error
                    if searchResponse.Note != nil {
                        completion(.failure(APIERRORS.limit))
                    }
                    
                    completion(.success(searchResponse))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    
    static func getLatestpriceUsingNewEndpoing(tickerSymbol: String, completion: @escaping (Result<LatestTrade?, Error>) -> Void) {
        
        guard var url2 = URLComponents(string: "https://data.alpaca.markets/v2/stocks/\(tickerSymbol)/trades/latest") else {return} // creates a component of the url
        var request = URLRequest(url: url2.url!)
        request.httpMethod = "GET"
        request.addValue("PKAQG4B3QL3XEQ97F36G", forHTTPHeaderField: "Apca-Api-Key-Id")
        request.addValue("MGBfl24lkc9zIKMgtLTy5BhzKDooh8wXKFMIewqp", forHTTPHeaderField: "Apca-Api-Secret-Key")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let searchResponse = try decoder.decode(LatestTrade.self, from: data) // gets the artists
                    completion(.success(searchResponse))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
        
    }
  
    
    
    // gives you the description, EPS,PERatio, and sector.
    // https://www.alphavantage.co/query?function=OVERVIEW&symbol=IBM&apikey=JPHF6VLB2O59XH8K .. try this link in your browser
    static func getStockAboutMe(tickerSymbol:String, completion: @escaping (Result<StockAbout?, Error>) -> Void) {
        guard var url  = URLComponents(string: "https://www.alphavantage.co/query") else {return}
        
        let queryItems = [
            URLQueryItem(name: "function", value: "OVERVIEW"),
            URLQueryItem(name: "symbol", value: tickerSymbol),
            URLQueryItem(name: "apikey", value: "838A10HD6X0SVMMM")
        ]
        
        url.queryItems = queryItems
        
        var request = URLRequest(url: url.url!)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let searchResponse = try decoder.decode(StockAbout.self, from: data) // gets the artists
                    
                    if searchResponse.Note != nil {
                        completion(.failure(APIERRORS.limit))
                    }
                    
                    completion(.success(searchResponse))
                } catch {

                    completion(.failure(error))
                }
            }
        }
        
        task.resume()

    }
    
    
    /// searches through the api using the a string
    static func search(searchingString: String, completion: @escaping (Result<Search?, Error>) -> Void) {
        guard var url  = URLComponents(string: "https://www.alphavantage.co/query") else {return}
    
        let queryItems = [
            URLQueryItem(name: "function", value: "SYMBOL_SEARCH"),
            URLQueryItem(name: "keywords", value: searchingString),
            URLQueryItem(name: "apikey", value: key),
        ]

        url.queryItems = queryItems
        var request = URLRequest(url: url.url!)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let searchResponse = try decoder.decode(Search.self, from: data) // gets the artists
                    
                    // the note happens whenever the user
                    if searchResponse.Note != nil  {
                        completion(.failure(APIERRORS.limit))
                    }
    
                    completion(.success(searchResponse))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
        
    }
    
}



