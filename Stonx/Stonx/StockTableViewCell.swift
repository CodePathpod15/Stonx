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
    
    let fullName = UILabel()

    
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
        contentView.addSubview(fullName)
        fullName.text = "Apple Inc"
        fullName.font = FontConstants.cellSmallFont
        fullName.textColor = .systemGray
        fullName.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            stockLbl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            stockLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            fullName.topAnchor.constraint(equalTo: stockLbl.bottomAnchor, constant: 0),
            fullName.leadingAnchor.constraint(equalTo: stockLbl.leadingAnchor),
            fullName.widthAnchor.constraint(equalToConstant: contentView.frame.width/2)
        
        ])
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
