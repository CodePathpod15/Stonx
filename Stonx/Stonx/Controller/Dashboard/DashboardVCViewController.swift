//
//  DashboardVCViewController.swift
//  Stonx
//  Created by Angel Zambrano on 11/5/22.
//

import UIKit
import Parse
import Starscream



class DashboardVCViewController: UIViewController, RateDelegate, dashboardDelegate, TransactionDelegate {
    
    // transaction was completed
    // Conformance to TransactionDelegate
    func transac(of type: TransactionType) {
        let vc = TransactionSuccessfulViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
   
    func buyWasPressed(stock: Stock) {
        
        
        let vc = TransactionViewController(typeOfTransaction: .buy, ticker: stock.ticker_symbol, latestPrice: stock.price/Double(stock.quantity))
        vc.delegate = self
        let view = UINavigationController(rootViewController: vc)
        view.modalPresentationStyle = .fullScreen
        self.present(view, animated: true)
    }
    
    func sellWaspressed(stock: Stock) {
        
        let vc = TransactionViewController(typeOfTransaction: .sell, ticker: stock.ticker_symbol, latestPrice: stock.price/Double(stock.quantity), sharesOwned: stock.quantity)
        vc.delegate = self
        let view = UINavigationController(rootViewController: vc)
        view.modalPresentationStyle = .fullScreen
        self.present(view, animated: true)
    }
    
    
   
    

    // MARK: properties
    let scrollView = UIScrollView()
    let contentView = DashboardContentView(frame: .zero)
    var socket = WebSocket(request: .init(url: URL(string: "wss://stream.data.alpaca.markets/v2/iex")!))
    var recommendedStr = ""
    private var surveyedTicker = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        Survey.shared.canBeSurveyed { result in
            switch result {
            case .success(let res):
                if res {
                    self.getTheUserSurvey()
                } else {
                    print("cannt survey the user")
                }
                
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
        
        setUpViews()
        socket.delegate = self
        
    }
    
    
    
    
    func setUpViews() {
        view.addSubview(scrollView)
        title = "Dashboard"

        scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
  
        // add content view
        contentView.delegate = self
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
    
    // TODO: add to parse model
    @objc func  lightBulbWasPressed() {

        Survey.shared.getTheRecommendedTickerSymbol { result in
            switch result {
            case .success(let stock):
                print(stock)
                if let stock = stock {
                    let rstock = RecommendedStocks()
                    rstock.configure(rating: stock.rating ?? 1, tickerName: stock.ticker_symbol )
                    rstock.delegate = self
                    rstock.translatesAutoresizingMaskIntoConstraints = false
                    let currentWindow: UIWindow? = UIApplication.shared.keyWindow
                    currentWindow?.addSubview(rstock)

                    rstock.anchor(top: self.view.topAnchor, leading: self.view.leadingAnchor, bottom: self.view.bottomAnchor, trailing: self.view.trailingAnchor)
                } else {
                    self.showAlert(with: "There is currently no Stock to show ")
                }
                break
                
            case .failure(let error):
                self.showAlert(with: error.localizedDescription )
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
            self.totalPrice = 0

            for stock in ownedStocks {
                API.getLatestpriceUsingNewEndpoing(tickerSymbol: stock.ticker_symbol) { result in
                    switch result {
                    case .success(let lTrade):
                        let new_Stock_price = Double(stock.quantity) * lTrade!.trade!.p!
                        stock.price = round(new_Stock_price * 100) / 100.0
                        self.totalPrice += stock.price
                        stock.chagePercent = "x.x"
                        DispatchQueue.main.async {
                           self.contentView.configure(stocks: self.ownedStocks)
                           self.contentView.tableView.reloadData()
                            self.contentView.stockPrice.text = String(self.totalPrice.truncate(places: 2))
                            }
                    break
                    case .failure(let error):
                        print("error")
                    break
                    }
                }

            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initializetheTableview()
      
    }

    // initializing the tableview
    func initializetheTableview() {
        ParseModel.shared.getStockUserOwns { result in
            switch result {
            case .success(let items):
                if let items  = items {
                    self.ownedStocks = items
                }
                
                // make the connection after we have the stocks
                self.socket.connect()
                
                break
           case .failure(let error):
               // otherwise, print an error to the console
                print(error.localizedDescription ?? "error")
            }
        }
    }
 
    func getTheUserSurvey() {
        Survey.shared.surveyUser { rest in
            switch rest {
            case .success(let st):
                DispatchQueue.main.async {
                    if let st = st {
                        self.displayQuestionaireIfUserHasOwnedStock(with: st.ticker_symbol)
                    }
                }
                
            case .failure(let err):
                print(err)
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
        
        Survey.shared.completeSurvey(rating: number) { result in
            switch result {
            case .success(let res):
                print("it was saved")
            case .failure(let err):
                print("there was an error")
            }
        }
        
    }
    
    
}

