//
//  DashboardContentView.swift
//  Stonx
//
//  Created by Angel Zambrano on 11/5/22.
//

import UIKit

import Charts


class DashboardContentView: UIView, UIGestureRecognizerDelegate {
    
    var stocks = [Stock]()
    
    //func chart
    // includes press gesture too see past history
    lazy var lineChartView: LineChartView = {
        let chartView  =  LineChartView()
        chartView.translatesAutoresizingMaskIntoConstraints = false
        chartView.backgroundColor = .clear
        chartView.rightAxis.enabled = false
        chartView.setScaleEnabled(false)
        chartView.xAxis.axisLineWidth = 0
        chartView.xAxis.enabled = false
        chartView.legend.enabled = false
        chartView.leftYAxisRenderer.axis.enabled = false
        let tapRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(chartTapped))
        tapRecognizer.minimumPressDuration = 0.01
        self.addGestureRecognizer(tapRecognizer)
        tapRecognizer.delegate = self
        return chartView
    }()
    
    func setData() {
        let set1 = LineChartDataSet(entries: yvalue)
        set1.drawCirclesEnabled = false
        set1.lineWidth = 2
        set1.setColor(ColorConstants.green)
        set1.gradientPositions = [0, 1]
        set1.fillColor = ColorConstants.lightGreen
        set1.drawFilledEnabled = true
        set1.drawHorizontalHighlightIndicatorEnabled = false
        let data = LineChartData(dataSet: set1)
        data.setDrawValues(false)
        lineChartView.data = data
    }
    
    // sets the data entry for the data
    let yvalue: [ChartDataEntry] = [
        ChartDataEntry(x: 0.0, y: 10.0) ,
        ChartDataEntry(x: 1.0, y: 5.0),
        ChartDataEntry(x: 2.0, y: 7.0),
        ChartDataEntry(x: 3.0, y: 5.0),
        ChartDataEntry(x:4.0, y: 10.0),
        ChartDataEntry(x: 5.0, y: 6.0),
        ChartDataEntry(x: 6.0, y: 5.0) ,
        ChartDataEntry(x: 7.0, y: 7.0),
        ChartDataEntry(x: 8.0, y: 8.0),
        ChartDataEntry(x: 9.0, y: 12.0) ,
        ChartDataEntry(x: 10.0, y: 13.0),
        ChartDataEntry (x: 11.0, y:5.0),
        ChartDataEntry(x: 12.0, y: 7.0),
        ChartDataEntry(x: 13.0, y: 3.0) ,
        ChartDataEntry(x: 14.0, y: 15.0),
        ChartDataEntry(x: 15.0, y: 6.0),
        ChartDataEntry(x: 16.0, y: 6.0),
        ChartDataEntry(x: 17.0, y: 7.0),
        ChartDataEntry (x: 18.0, y:3.0),
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
        ChartDataEntry(x: 33.0, y: 25.0) ,
        ChartDataEntry(x:34.0,y: 30.0),
        ChartDataEntry(x: 35.0, y: 55.0) ,
        ChartDataEntry(x: 36.0, y: 58.0),
        ChartDataEntry(x: 37.0, y:40.0),
        ChartDataEntry(x: 38.0, y: 43.0),
        ChartDataEntry(x: 39.0, y: 53.0),
        ChartDataEntry(x:40.9,y: 55.0)
    ]
    

    
    let stockLbl: UILabel = {
        let sp = UILabel()
        sp.text = "Investing"
        sp.font = FontConstants.boldLargeFont
        sp.textColor = .black

        return sp
    }()
    
    let StocksOwnedLbl: UILabel = {
        let sp = UILabel()
        sp.text = "Stocks"
        sp.font = FontConstants.boldLargeFont
        return sp
    }()
    
    
    lazy var stockPrice: UILabel = {
        let sp = UILabel()
        sp.text = "1470.00"
        sp.font = FontConstants.boldLargeFont
        sp.textColor = ColorConstants.green
        return sp
    }()
    
    lazy var priceChange: UILabel = {
        let sp = UILabel()
        sp.text = "2.49%"
        sp.font = FontConstants.boldLargeFont
        sp.textColor = ColorConstants.green
        sp.translatesAutoresizingMaskIntoConstraints = false
        return sp
    }()
    
    lazy var horizontalSV: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [stockPrice, priceChange])
        sv.axis = .horizontal
//        sv.backgroundColor = .red
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.distribution = .equalSpacing
        
        return sv
    }()

    lazy var verticalSV: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [stockLbl, horizontalSV, lineChartView, StocksOwnedLbl])
        sv.axis = .vertical
        sv.distribution = .equalSpacing
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.spacing = 10
        return sv
    }()
    
    let tableView : AutoSizingTableView = {
        let table = AutoSizingTableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.register(StockTableViewCell.self, forCellReuseIdentifier: StockTableViewCell.identifier)
        return table
    }()
    
    let ChartView = UIView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        ChartView.translatesAutoresizingMaskIntoConstraints = false
        ChartView.backgroundColor = UIColor.purple
        
        lineChartView.translatesAutoresizingMaskIntoConstraints = false
        lineChartView.heightAnchor.constraint(equalToConstant: 212.35).isActive = true
        setData()
    
        tableView.estimatedRowHeight = 44.0;
        tableView.rowHeight = UITableView.automaticDimension;
        
        
        verticalSV.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        
        self.addSubview(verticalSV)

        
        verticalSV.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: .init(top: 10, left: 16, bottom: 10, right: 16))
        
        self.addSubview(tableView)
        
        tableView.anchor(top: verticalSV.bottomAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
  
    }
    
    @objc func chartTapped(_ sender: UITapGestureRecognizer) {

            if sender.state == .began || sender.state == .changed {
                // show change history
                let position = sender.location(in: lineChartView)
                let highlight = lineChartView.getHighlightByTouchPoint(position)
                lineChartView.highlightValue(highlight)
                lineChartView.drawMarkers = true
                stockPrice.text = lineChartView.data?.entry(for: highlight!)?.y.description

            } else {
                // show current total balance
                stockPrice.text = "4700.00"
                lineChartView.highlightValue(nil)
            }
        }
    

    func configure(stocks: [Stock]) {
        self.stocks = stocks
        tableView.reloadData()
    }
   
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    

}



extension DashboardContentView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StockTableViewCell.identifier, for: indexPath) as! StockTableViewCell
        cell.layoutMargins = UIEdgeInsets.zero
        cell.configure(with: stocks[indexPath.row].ticker_symbol, sharesOwned: stocks[indexPath.row].quantity, price: stocks[indexPath.row].price, percentChange: stocks[indexPath.row].chagePercent)
        return cell
    }
}


extension DashboardContentView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        44
    }
}



