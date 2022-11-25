//
//  JsonCodable.swift
//  Stonx
//
//  Created by Angel Zambrano on 10/29/22.
//

import Foundation

// I useed these to convert our received json to an object
// for more info look into codable please or ask me

// this are the models used when doing the API requests
struct StockAbout: Codable {
    let symbol, assetType, name, stockAboutDescription: String?
    let cik, exchange, currency, country: String?
    let sector, industry, address, peRatio: String?
    let eps, revenuePerShareTTM, profitMargin, operatingMarginTTM: String?
    let returnOnAssetsTTM, returnOnEquityTTM, revenueTTM, grossProfitTTM: String?
    let dilutedEPSTTM, quarterlyEarningsGrowthYOY, quarterlyRevenueGrowthYOY, analystTargetPrice: String?
    let trailingPE, forwardPE: String?
    let marketCap: String?
    let Note: String?


    enum CodingKeys: String, CodingKey {
        case symbol = "Symbol"
        case assetType = "AssetType"
        case name = "Name"
        case stockAboutDescription = "Description"
        case cik = "CIK"
        case exchange = "Exchange"
        case currency = "Currency"
        case country = "Country"
        case sector = "Sector"
        case industry = "Industry"
        case address = "Address"
        case peRatio = "PERatio"
        case eps = "EPS"
        case revenuePerShareTTM = "RevenuePerShareTTM"
        case profitMargin = "ProfitMargin"
        case operatingMarginTTM = "OperatingMarginTTM"
        case returnOnAssetsTTM = "ReturnOnAssetsTTM"
        case returnOnEquityTTM = "ReturnOnEquityTTM"
        case revenueTTM = "RevenueTTM"
        case grossProfitTTM = "GrossProfitTTM"
        case dilutedEPSTTM = "DilutedEPSTTM"
        case quarterlyEarningsGrowthYOY = "QuarterlyEarningsGrowthYOY"
        case quarterlyRevenueGrowthYOY = "QuarterlyRevenueGrowthYOY"
        case analystTargetPrice = "AnalystTargetPrice"
        case trailingPE = "TrailingPE"
        case forwardPE = "ForwardPE"
        case marketCap = "MarketCapitalization"
        case Note = "Note"
    }
}


// MARK: - Welcome
struct Search: Codable {
    let bestMatches: [BestMatch]?
    let Note: String?
}

// MARK: - BestMatch
struct BestMatch: Codable {
    var the1Symbol, the2Name, the3Type, the4Region: String
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


// MARK: - StockData
struct StockData: Codable {
    let metaData: MetaData
    let timeSeries5Min: [String: TimeSeries5Min]

    enum CodingKeys: String, CodingKey {
        case metaData = "Meta Data"
        case timeSeries5Min = "Time Series (5min)"
    }
}

// MARK: - MetaData
struct MetaData: Codable {
    let the1Information, the2Symbol, the3LastRefreshed, the4Interval: String
    let the5OutputSize, the6TimeZone: String

    enum CodingKeys: String, CodingKey {
        case the1Information = "1. Information"
        case the2Symbol = "2. Symbol"
        case the3LastRefreshed = "3. Last Refreshed"
        case the4Interval = "4. Interval"
        case the5OutputSize = "5. Output Size"
        case the6TimeZone = "6. Time Zone"
    }
}

// MARK: - TimeSeries5Min
struct TimeSeries5Min: Codable {
    let the1Open, the2High, the3Low, the4Close: String
    let the5Volume: String

    enum CodingKeys: String, CodingKey {
        case the1Open = "1. open"
        case the2High = "2. high"
        case the3Low = "3. low"
        case the4Close = "4. close"
        case the5Volume = "5. volume"
    }
}



// MARK: - GlobalQuote
struct GlobalQuote: Codable {
    let globalQuote: GlobalQuoteClass
    let Note: String?

    enum CodingKeys: String, CodingKey {
        case globalQuote = "Global Quote"
        case Note = "Note"
    }
}

// MARK: - GlobalQuoteClass
struct GlobalQuoteClass: Codable {
    let the01Symbol, the02Open, the03High, the04Low: String
    let the05Price, the06Volume, the07LatestTradingDay, the08PreviousClose: String
    let the09Change, the10ChangePercent: String

    enum CodingKeys: String, CodingKey {
        case the01Symbol = "01. symbol"
        case the02Open = "02. open"
        case the03High = "03. high"
        case the04Low = "04. low"
        case the05Price = "05. price"
        case the06Volume = "06. volume"
        case the07LatestTradingDay = "07. latest trading day"
        case the08PreviousClose = "08. previous close"
        case the09Change = "09. change"
        case the10ChangePercent = "10. change percent"
    }
}


// MARK: - LatestTrade
struct LatestTrade: Codable {
    let symbol: String?
    let trade: Trade?
}

// MARK: - Trade
struct Trade: Codable {
    let t, x: String?
    let p: Double?
    let s: Int?
    let c: [String]?
    let i: Int?
    let z: String?
}
