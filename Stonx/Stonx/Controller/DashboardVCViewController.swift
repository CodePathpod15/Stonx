//
//  DashboardVCViewController.swift
//  Stonx
//
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
//        let rbutton = UIBarButtonItem(title: "Log out", style: .plain, target: self, action: #selector(lightBulbWasPressed))
        let rbutton = UIBarButtonItem(image: UIImage(systemName: "lightbulb.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(ColorConstants.green), landscapeImagePhone: nil, style: .done, target: self, action: #selector(lightBulbWasPressed))
        
        let rightButton: UIBarButtonItem = rbutton
        self.navigationItem.rightBarButtonItem = rightButton
        
    }
    
    var recommendedStr = ""
    
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

        
        // get the
        
        
    
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
      
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    // getting all of the stocks the user owns
    // TODO: refactor this
    func getAllOfTheStocksTheUserOwns() {

        let query = PFQuery(className: "user_transaction")
        query.whereKey("user", contains:  PFUser.current()!.objectId).order(byDescending: "createdAt")
        
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if let error = error {
                // The request failed
                print(error.localizedDescription)
            } else {
                print("printiung")
                // if the object exists in the user's database
                if let objects = objects {
                    
                    var tickerToOwn:[String: Int] = [String: Int]()
                    
                    var tickerToHash:[String: Date] = [:]
                    
                    if objects.isEmpty {
                        // no need to to anything
                        return
                    }
                    
                    for obj in objects {
                      
                        let tt = obj["ticker_symbol"] as? String
                        let amount  = obj["Quantity"] as? Int
                        let price = obj["price"] as? Double
                        let transaction = obj["purchase"] as! Bool
                       
                        // we had intitiliazing the ticker_to_hash
                        let diffInDays = Calendar.current.dateComponents([.day], from:  obj.createdAt!, to: Date()).day
                    
                        // give us the amount of days
                        
                        if transaction {
                            tickerToOwn[tt!, default: 0] += amount!
                        } else {
                            tickerToOwn[tt!, default: 0] -= amount!
                        }
                        
                        // check if the ticker exist in the hash table
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
                    
                    // remove all of the stocks where you
                    tickerToOwn.forEach { key, value in
                        if value == 0 {
                            tickerToOwn.removeValue(forKey: key)
                            tickerToHash.removeValue(forKey: key)
                        }
                    }
                    
                    self.surveyedStocks.forEach({
                        tickerToOwn.removeValue(forKey: $0)
                        tickerToHash.removeValue(forKey: $0)
                    })
                    
                    print(tickerToHash)
                    
                    // we now have all of the stocks that the user hasnt been surveyd own

                    
                    // here we check how many days the
                    for (key,val) in tickerToHash {
                        // we had intitiliazing the ticker_to_hash
                        let diffInDays = Calendar.current.dateComponents([.day], from:  val, to: Date()).day
                        if diffInDays! < 7 {
                            tickerToHash.removeValue(forKey: key)
                        }
                    }
                    
                    if tickerToHash.isEmpty {
                        return
                    }
                    
                    let  n = tickerToHash.first!
                    
                    
                    // save the last time questionaire was presented
                    self.saveTheSurveyDate()
                    self.surveyedTicker = n.key
                    self.displayQuestionaireIfUserHasOwnedStock(with: n.key)
                    
                    
                }
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
                    self.getAllOfTheStocksTheUserOwns()
                }
  
                let diffInDays = Calendar.current.dateComponents([.day], from:  last_survey_Date!, to: Date()).day
                
                if diffInDays! >= 7 {
                    self.getAllOfTheStocksTheUserOwns()
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
    // this is called when the user has rated the
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



