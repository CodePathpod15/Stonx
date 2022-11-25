//
//  GettingInfoIcons.swift
//  Stonx
//
//  Created by Angel Zambrano on 11/25/22.
//

import UIKit

extension StocksVC: MarketProtocol {
    func marketCapWasPressed() {
        let informationview = InformationView()
        informationview.configure(title: "Market Cap", caption: "Refers to how much a company is worth as determined by the stock market. It is defined as the total market value of all outstanding shares.")

        let currentWindow: UIWindow? = UIApplication.shared.keyWindow
        currentWindow?.addSubview(informationview)

        informationview.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
    }
    
    func volumeInfoWasPressed() {
        let informationview = InformationView()
        informationview.configure(title: "Volume", caption: "the number of shares traded in a particular stock, index, or other investment over a specific period of time")

        let currentWindow: UIWindow? = UIApplication.shared.keyWindow
        currentWindow?.addSubview(informationview)

        informationview.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
    }
    
    func PERatioWaspressed() {
        let informationview = InformationView()
        informationview.configure(title: "P/E", caption: "The P/E for a stock is computed by dividing the price of the stock by the company's annual earnings per share. It tells investors how much a company is worth.")

        let currentWindow: UIWindow? = UIApplication.shared.keyWindow
        currentWindow?.addSubview(informationview)

        informationview.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
    }
    
    func EPSWasPressed() {
        let informationview = InformationView()
        informationview.configure(title: "EPS", caption: "ernings per share (EPS) is calculated as a company's profit divided by the outstanding shares of its common stock.")
        
        let currentWindow: UIWindow? = UIApplication.shared.keyWindow
        currentWindow?.addSubview(informationview)

        informationview.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
    }
    
    func viewAllCommentsPressed() {
        let comments = CommentsViewController()
        comments.stockName = title!
        comments.title = "Discussion"
        show(comments, sender: self)
    }

    
    
}

