//
//  TransactionViewController.swift
//  Stonx
//
//  Created by Angel Zambrano on 11/1/22.
//

import UIKit

// we can repurpose this view for both buying and cell
class TransactionViewController: UIViewController {
    
    enum TransactionType {
        case buy, sell
    }

    let numberOfSharesToPurchase = UILabel()
    
    private let usernameTextfield = TextField()
    
    func setUpTextfield(textfield: UITextField, defaultText: String) {
        textfield.backgroundColor = ColorConstants.gray
        textfield.placeholder = defaultText
        textfield.layer.cornerRadius = 8
        textfield.layer.borderWidth = 1
        textfield.layer.borderColor = ColorConstants.darkerGray.cgColor
        textfield.font = UIFont.systemFont(ofSize: 16)
    }
    
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
        lbl.text = "$3.99"
        return lbl
    }()
    
    // the actual total price
    private let totalLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "$20.00"
        return lbl
    }()
    
    private let transactionButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = ColorConstants.green
        button.setTitle("Buy", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
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
        sv.spacing = 12
        return sv
    }()
    
    private let totalHorizontalSV: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Buy Apple"
        

        view.backgroundColor = ColorConstants.backgroundColor
        // Do any additional setup after loading the view.
        viewSetup()
        setupConstraints()
    }
    
    private func viewSetup() {
        // set up for number of shares
        marketPricehorizontalSV.addArrangedSubview(marketPriceTitle)
        marketPricehorizontalSV.addArrangedSubview(marketPriceLbl)
        
        totalHorizontalSV.addArrangedSubview(totalLblTitle)
        totalHorizontalSV.addArrangedSubview(totalLbl)

        
        view.addSubview(verticalSV)
        
        numberOfSharesToPurchase.text = "Number of Shares"
        [numberOfSharesToPurchase, usernameTextfield, marketPricehorizontalSV, totalHorizontalSV].forEach { v in
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
        
        setUpTextfield(textfield: usernameTextfield, defaultText: "# number of shares")
        
        usernameTextfield.becomeFirstResponder()
        
        
        
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
//            print(keyboardHeight)
            
            // adding the button
            
            
        }
    }
    
    private func setupConstraints() {
        // adding constraints to labels
        verticalSV.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom:nil, trailing: view.trailingAnchor, padding: .init(top: 50, left: 32, bottom: 0, right: 32))
        usernameTextfield.keyboardType = .decimalPad
        usernameTextfield.heightAnchor.constraint(equalToConstant: 41).isActive = true

    }
    
    

}
