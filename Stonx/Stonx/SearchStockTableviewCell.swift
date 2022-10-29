//
//  SearchStockTableviewCell.swift
//  Stonx
//
//  Created by Angel Zambrano on 10/28/22.
//

import UIKit


// this is the tableview cell that contains no chart
class SearchStockTableviewCell: UITableViewCell {

    
    // MARK: properties
    
    static let identifier = "SearchStockTableviewCell"
    private let stockLbl = UILabel()
     
    private let fullStockName = UILabel()
     
    private let stockPrice = UILabel()
     
    private let priceChange = UILabel()
    
    private let marketLbl: UILabel = UILabel()
    
    
    private let hStackView: UIStackView = {
        let hv = UIStackView(frame: .zero)
        hv.translatesAutoresizingMaskIntoConstraints = false
        hv.axis = .horizontal
        hv.spacing = 3
        return hv
    }()
    
    private let vStackview: UIStackView = {
        let sv = UIStackView(frame: .zero)
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        return sv
    }()
    
    private let rightvStackView: UIStackView = {
        let sv = UIStackView(frame: .zero)
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        return sv
    }()
     
     
     
 

     
     override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
         setUPViews()
         setUpConstraints()
         
     }
     
     private func setUPViews() {
         contentView.addSubview(vStackview)
         
//         vStackview.backgroundColor = .red
   
         vStackview.addArrangedSubview(hStackView)
         hStackView.addArrangedSubview(stockLbl)
         
         stockLbl.text = "APPL"
         stockLbl.font = FontConstants.boldFont
         stockLbl.translatesAutoresizingMaskIntoConstraints = false
         
//         // setting up the name of the stock
         vStackview.addArrangedSubview(fullStockName)
         fullStockName.text = "Apple Inc"
         fullStockName.font = FontConstants.cellMediumFont
         fullStockName.textColor = .systemGray
         fullStockName.translatesAutoresizingMaskIntoConstraints = false

         contentView.addSubview(rightvStackView)
         
//
//         // setting up the stock price
         rightvStackView.addArrangedSubview(stockPrice)
         stockPrice.translatesAutoresizingMaskIntoConstraints = false
         stockPrice.font = FontConstants.boldFont
         stockPrice.textAlignment = .right
         stockPrice.text = "155.74"
//
//         // setting up the price change
         rightvStackView.addArrangedSubview(priceChange)
         priceChange.translatesAutoresizingMaskIntoConstraints = false
         priceChange.textAlignment = .right
         priceChange.font = FontConstants.cellMediumFont
         priceChange.text = "(2.49%)"
         priceChange.textColor = ColorConstants.green
//
         // adding market label
         hStackView.addArrangedSubview(marketLbl)
         marketLbl.text = "· NASDAQ"
         marketLbl.font = FontConstants.cellMediumFont
         marketLbl.textColor = .systemGray
         marketLbl.translatesAutoresizingMaskIntoConstraints = false
         
         
         
         
         
     }
     
    /// in charge of constraints
     private func setUpConstraints() {
         // setting up the constrains of left stackview
         NSLayoutConstraint.activate([
            vStackview.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            vStackview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
         ])
         // setting up the constrains of right stackview
         NSLayoutConstraint.activate([
            rightvStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            rightvStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)

         ])
         // setting up constrains of marketLbl
        
         
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }

}
