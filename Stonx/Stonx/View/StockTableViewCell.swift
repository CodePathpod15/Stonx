//
//  StockCollectionViewCell.swift
//  Stonx
//
//  Created by Angel Zambrano on 10/28/22.
//

import Charts
import UIKit

// stock inside of watch list
class StockTableViewCell: UITableViewCell {
    static let identifier = "StockTableViewCell"
    let stockLbl = UILabel()
    
    let sharesOwned = UILabel()
    
    private var stockPrice = UILabel()
    
    private let priceChange = UILabel()
    
    // TODO: use chart pod to create a chart
    // TODO: add gradient
    
    func configure(with ticker: String, sharesOwned: Int, price: Double, percentChange: String = "0.0%") {
        if sharesOwned == 1 {
            self.sharesOwned.text = "\(sharesOwned) Share"
        } else {
            self.sharesOwned.text = "\(sharesOwned) Shares"
        }
        self.stockLbl.text = ticker
        
        self.stockPrice.text = String(price)
        self.priceChange.text = percentChange
    }
    
    
    
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUPViews()
        setUpConstraints()
        
        layoutMargins = UIEdgeInsets.zero
        preservesSuperviewLayoutMargins = false
           separatorInset = UIEdgeInsets.zero
         layoutMargins = UIEdgeInsets.zero
    }
    
    private func setUPViews() {
        contentView.addSubview(stockLbl)
        stockLbl.text = "APPL"
        stockLbl.font = FontConstants.boldFont
        stockLbl.translatesAutoresizingMaskIntoConstraints = false
        
        // setting up the name of the stock
        contentView.addSubview(sharesOwned)
        sharesOwned.text = "Apple Inc"
        sharesOwned.font = FontConstants.cellSmallFont
        sharesOwned.textColor = .systemGray
        sharesOwned.translatesAutoresizingMaskIntoConstraints = false
        
        // setting up the stock price
        contentView.addSubview(stockPrice)
        stockPrice.translatesAutoresizingMaskIntoConstraints = false
        stockPrice.font = FontConstants.boldFont
        stockPrice.textAlignment = .right
        stockPrice.text = "155.74"
        
        // setting up the price change
        contentView.addSubview(priceChange)
        priceChange.translatesAutoresizingMaskIntoConstraints = false
        priceChange.textAlignment = .right
        priceChange.font = FontConstants.cellSmallFont
        priceChange.text = "(2.49%)"
        priceChange.textColor = ColorConstants.green
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            stockLbl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            stockLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        ])
        stockLbl.setContentHuggingPriority(UILayoutPriority.init(rawValue: 252), for: .horizontal)
        
            
        NSLayoutConstraint.activate([
            sharesOwned.topAnchor.constraint(equalTo: stockLbl.bottomAnchor, constant: 0),
            sharesOwned.leadingAnchor.constraint(equalTo: stockLbl.leadingAnchor),
            sharesOwned.widthAnchor.constraint(equalToConstant: contentView.frame.width/2)
            
        ])
            
        // setting up constraints for stock price
        NSLayoutConstraint.activate([
            stockPrice.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stockPrice.centerYAnchor.constraint(equalTo: stockLbl.centerYAnchor)
        ])
            
        NSLayoutConstraint.activate([
            priceChange.trailingAnchor.constraint(equalTo: stockPrice.trailingAnchor),
            priceChange.centerYAnchor.constraint(equalTo: sharesOwned.centerYAnchor)
            
        ])
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

