//
//  StocksVC.swift
//  Stonx
//
//  Created by Angel Zambrano on 11/25/22.
//

import UIKit
import Parse


class StocksVC: UIViewController {
    let scrollView = UIScrollView()
    let contentView = StkContentView(frame: .zero)
    var sect: String?
    var stockObject: PFObject?
    
    private let tradeButtonBottom: UIButton = {
        let floatingButton = UIButton(type: .system)
        floatingButton.setTitle("Trade", for: .normal)
        floatingButton.translatesAutoresizingMaskIntoConstraints = false
        floatingButton.backgroundColor = ColorConstants.green
        floatingButton.layer.cornerRadius = 25
        floatingButton.setTitleColor(UIColor.white, for: .normal)
        floatingButton.addTarget(self, action: #selector(tradeButtonWaspressed), for: .touchUpInside)
        return floatingButton
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setUpViews()
        getOwnedStocks()
        updateTheStocksCount()
        // Do any additional setup after loading the view.
    }
    
    var tickerName = ""


    
    
    init(stockInfo: BestMatch) {
        super.init(nibName: nil, bundle: nil)
        title = stockInfo.the1Symbol

        // initializes the ticket symbol
        contentView.configure(fullStockname: stockInfo.the2Name)
        

        tickerName = stockInfo.the1Symbol

        API.getStockAboutMe(tickerSymbol: tickerName) { result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    self.contentView.configure(aboutText: items?.stockAboutDescription ?? "")
                    self.contentView.configure(sector: items?.sector ?? " ")
 
                    
                    self.contentView.configure(eps: items?.eps ?? " ", peRatio: items?.peRatio ?? " ", marketCap: items?.marketCap ?? " ")
                }
            case .failure(let error):
                // otherwise, print an error to the console

                DispatchQueue.main.async {
                    switch error {
                    case APIERRORS.limit:
                        self.showAlert(with: "You have reached the five api calls per minute or 500 api calls per day")

                    default:
                        self.showAlert(with: error.localizedDescription)
                    }
                }
            }
        }

        // we update the volume,  price and percent change
        API.getLatestStockPrice(tickerSymbol: tickerName) { result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    // update the price and
                    
                    self.contentView.configure(price: items?.globalQuote.the05Price ?? "xx")
                    self.contentView.configure(volume: items?.globalQuote.the06Volume ?? "xx")

                    // so here we know we have items
                    if let items = items {
                        if items.globalQuote.the10ChangePercent.contains(where: { $0 == "-" }) {
                            self.contentView.pricePercentChange.textColor = ColorConstants.red
                        } else {
                            self.contentView.pricePercentChange.textColor = ColorConstants.green

                        }
                        self.contentView.configure(pricePercentChance: items.globalQuote.the10ChangePercent)
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    switch error {
                    case APIERRORS.limit:
                        self.showAlert(with: "You have reached the five api calls per minute or 500 api calls per day")

                    default:
                        self.showAlert(with: error.localizedDescription)
                    }
                }
            }
        }
