//
//  StockCollectionViewCell.swift
//  Stonx
//
//  Created by Angel Zambrano on 10/28/22.
//

import UIKit

class StockTableViewCell: UITableViewCell {
   
    static let identifier = "StockTableViewCell"
    let stockLbl = UILabel()
    
    let fullStockName = UILabel()
    
    
    
    
    
    // TODO: use chart pod to create a chart
    let chart: UIView = UIView()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUPViews()
        setUpConstraints()
        
    }
    
    
    private func setUPViews() {
        contentView.addSubview(stockLbl)
        stockLbl.text = "APPL"
        stockLbl.font = FontConstants.boldFont
        stockLbl.translatesAutoresizingMaskIntoConstraints = false
        
        // setting up the name of the stock
        contentView.addSubview(fullStockName)
        fullStockName.text = "Apple Inc"
        fullStockName.font = FontConstants.cellSmallFont
        fullStockName.textColor = .systemGray
        fullStockName.translatesAutoresizingMaskIntoConstraints = false
        
        // setting up the chart
        contentView.addSubview(chart)
        chart.translatesAutoresizingMaskIntoConstraints = false
        chart.backgroundColor = .green
        
        // setting up the stock price
        contentView.addSubview(fullStockName)
        fullStockName.translatesAutoresizingMaskIntoConstraints = false
        fullStockName.text = "155.74"
        
        
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            stockLbl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            stockLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            fullStockName.topAnchor.constraint(equalTo: stockLbl.bottomAnchor, constant: 0),
            fullStockName.leadingAnchor.constraint(equalTo: stockLbl.leadingAnchor),
            fullStockName.widthAnchor.constraint(equalToConstant: contentView.frame.width/2)
        
        ])
        
        NSLayoutConstraint.activate([
            chart.bottomAnchor.constraint(equalTo: fullStockName.bottomAnchor),
            chart.leadingAnchor.constraint(equalTo: fullStockName.trailingAnchor, constant: 10),
            chart.heightAnchor.constraint(equalToConstant: 23),
            chart.widthAnchor.constraint(equalToConstant: 60)
        ])
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
