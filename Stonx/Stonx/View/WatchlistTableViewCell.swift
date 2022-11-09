//
//  WatchlistTableViewCell.swift
//  Stonx
//
//  Created by Angel Zambrano on 11/8/22.
//

import UIKit

class WatchlistTableViewCell: UITableViewCell {
    static let identifier = "WatchlistTableViewCell"
    private let stockLbl = UILabel()
    private var stockPrice = UILabel()
    

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
        contentView.addSubview(stockPrice)
        stockPrice.translatesAutoresizingMaskIntoConstraints = false
        stockPrice.font = FontConstants.boldFont
        stockPrice.textAlignment = .right
        stockPrice.text = "155.74"
    }
    
     func configure(stock: Stock) {
         self.stockPrice.text = String(stock.price)
         self.stockLbl.text = stock.ticker_symbol
    }
    
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            stockLbl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            stockLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stockPrice.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        stockLbl.setContentHuggingPriority(UILayoutPriority.init(rawValue: 252), for: .horizontal)
        
            
        // setting up constraints for stock price
        NSLayoutConstraint.activate([
            stockPrice.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stockPrice.centerYAnchor.constraint(equalTo: stockLbl.centerYAnchor)
        ])
            
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
