//
//  StkContentView.swift
//  Stonx
//
//  Created by Angel Zambrano on 11/25/22.
//

import UIKit
import Charts

// these are all the delegate
protocol MarketProtocol: AnyObject {
    func marketCapWasPressed()
    func volumeInfoWasPressed()
    func PERatioWaspressed()
    func EPSWasPressed()
}

class StkContentView: UIView {
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
    

    
    let fullNameStockLbl: UILabel = {
        let sp = UILabel()
        sp.text = "International Business Machine Corp"
        sp.font = FontConstants.boldLargeFont
        sp.textColor = .black
        sp.numberOfLines = 0
        
        return sp
    }()
    
    /// section title
    let AboutSectionTitle: UILabel = {
        let sp = UILabel()
        sp.text = "About"
        sp.font = FontConstants.boldLargeFont
        sp.textAlignment = .center
        return sp
    }()
    
    /// the description of the text
    let AboutText: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = "Apple Inc. is an American multinational technology company specializing in consumer electronics, software and online services headquartered in Cupertino, California, United States."
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 0
        textLabel.textColor = UIColor.darkGray
        return textLabel
    }()
    
    let sectiorSectionTitle: UILabel = {
        let sp = UILabel()
        sp.text = "Sector"
        sp.font = FontConstants.boldLargeFont
        sp.textAlignment = .center
        return sp
    }()
    
    let sectorText: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = "TECHNOLOGY"
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 0
        textLabel.textColor = UIColor.darkGray
        return textLabel
    }()
    
    // market stats
    let marketStatsSectionTitle: UILabel = {
        let sp = UILabel()
        sp.text = "Market Stats"
        sp.font = FontConstants.boldLargeFont
        sp.textAlignment = .center
        return sp
    }()
    
    let discussionsSectionTitle: UILabel = {
        let sp = UILabel()
        sp.text = "Discussions"
        sp.font = FontConstants.boldLargeFont
        sp.textAlignment = .center
        return sp
    }()
    

    
    lazy var stockPrice: UILabel = {
        let sp = UILabel()
        sp.text = "148.7500"
        sp.font = FontConstants.boldFont
        sp.textColor = ColorConstants.green
        return sp
    }()
    
    lazy var pricePercentChange: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = "+2.32"
        textLabel.textColor = ColorConstants.green
        textLabel.font = FontConstants.boldFont
        textLabel.textAlignment = .right
        return textLabel
    }()
    
    lazy var horizontalSV: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [stockPrice, pricePercentChange])
        sv.axis = .horizontal
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.distribution = .equalSpacing
        sv.alignment = .leading
        
        return sv
    }()
    
    
    lazy var verticalSV: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [fullNameStockLbl, horizontalSV,lineChartView, AboutSectionTitle, AboutText, sectiorSectionTitle,sectorText,marketStatsSectionTitle, ])
        sv.axis = .vertical
        sv.distribution = .equalSpacing
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.spacing = 10
        return sv
    }()
    
    
    let marketCap = statSV()
    let volumeSV = statSV()
    let peRatioSV = statSV()
    let epsSV = statSV()
    
    

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(verticalSV)
        verticalSV.addArrangedSubview(marketCap)
        marketCap.configure(title: "Market Cap")
        marketCap.configure(amount: "133327602000")
        
        verticalSV.addArrangedSubview(volumeSV)
        volumeSV.configure(title: "Volume")
        volumeSV.configure(amount: "3658459")
        
        verticalSV.addArrangedSubview(peRatioSV)
        peRatioSV.configure(title: "P/E Ratio")
        peRatioSV.configure(amount: "24.43")
        
        verticalSV.addArrangedSubview(epsSV)
        epsSV.configure(title: "EPS")
        epsSV.configure(amount: "6.09")
        
        
        verticalSV.addArrangedSubview(discussionsSectionTitle)
        
        verticalSV.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor)
        
        lineChartView.translatesAutoresizingMaskIntoConstraints = false
        lineChartView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        setData()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}