//
        // query to check if this stock exists in the database
        let query = PFQuery(className: "stocks_booked")
        query.whereKey("ticker_symbol", equalTo: tickerName).whereKey("user", contains: PFUser.current()!.objectId)

        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if let error = error {
                // The request failed
                print(error.localizedDescription)
            } else {
                // if the object exists in the user's database
                if let objects = objects {
                    // if it doesnt exist in the database
                    // Can probably clean this up as well
                    if objects.isEmpty {
                        let rbutton = UIBarButtonItem(title: "favorite", style: .plain, target: self, action: #selector(self.addToWatchList))
                        let rightButton: UIBarButtonItem = rbutton
                        self.navigationItem.rightBarButtonItems = [rightButton]

                    } else {
                        let rbutton = UIBarButtonItem(title: "remove", style: .plain, target: self, action: #selector(self.addToWatchList))
                        let rightButton: UIBarButtonItem = rbutton
                        self.navigationItem.rightBarButtonItems = [rightButton]
                        self.stockObject = objects[0]
                    }
                }
            }
        }
    }
    
    var stocksOwned = [String: Int]()

    // gets all of the stocks that the user owns
    func getOwnedStocks() {
        let query = PFQuery(className: "user_transaction")
        query.whereKey("ticker_symbol", equalTo: tickerName).whereKey("user", contains: PFUser.current()!.objectId)
        do {
            var totalBought = 0
            var sold = 0
            let obj = try query.findObjects()
            for object in obj {
                let pur = object["purchase"] as? Bool
                let quantity = object["Quantity"] as? Int
                if pur == true {
                    totalBought += quantity!
                } else {
                    sold += quantity!
                }
            }
            stocksOwned[tickerName] = totalBought - sold
        } catch {
            print("error")
        }
    }
    
    @objc private func tradeButtonWaspressed() {
        let tradeView = TradeView()

        if stocksOwned[tickerName] != nil {
            let owned = stocksOwned[tickerName]!
            if owned == 0 {
                tradeView.sellButton.isEnabled = false
                tradeView.sellButton.backgroundColor = .systemGray
            }
        }

        tradeView.translatesAutoresizingMaskIntoConstraints = false
        tradeView.delegate = self

        let currentWindow: UIWindow? = UIApplication.shared.keyWindow
        currentWindow?.addSubview(tradeView)

        tradeView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
    }
    
    
    @objc func addToWatchList() {
        if navigationItem.rightBarButtonItem?.title == "favorite" {
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
                if success {
                    self.stockObject = watchlist
                    self.navigationItem.rightBarButtonItem?.title = "remove"
                } else {
                    self.showAlert(with: error?.localizedDescription ?? "Errror")
                }
            }

        } else { // delete object from
            if let stockObject = stockObject {
                let array = [stockObject]

                PFObject.deleteAll(inBackground: array) { succeeded, error in
                    if succeeded {
                        // The array of objects was successfully deleted.
                        self.navigationItem.rightBarButtonItem?.title = "favorite"
                    } else {
                        // There was an error. Check the errors localizedDescription.
                        self.showAlert(with: error?.localizedDescription ?? "Errror")
                    }
                }
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        
       

        
        view.addSubview(scrollView)
        title = "IBM"
        
        view.addSubview(scrollView)

        scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)

        // add content view
        scrollView.addSubview(contentView)
        contentView.delegate = self
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor)

        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
        
        view.addSubview(tradeButtonBottom)
        NSLayoutConstraint.activate([
            tradeButtonBottom.widthAnchor.constraint(equalToConstant: 150),
            tradeButtonBottom.heightAnchor.constraint(equalToConstant: 50),
            tradeButtonBottom.centerXAnchor.constraint(equalTo: view.trailingAnchor),
            tradeButtonBottom.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tradeButtonBottom.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20)
        ])
        
    }
  
    
}


extension StocksVC: TradingDelegate {
    func sell() {
        
        let vc = TransactionViewController(typeOfTransaction: .sell, ticker: tickerName, latestPrice: Double(contentView.stockPrice.text!)!, sharesOwned: stocksOwned[tickerName]!)

        vc.delegate = self
        let view = UINavigationController(rootViewController: vc)
        view.modalPresentationStyle = .fullScreen
        present(view, animated: true)
    }

    // enabling the buying of a stock
    func buy() {
        print("going into buy: ", tickerName)
        let vc = TransactionViewController(typeOfTransaction: .buy, ticker: tickerName, latestPrice: Double(contentView.stockPrice.text!)!)
        vc.delegate = self
        let view = UINavigationController(rootViewController: vc)
        view.modalPresentationStyle = .fullScreen
        present(view, animated: true)
    }
}

// implementation of transaction delegate
extension StocksVC: TransactionDelegate {
    func transac(of type: TransactionType, transaction: TransactionManager) {
        let vc = TransactionSuccessfulViewController(transaction: transaction)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}
