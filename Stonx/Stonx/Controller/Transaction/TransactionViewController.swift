//
//  TransactionViewController.swift
//  Stonx
//
//  Created by Angel Zambrano on 11/1/22.
//

import UIKit
import Parse


enum TransactionType {
    case buy, sell
}

protocol TransactionDelegate: AnyObject {
    func transac(of type: TransactionType) // this is called when we press the button
}


class TransactionViewController: UIViewController {
    
    weak var delegate: TransactionDelegate?

    let numberOfSharesToPurchase = UILabel()
    
    private let numberOfSharesTextfield = TextField()
    
    let tType: TransactionType = .buy
    
    // title of the marketprice
    private let marketPriceTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "Market Price: "
        return lbl
    }()
    
    // title of the totalLblTitle
    private let totalLblTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "total: "
        return lbl
    }()
    
    // the actual market price value
    private let marketPriceLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "$0.00"
        return lbl
    }()
    
    // the actual total price
    private let totalLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "$00.00"
        return lbl
    }()
    
    // purchasing power title label
    private let purchasingTiteLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Purchasing Power"
        return lbl
    }()
    

    private let purchasingPower: UILabel = {
        let lbl = UILabel()
        lbl.text = "0.00$"
        return lbl
    }()
    
    private let stockOwnerShiptitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "Stock Ownership:"
        return lbl
    }()
    
    private let stockOwnerShip: UILabel = {
        let lbl = UILabel()
        lbl.text = "0"
        return lbl
    }()
    
    private let stockOwnerSV: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.spacing = 12
        return sv
    }()
    
    
    private let transactionButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = ColorConstants.green
        button.setTitle("Buy", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 6
        return button
    }()
    
    func createLbl(with str: String)-> UILabel {
        let lbl = UILabel()
        lbl.text = "$20.00"
        return lbl
    }
    
    // vertical stackview
    private let verticalSV: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.spacing = 12
        return sv
        
    }()
    
    private let marketPricehorizontalSV: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.spacing = 0
        return sv
    }()
    
    private let totalHorizontalSV: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let purchasingPowerHorizontalSV: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.spacing = 12
        return sv
    }()
    
    /// defines the type of transaction the user will perform
    var transacType: TransactionType? =  nil
    // sets the initial price to
    var latestPrice: Double = 0.0
    var usrBalance: Double = 0.0
    
    private var tickerSym: String? = nil
    
    // this contains the number being sold
    private var sharesOwned = 0
    
    
    // this in charged of performing transactions
    var transactionManger = TransactionManager()
    
    
    // Would recommend using this initializer since it contains the shares owned
    // MARK: Initializers
    init() {
        super.init(nibName: nil, bundle: nil)
        
    }
    init(typeOfTransaction: TransactionType, ticker: String, latestPrice: Double, sharesOwned: Int) {
        super.init(nibName: nil, bundle: nil)
        
    
        
        self.tickerSym = ticker
        self.transacType = typeOfTransaction
        self.latestPrice = latestPrice
        
        switch transacType {
        case .buy:
            self.title = "buying \(ticker)"
            self.transactionButton.addTarget(self, action: #selector(transactionButtonWaspressed), for: .touchUpInside)
            break
        case .sell:
            self.title = "selling \(ticker)"
            self.stockOwnerShip.text = "\(sharesOwned)"
            self.stockOwnerSV.addArrangedSubview(stockOwnerShiptitle)
            self.stockOwnerSV.addArrangedSubview(stockOwnerShip)
            self.transactionButton.addTarget(self, action: #selector(transactionButtonWaspressed), for: .touchUpInside)
            self.sharesOwned = sharesOwned
            break
        case .none:
            break
        }
    }
    
    
    init(typeOfTransaction: TransactionType, ticker: String, latestPrice: Double) {
        super.init(nibName: nil, bundle: nil)
        
        self.tickerSym = ticker
        self.transacType = typeOfTransaction
        self.latestPrice = latestPrice
        switch transacType {
        case .buy:
            self.title = "buying \(ticker)"
            self.transactionButton.addTarget(self, action: #selector(transactionButtonWaspressed), for: .touchUpInside)
            break
        case .sell:
            self.title = "selling \(ticker)"
            self.stockOwnerSV.addArrangedSubview(stockOwnerShiptitle)
            self.stockOwnerSV.addArrangedSubview(stockOwnerShip)
            self.transactionButton.addTarget(self, action: #selector(transactionButtonWaspressed), for: .touchUpInside)
            break
        case .none:
            break
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorConstants.backgroundColor
        // Do any additional setup after loading the view.
        viewSetup()
        setupConstraints()
    }
    
    
    
    
    func isValidInteger(str: String) -> Bool {
       
        if !str.isInt {
            return false
        }
        
        let amount = Int(str)!

        if amount == 0 || amount < 0 {
            return false
        }
        
        return true
    }
    
    
    private func viewSetup() {
        
        // set up for number of shares
        marketPricehorizontalSV.addArrangedSubview(marketPriceTitle)
        marketPricehorizontalSV.addArrangedSubview(marketPriceLbl)
        
        totalHorizontalSV.addArrangedSubview(totalLblTitle)
        totalHorizontalSV.addArrangedSubview(totalLbl)
        
        purchasingPowerHorizontalSV.addArrangedSubview(purchasingTiteLbl)
        purchasingPowerHorizontalSV.addArrangedSubview(purchasingPower)

        view.addSubview(verticalSV)
        view.addSubview(transactionButton)
        
        numberOfSharesToPurchase.text = "Number of Shares"
        
        // adding the subviews into the vertical SV
        [numberOfSharesToPurchase, numberOfSharesTextfield, stockOwnerSV, purchasingPowerHorizontalSV,marketPricehorizontalSV, totalHorizontalSV].forEach { v in
            v.translatesAutoresizingMaskIntoConstraints = false
            verticalSV.addArrangedSubview(v)
        }
        
        // adding observer to be able to get the size of the keyboard
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        // keyboard set up
        setUpTextfield(textfield: numberOfSharesTextfield, defaultText: "# number of shares")
        numberOfSharesTextfield.keyboardType = .decimalPad
        numberOfSharesTextfield.text = "1"
        numberOfSharesTextfield.addTarget(self, action: #selector(didEnterTextInsideOfTextfield), for: .allEditingEvents)
        
        numberOfSharesTextfield.heightAnchor.constraint(equalToConstant: 41).isActive = true
        
        numberOfSharesTextfield.becomeFirstResponder()
        
        // adding done button
        let add = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed))
        navigationItem.rightBarButtonItem = add
        
        // set the title of the trasaction button
        if transacType == .buy {
            transactionButton.setTitle("Buy", for: .normal)
        } else if transacType == .sell {
            transactionButton.setTitle("Sell", for: .normal)
        }
        
        transactionManger.unpdateUsrBalance { res in
            switch res {
            case .success(let usrBalance):
                self.purchasingPower.text = String(usrBalance ?? 0.0)
            case .failure(let err):
                self.showAlert(with: "failed to get usr balance")
            }
        }
        
        self.marketPriceLbl.text = ("$\(latestPrice)")
    
    }
    
    private func setupConstraints() {
        // adding constraints to labels
        verticalSV.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom:nil, trailing: view.trailingAnchor, padding: .init(top: 50, left: 32, bottom: 0, right: 32))
       
        transactionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        transactionButton.widthAnchor.constraint(equalToConstant: 134).isActive = true

    }
    
    
    
    // helper method to set up the the textfield
    func setUpTextfield(textfield: UITextField, defaultText: String) {
        textfield.backgroundColor = ColorConstants.gray
        textfield.placeholder = defaultText
        textfield.layer.cornerRadius = 8
        textfield.layer.borderWidth = 1
        textfield.layer.borderColor = ColorConstants.darkerGray.cgColor
        textfield.font = UIFont.systemFont(ofSize: 16)
    }
    
    
    // updates the textfirldds
    @objc func didEnterTextInsideOfTextfield() {
        if let numberStr = numberOfSharesTextfield.text {
            if numberStr.isInt {
                totalLbl.text = "$\(latestPrice * Double(numberStr)!)"
            }  else {
                totalLbl.text = ""
            }
            
        }
   
        
    }
    
    @objc func doneButtonPressed() {
        self.dismiss(animated: true)
    }

    // this handles when the keyboard is being shown
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height

            transactionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(keyboardHeight + 30)).isActive = true
            // adding the button
            
        }
    }
    
    // this will check if the usr is even able to buy the stock
    // if the usr has enough balance the stock will be purchased, else error will be thrownedspot
    @objc func transactionButtonWaspressed() {
       
        if let numberStr = numberOfSharesTextfield.text {
            // we check if the textfield str is an integer
            if !numberStr.isInt {
                
                showAlert(with: "Please enter a valid number")
                return
                } else {
                
                // check if the user has enough purchasing power
                    if self.transactionManger.usrBalance ?? 0.0 < (latestPrice * Double(numberStr)!) {
                    showAlert(with: "No enough purchasing power")
                    return
                }
                // we perform the transaction

                
                if transacType == .buy {
                    transactionManger.createTransaction(latestPrice: latestPrice, tickerSym: tickerSym!, number: Int(numberStr)!, type: .buy)
                    
                } else if transacType == .sell {
                    transactionManger.createTransaction(latestPrice: latestPrice, tickerSym: tickerSym!, number: Int(numberStr)!, type: .sell)
                } else {
                    showAlert(with: "there is an error!!!")
                    return
                }
        
        
                self.dismiss(animated: true) { [self] in
                    self.delegate?.transac(of: tType)
                }
        
        
            }
            
        }
    }
       

}

// extension to truncate the decimal place
extension Double {
    func truncate(places : Int)-> Double {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
}
