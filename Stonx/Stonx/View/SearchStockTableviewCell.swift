//
//  SearchStockTableviewCell.swift
//  Stonx
//
//  Created by Angel Zambrano on 10/28/22.
//

import UIKit


// this is the tableview cell that contains no chart, primarly used for searchign
class SearchStockTableviewCell: UITableViewCell {

    
    // MARK: properties
    
    static let identifier = "SearchStockTableviewCell"
    private let stockLbl = UILabel()
    private let stockFullName = UILabel()
         
    private let hStackView: UIStackView = {
        let hv = UIStackView(frame: .zero)
        hv.translatesAutoresizingMaskIntoConstraints = false
        hv.distribution = .fill
        
        hv.axis = .horizontal
        hv.spacing = 0
        return hv
    }()
    
    
    private let vStackview: UIStackView = {
        let sv = UIStackView(frame: .zero)
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.alignment = .leading
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
         
         vStackview.addArrangedSubview(hStackView)

         hStackView.addArrangedSubview(stockLbl)
         
         stockLbl.text = "APPL"
         stockLbl.font = FontConstants.boldFont
         stockLbl.translatesAutoresizingMaskIntoConstraints = false
         
         contentView.addSubview(rightvStackView)
//
//         // setting up the stock price
         rightvStackView.addArrangedSubview(stockFullName)
         stockFullName.translatesAutoresizingMaskIntoConstraints = false
         stockFullName.font = FontConstants.regularFont
         stockFullName.textAlignment = .center
         stockFullName.numberOfLines = 2
         stockFullName.text = "155.74"
         
     }
    
    //configuring the cell
    // this is configuirng the sell when we're searching for a stock
     func configure(ticker: String = "Error", fullName: String? = "Error", market: String? = "error") {
        self.stockLbl.text = ticker

         self.stockFullName.text = fullName

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
            rightvStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            rightvStackView.widthAnchor.constraint(equalToConstant: 130)
         ])
     }
     
    
    
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
    

}
