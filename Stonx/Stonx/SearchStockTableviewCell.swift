//
//  SearchStockTableviewCell.swift
//  Stonx
//
//  Created by Angel Zambrano on 10/28/22.
//

import UIKit

class SearchStockTableviewCell: UITableViewCell {

    
     static let identifier = "SearchStockTableviewCell"
     let stockLbl = UILabel()
     
     let fullStockName = UILabel()
     
     private let stockPrice = UILabel()
     
     private let priceChange = UILabel()
    
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
     
     
     
     
     // TODO: use chart pod to create a chart
     let chart: UIView = UIView()

     
     override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
         setUPViews()
         setUpConstraints()
         
     }
     
     private func setUPViews() {
         contentView.addSubview(vStackview)
         
//         vStackview.backgroundColor = .red
         
         
         vStackview.addArrangedSubview(stockLbl)
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
         
         
//         // setting up the chart
//         contentView.addSubview(chart)
//         chart.translatesAutoresizingMaskIntoConstraints = false
//         chart.backgroundColor = .green
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
         
         
         
         
     }
     
     private func setUpConstraints() {
         NSLayoutConstraint.activate([
            vStackview.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            vStackview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
         ])
         
         NSLayoutConstraint.activate([
            rightvStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            rightvStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)

         ])
         
//         NSLayoutConstraint.activate([
//             stockLbl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
//             stockLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
//         ])
//
//         NSLayoutConstraint.activate([
//             fullStockName.topAnchor.constraint(equalTo: stockLbl.bottomAnchor, constant: 0),
//             fullStockName.leadingAnchor.constraint(equalTo: stockLbl.leadingAnchor),
//             fullStockName.widthAnchor.constraint(equalToConstant: contentView.frame.width/2)
//
//         ])
//
//
//         NSLayoutConstraint.activate([
//             chart.bottomAnchor.constraint(equalTo: fullStockName.bottomAnchor),
//             chart.leadingAnchor.constraint(equalTo: fullStockName.trailingAnchor, constant: 10),
//             chart.heightAnchor.constraint(equalToConstant: 23),
//             chart.widthAnchor.constraint(equalToConstant: 60)
//         ])
//
//         // setting up constraints for stock price
//         NSLayoutConstraint.activate([
//             stockPrice.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
//             stockPrice.centerYAnchor.constraint(equalTo: stockLbl.centerYAnchor)
//         ])
//
//         NSLayoutConstraint.activate([
//             priceChange.trailingAnchor.constraint(equalTo: stockPrice.trailingAnchor),
//             priceChange.centerYAnchor.constraint(equalTo: fullStockName.centerYAnchor)
//
//         ])
         
         
         
         
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }

}
