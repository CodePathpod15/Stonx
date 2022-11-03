//
//  TransactionViewController.swift
//  Stonx
//
//  Created by Angel Zambrano on 11/1/22.
//

import UIKit

//

enum TransactionType {
    case buy, sell
}

protocol TransactionDelegate: AnyObject {
    func transac(of type: TransactionType) // this is called when we press the button
}

// we can repurpose this view for both buying and cell
class TransactionViewController: UIViewController {
    
    weak var delegate: TransactionDelegate?

    let numberOfSharesToPurchase = UILabel()
    
    private let usernameTextfield = TextField()
    
    let tType: TransactionType = .buy
    
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
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(transactionButtonWaspressed), for: .touchUpInside)
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
    
    
    // MARK: add custom initializer
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Buy Apple"
        

        view.backgroundColor = ColorConstants.backgroundColor
        // Do any additional setup after loading the view.
        viewSetup()
        setupConstraints()
    }
    
    
    @objc func transactionButtonWaspressed() {
       
        self.dismiss(animated: true)
        self.dismiss(animated: true) { [self] in
            self.delegate?.transac(of: tType)
        }
    }
    
    private func viewSetup() {
        // set up for number of shares
        marketPricehorizontalSV.addArrangedSubview(marketPriceTitle)
        marketPricehorizontalSV.addArrangedSubview(marketPriceLbl)
        
        totalHorizontalSV.addArrangedSubview(totalLblTitle)
        totalHorizontalSV.addArrangedSubview(totalLbl)

        
        view.addSubview(verticalSV)
        view.addSubview(transactionButton)
        
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
        
        // keyboard set up
        setUpTextfield(textfield: usernameTextfield, defaultText: "# number of shares")
        usernameTextfield.keyboardType = .decimalPad
        usernameTextfield.heightAnchor.constraint(equalToConstant: 41).isActive = true
        
        usernameTextfield.becomeFirstResponder()
        
        // adding done button
        let add = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed))
        navigationItem.rightBarButtonItem = add

        
        
        
    }
    
    @objc func doneButtonPressed() {
        self.dismiss(animated: true)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
//            print(keyboardHeight)
            print("here: \(keyboardHeight + 30)")
            
            transactionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(keyboardHeight + 30)).isActive = true
            // adding the button
            
        }
    }
    
    private func setupConstraints() {
        // adding constraints to labels
        verticalSV.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom:nil, trailing: view.trailingAnchor, padding: .init(top: 50, left: 32, bottom: 0, right: 32))
       
        transactionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        transactionButton.widthAnchor.constraint(equalToConstant: 134).isActive = true

    }
    
    

}
