//
//  DashboardVCViewController.swift
//  Stonx
//  Created by Angel Zambrano on 11/5/22.
//

import UIKit
import Parse

class DashboardVCViewController: UIViewController, RateDelegate {

    let scrollView = UIScrollView()
    let contentView = DashboardContentView(frame: .zero)
    var calledOnce = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializetheTableview()
        view.backgroundColor = .white
        getMostRecentInfoOfUser()
    
        view.addSubview(scrollView)
        title = "Dashboard"

        scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
  
        // add content view
        scrollView.addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor)
        // :-)
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
        
        
        // adding light bulb
        let rbutton = UIBarButtonItem(image: UIImage(systemName: "lightbulb.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(ColorConstants.green), landscapeImagePhone: nil, style: .done, target: self, action: #selector(lightBulbWasPressed))
        
        let rightButton: UIBarButtonItem = rbutton
        self.navigationItem.rightBarButtonItem = rightButton
   
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        initializetheTableview()
    }
    
    var recommendedStr = ""

    // TODO: add to parse model
    @objc func  lightBulbWasPressed() {

        let query = PFQuery(className: "ticker_rating")
        
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            
            var symbolToRating = [String: Int]()
            var symbolToAmountOfRatings = [String: Int]()
            
            var symtolToAvgRating = [String:Double]()
            
            if let objects = objects {
                
                if objects.isEmpty {
                    print("no ratings to show")
                    return
                }
                
                for object in objects {
                    let symbol = object["ticker_symbol"] as! String
                    let rating = object["rating"]  as! Int
                    symbolToRating[symbol, default: 0] += rating
                    symbolToAmountOfRatings[symbol, default: 0] += 1
                }
            
                var maxRating = 0
                var ticker = ""
                
                for (tik, rating) in symbolToRating {
                    symtolToAvgRating[tik] = Double(symbolToRating[tik]!) / Double(symbolToAmountOfRatings[tik]!)
                }
                
                let recommendedSymbol = symtolToAvgRating.max { $0.value < $1.value }
                self.recommendedStr = recommendedSymbol!.key

                if let recommendedSymbol = recommendedSymbol {
                    let rstock = RecommendedStocks()
                    rstock.configure(rating: recommendedSymbol.value, tickerName: recommendedSymbol.key)
                    rstock.delegate = self
                    rstock.translatesAutoresizingMaskIntoConstraints = false
                    
                    let currentWindow: UIWindow? = UIApplication.shared.keyWindow
                    currentWindow?.addSubview(rstock)
                    
                    rstock.anchor(top: self.view.topAnchor, leading: self.view.leadingAnchor, bottom: self.view.bottomAnchor, trailing: self.view.trailingAnchor)
                }
            }
            
            if error != nil {
                self.showAlert(with: error?.localizedDescription ?? "an error retrieving the reconmmended stock")
            }
            
        }

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
      
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
    var totalPrice = 0.0
    // Operation Queue (synchronize them)
    var ownedStocks = [Stock]() {
        didSet {
            for stock in ownedStocks {
                API.getLatestStockPrice2(tickerSymbol: stock.ticker_symbol) { result in
                    switch result {
                    case .success(let q):
                        let new_Stock_price = Double(stock.quantity) * Double(q!.globalQuote.the05Price)!
                        // rounding to two decimal places
                        stock.price = round(new_Stock_price * 100) / 100.0
                        self.totalPrice += stock.price
                        stock.chagePercent = q?.globalQuote.the10ChangePercent ?? "x.x"
                        // TODO: refactor this
                        DispatchQueue.main.async {
                            self.contentView.configure(stocks: self.ownedStocks)
                            self.contentView.tableView.reloadData()
                            self.contentView.stockPrice.text = String(self.totalPrice)
                        }
                        break
                    case .failure(let err):
                        print(err.localizedDescription)
                    }
                }
            }
        }
    }

    // initializing the tableview
    func initializetheTableview() {
        ParseModel.shared.getStockUserOwns { result in
            switch result {
            case .success(let items):
                if let items  = items {
                    self.ownedStocks = items
                }
//                self.contentView.configure(stocks: self.ownedStocks)
//                self.contentView.tableView.reloadData()
                break
                        
           case .failure(let error):
               // otherwise, print an error to the console
                print(error.localizedDescription ?? "error")
            }
        }
    }
    
    
        
    
    /// in this method we decide whether to survey the suer or not
     func surveyUser() {
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
                                return
                        }
                        
                        // at this point the we know we have stocks we can survey
                        let stockToSuvey = stocks.first!
                        self.saveTheSurveyDate()
                        self.surveyedTicker = stockToSuvey.ticker_symbol
                        self.displayQuestionaireIfUserHasOwnedStock(with: stockToSuvey.ticker_symbol)
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
    
    
    private var surveyedTicker = ""
    
    func saveTheSurveyDate() {
        let usr = PFUser.current()!
        usr["last_surveyed"] = Date()
        
        usr.saveInBackground() { success, error in
            if success {
                // do nothing
                print("survey date was done")
            } else {
                self.showAlert(with: error?.localizedDescription ?? "an error")
            }
        }
    }
    
    var surveyedStocks = [String]()
    
    
    func getMostRecentInfoOfUser() {
        let user  = PFUser.current()!
        user.fetchInBackground() {obj,err in
            if let obj = obj {
                let surveyed = obj.value(forKey: "Surveyed") as? [String]
                self.surveyedStocks = surveyed ?? []
                
                let last_survey_Date =  user["last_surveyed"] as? Date
                
                // no need to survey the user
                if last_survey_Date == nil {
                    self.surveyUser()
                }
  
                let diffInDays = Calendar.current.dateComponents([.day], from:  last_survey_Date!, to: Date()).day
                
                if diffInDays! >= 7 {
                    self.surveyUser()
                }
                
            } else {
                self.showAlert(with: "There was an error with your balance")
                
            }
        }
    }
    
    
    
    func displayQuestionaireIfUserHasOwnedStock(with recommended: String) {
        // we need to get all of the stocks the user
        
        let userGaveUsPermissons = true
        
        if userGaveUsPermissons {
            let rstock = RateTheStock()
            rstock.titleLbl.text = "Please rate your experience with \(recommended)"
            // user has owned any of his stocks for seven days
            
            rstock.translatesAutoresizingMaskIntoConstraints = false
            rstock.delegate = self
            
            let currentWindow: UIWindow? = UIApplication.shared.keyWindow
            currentWindow?.addSubview(rstock)
            
            rstock.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        
        }
        
    }
    
   
    // conforing to the procol
    // this is called whenever the user saves the rating
    // TODO: figure out how to insert unique elements
    func rate(number: Int) {
        surveyedStocks.append(surveyedTicker)
        
        let usr = PFUser.current()!
        usr["Surveyed"] = surveyedStocks
        
        usr.saveInBackground() { success, error in
            if success {
                // do nothing
                print("rating was saved in user ")
                self.saveTickerRating(ticker: self.surveyedTicker, rating: number)
            } else {
                self.showAlert(with: error?.localizedDescription ?? "an error")
            }
        }
    }
    
    // this sac
    func saveTickerRating(ticker: String, rating: Int) {
        // we perform the transaction
        let obj = PFObject(className: "ticker_rating")
        obj["user"] = PFUser.current()!
        obj["ticker_symbol"] = ticker
        obj["rating"] = rating
        
        // TODO: fix the
        obj.saveInBackground { success, error in
            if success {
                // do nothing
            } else {
                self.showAlert(with: error?.localizedDescription ?? "Errror")
                return
            }
        }
    }

}
