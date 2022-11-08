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
    
    private let stockPrice = UILabel()
    
    private let priceChange = UILabel()
    
    // TODO: use chart pod to create a chart
    // TODO: add gradient
    lazy var lineChartView: LineChartView = {
        let chartView = LineChartView()
        chartView.translatesAutoresizingMaskIntoConstraints = false
        chartView.backgroundColor = .clear
        chartView.rightAxis.enabled = false
        
        chartView.xAxis.axisLineWidth = 0
        chartView.xAxis.enabled = false
        chartView.legend.enabled = false
        chartView.isUserInteractionEnabled = false
        
        chartView.leftYAxisRenderer.axis.enabled = false
        
        return chartView
    }()
    
    func configure(with ticker: String, sharesOwned: Int) {
        if sharesOwned == 1 {
            self.sharesOwned.text = "\(sharesOwned) Share"
        } else {
            self.sharesOwned.text = "\(sharesOwned) Shares"
        }
        self.stockLbl.text = ticker
    }
    
    func setData() {
        let set1 = LineChartDataSet(entries: yvalue)
        
        set1.drawCirclesEnabled = false
        set1.lineWidth = 1
        set1.setColor(UIColor(red: 63/255, green: 191/255, blue: 160/255, alpha: 1))
        set1.fillAlpha = 0.2
        set1.gradientPositions = [0, 0.1, 0.9, 1]
        set1.isDrawLineWithGradientEnabled = true
        set1.fillColor = UIColor(red: 63/255, green: 191/255, blue: 160/255, alpha: 1)
        set1.drawFilledEnabled = true
        
        let data = LineChartData(dataSet: set1)
        data.setDrawValues(false)
        lineChartView.data = data
    }
    
    // fake data
    // sets the data entry for the data
    let yvalue: [ChartDataEntry] = [
        ChartDataEntry(x: 0.0, y: 10.0),
        ChartDataEntry(x: 1.0, y: 5.0),
        ChartDataEntry(x: 2.0, y: 7.0),
        ChartDataEntry(x: 3.0, y: 5.0),
        ChartDataEntry(x: 4.0, y: 10.0),
        ChartDataEntry(x: 5.0, y: 6.0),
        ChartDataEntry(x: 6.0, y: 5.0),
        ChartDataEntry(x: 7.0, y: 7.0),
        ChartDataEntry(x: 8.0, y: 8.0),
        ChartDataEntry(x: 9.0, y: 12.0),
        ChartDataEntry(x: 10.0, y: 13.0),
        ChartDataEntry(x: 11.0, y: 5.0),
        ChartDataEntry(x: 12.0, y: 7.0),
        ChartDataEntry(x: 13.0, y: 3.0),
        ChartDataEntry(x: 14.0, y: 15.0),
        ChartDataEntry(x: 15.0, y: 6.0),
        ChartDataEntry(x: 16.0, y: 6.0),
        ChartDataEntry(x: 17.0, y: 7.0),
        ChartDataEntry(x: 18.0, y: 3.0),
        ChartDataEntry(x: 19.0, y: 10.0),
        ChartDataEntry(x: 20.0, y: 12.0),
        ChartDataEntry(x: 21.0, y: 15.0),
        ChartDataEntry(x: 22.0, y: 17.0),
        ChartDataEntry(x: 23.0, y: 15.0),
        ChartDataEntry(x: 24.0, y: 10.0),
        ChartDataEntry(x: 25.0, y: 10.0),
        ChartDataEntry(x: 26.0, y: 10.0),
        ChartDataEntry(x: 27.0, y: 17.0),
        ChartDataEntry(x: 28.0, y: 13.0),
        ChartDataEntry(x: 29.0, y: 20.0),
        ChartDataEntry(x: 30.0, y: 24.0),
        ChartDataEntry(x: 31.0, y: 25.0),
        ChartDataEntry(x: 32.0, y: 27.0),
        ChartDataEntry(x: 33.0, y: 25.0),
        ChartDataEntry(x: 34.0, y: 30.0),
        ChartDataEntry(x: 35.0, y: 55.0),
        ChartDataEntry(x: 36.0, y: 58.0),
        ChartDataEntry(x: 37.0, y: 40.0),
        ChartDataEntry(x: 38.0, y: 43.0),
        ChartDataEntry(x: 39.0, y: 53.0),
        ChartDataEntry(x: 40.9, y: 55.0)
    ]

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUPViews()
        setUpConstraints()
        setData()
        
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

