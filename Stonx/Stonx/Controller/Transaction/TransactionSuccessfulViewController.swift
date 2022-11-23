//
//  TransactionSuccessfulViewController.swift
//  Stonx
//
//  Created by Angel Zambrano on 11/2/22.
//

import UIKit
import Lottie
import Parse


class TransactionSuccessfulViewController: UIViewController {

    // MARK: properties
    
    var animationView: AnimationView?

   private let whiteVIew = UIView()
    private let label: UILabel = {
       let titleLbl = UILabel()
        titleLbl.text = "APPL Purchased"
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        titleLbl.textColor = .white
        titleLbl.font = FontConstants.boldFont
        return titleLbl
    }()
    
    private  let numberOfSharesBoughtLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "1"
        lbl.textAlignment = .center
        lbl.font = FontConstants.regularFont
        return lbl
    }()
    
    private let numberOfSharesBoughtTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "Shares bought"
        lbl.font = FontConstants.regularFont
        lbl.textColor = .gray
        lbl.textAlignment = .center
        return lbl
    }()
    
    
    // credit left
    private let creditLeft: UILabel = {
        let lbl = UILabel()
        lbl.text = "Total Credit"
        lbl.textAlignment = .center
        lbl.font = FontConstants.regularFont
        lbl.textColor = .gray
        return lbl
    }()
    
    private let creditLeftTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "$3.00"
        lbl.textAlignment = .center
        return lbl
    }()
    
    private let creditVerticalSV: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        return sv
    }()
    
    let vsharesStackview: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        return sv
    }()
    
    let hSV: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 25 // or 35
        return sv
    }()
    
    
    // the set up for the new position
    private let newPositionTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "New Positon"
        lbl.textColor = .gray
        lbl.font = FontConstants.regularFont
        return lbl
    }()
    
    //
    private let newPositionNumber: UILabel = {
        let lbl = UILabel()
        lbl.text = "0 Shares"
        lbl.font = FontConstants.regularFont
        return lbl
    }()
    
    let positionHStack: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        return sv
    }()
    
    // the set up for the price per share
    let priceperShareTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "price Per Share"
        lbl.textColor = .gray
        lbl.font = FontConstants.regularFont
        return lbl

    }()
    
    // set the price per share
    let priceperShare: UILabel = {
            let lbl = UILabel()
            lbl.text = "0 Shares"
        lbl.font = FontConstants.regularFont
            return lbl
    }()
    
    let pricePerShareSV: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fill

        return sv
    }()
    
    // vertical stack for price per share and position
    let verticalSVForPricePerShareAndPosition: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 6
        return sv
    }()
    
    let button: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Done", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = ColorConstants.green
        btn.addTarget(self, action: #selector(buttonWasPressed), for: .touchUpInside)
        btn.layer.cornerRadius = 16
        return btn
    }()
  
    
   
        
    // MARK: Initializers
    init() {
        super.init(nibName: nil, bundle: nil)
        
    }
    
    var transaction: TransactionManager = TransactionManager()
    
    init(transaction: TransactionManager) {
        super.init(nibName: nil, bundle: nil)
        self.transaction = transaction
    }
    
    
    // we can ignore this
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animationView = .init(name: "90469-confetti")
        
        view.addSubview(animationView!)
       
        view.backgroundColor = ColorConstants.green
        viewSetUp()
        setUpContraints()
        
        animationView?.translatesAutoresizingMaskIntoConstraints = false
        animationView?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        animationView?.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        animationView?.widthAnchor.constraint(equalToConstant: 1000).isActive = true
        animationView?.heightAnchor.constraint(equalToConstant: 1000).isActive = true
        

        animationView?.contentMode = .scaleAspectFit
        animationView?.animationSpeed = 1.5
        animationView?.play()
        
        
        
        
        // TODO:
        // check the transaction type
        let query = PFQuery(className: "user_transaction")
        query.whereKey("user", contains:  PFUser.current()!.objectId).order(byDescending: "createdAt")
        query.limit = 1
        
        // get the balance of the use r
        // we need to get the most recent balance from the user
        
        if let transactionBalance = transaction.usrBalance {
            print("balance: \(transactionBalance.truncate(places: 2))")
            creditLeftTitle.text = String(transactionBalance.truncate(places: 2))
        } else {
            self.showAlert(with: "there was an error retrieving your balance")
        }
        

        
        ParseModel.shared.getLatestTransaction { result in
            switch result {
            case .success(let transaction):
        
                
                print("stock symbol",transaction.stockPurchaased.ticker_symbol)
                print("stock price",transaction.stockPurchaased.price)
                print("stock quantity",transaction.stockPurchaased.quantity)
                print("type of transaction",transaction.type)
                print("new position", transaction.new_position)
                
                var type: String = transaction.type ? "Purchased" : "Sold"
                var type2: String = transaction.type ? "bought" : "Sold"
              
                self.label.text = "\(transaction.stockPurchaased.ticker_symbol) \(type)"
                
                
                
                self.numberOfSharesBoughtLbl.text = "\(String(transaction.stockPurchaased.quantity))"
                self.priceperShare.text = "\(String(transaction.stockPurchaased.price.truncate(places: 4)))"
//                self.numberOfSharesBoughtTitle.text = "Shares \(transaction.stockPurchaased.quantity)"
                self.newPositionNumber.text = "\(transaction.new_position)"
                
                
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        


    }
    
    private func viewSetUp() {
        view.addSubview(label)

        whiteVIew.backgroundColor = .white
        whiteVIew.layer.cornerRadius = 8
        view.addSubview(whiteVIew)
        
        vsharesStackview.addArrangedSubview(numberOfSharesBoughtLbl)
        vsharesStackview.addArrangedSubview(numberOfSharesBoughtTitle)
        creditVerticalSV.addArrangedSubview(creditLeftTitle)
        creditVerticalSV.addArrangedSubview(creditLeft)
       

        whiteVIew.addSubview(hSV)
        hSV.addArrangedSubview(vsharesStackview)
        hSV.addArrangedSubview(creditVerticalSV)
        hSV.translatesAutoresizingMaskIntoConstraints = false
        
        whiteVIew.addSubview(verticalSVForPricePerShareAndPosition)
        verticalSVForPricePerShareAndPosition.translatesAutoresizingMaskIntoConstraints = false
        
        // adding the horizontal position stackview
        positionHStack.translatesAutoresizingMaskIntoConstraints = false
        positionHStack.addArrangedSubview(newPositionTitle)
        positionHStack.addArrangedSubview(newPositionNumber)
        verticalSVForPricePerShareAndPosition.addArrangedSubview(positionHStack)

        
        pricePerShareSV.translatesAutoresizingMaskIntoConstraints = false
        pricePerShareSV.addArrangedSubview(priceperShareTitle)
        pricePerShareSV.addArrangedSubview(priceperShare)
        verticalSVForPricePerShareAndPosition.addArrangedSubview(pricePerShareSV)
        
        whiteVIew.addSubview(button)
       
    }
    
    
    private func setUpContraints() {
        
        
        // setting up the white view
        whiteVIew.anchor(top: label.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 17, left: 0, bottom: 0, right: 0) ,size: .init(width: 259, height: 314))
 
        whiteVIew.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        whiteVIew.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        label.centerXAnchor.constraint(equalTo: whiteVIew.centerXAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: whiteVIew.topAnchor, constant: -16).isActive = true

        
        hSV.centerXAnchor.constraint(equalTo: whiteVIew.centerXAnchor).isActive = true
        hSV.topAnchor.constraint(equalTo: whiteVIew.topAnchor, constant: 50).isActive = true
        
        // 31
        NSLayoutConstraint.activate([
            verticalSVForPricePerShareAndPosition.leadingAnchor.constraint(equalTo: whiteVIew.leadingAnchor, constant: 10),
            verticalSVForPricePerShareAndPosition.trailingAnchor.constraint(equalTo: whiteVIew.trailingAnchor, constant: -10),
            verticalSVForPricePerShareAndPosition.topAnchor.constraint(equalTo: hSV.bottomAnchor, constant: 35)
            
        ])
    
        button.anchor(top:verticalSVForPricePerShareAndPosition.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 35, left: 0, bottom: 44, right: 0), size: .init(width: 150, height: 30))

        button.centerXAnchor.constraint(equalTo: whiteVIew.centerXAnchor).isActive = true

    }
    
    
    // MARK: IBactions
    
    @objc func buttonWasPressed() {
        self.dismiss(animated: true, completion: nil)
    }


}



