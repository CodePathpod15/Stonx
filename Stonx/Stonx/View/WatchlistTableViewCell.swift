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
        
    }
    
     func configure(stock: Stock) {
         self.stockLbl.text = stock.ticker_symbol
    }
    
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            stockLbl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            stockLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stockLbl.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        stockLbl.setContentHuggingPriority(UILayoutPriority.init(rawValue: 252), for: .horizontal)
        
            
        // setting up constraints for stock price
 
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
