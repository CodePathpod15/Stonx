//
//  APi.swift
//  Stonx
//
//  Created by Angel Zambrano on 10/22/22.
//

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let bestMatches: [BestMatch]
}

// MARK: - BestMatch
struct BestMatch: Codable {
    let the1Symbol, the2Name, the3Type, the4Region: String
    let the5MarketOpen, the6MarketClose, the7Timezone, the8Currency: String
    let the9MatchScore: String

    enum CodingKeys: String, CodingKey {
        case the1Symbol = "1. symbol"
        case the2Name = "2. name"
        case the3Type = "3. type"
        case the4Region = "4. region"
        case the5MarketOpen = "5. marketOpen"
        case the6MarketClose = "6. marketClose"
        case the7Timezone = "7. timezone"
        case the8Currency = "8. currency"
        case the9MatchScore = "9. matchScore"
    }
}




// TODO: Angel and Sagar
struct API {
    let key  = "JPHF6VLB2O59XH8K"
    let baseUrl = "https://www.alphavantage.co"
    
    func search(sr: String) -> String? {
        //https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=apple&apikey=JPHF6VLB2O59XH8K
       
        
        
        return nil
    }
    
    
    
    
    
    static func search(searchingString: String, completion: @escaping (Result<Welcome?, Error>) -> Void) {
        guard var url  = URLComponents(string: "https://www.alphavantage.co/query") else {return}
        let queryItems = [
            URLQueryItem(name: "function", value: "SYMBOL_SEARCH"),
            URLQueryItem(name: "keywords", value: "apple"),
            URLQueryItem(name: "apikey", value: "JPHF6VLB2O59XH8K"),
        ]
        
        
        url.queryItems = queryItems
        
        var request = URLRequest(url: url.url!)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let searchResponse = try decoder.decode(Welcome.self, from: data) // gets the artists
                    completion(.success(searchResponse))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
        
    }
    
}
