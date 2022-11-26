//
//  StockContentView.swift
//  Stonx
//
//  Created by Angel Zambrano on 11/25/22.
//

import UIKit
import Charts

class StockContentView: UIView {
    
    // MARK: properties
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
    
    private lazy var stockVolumeTextLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = "1799234M"
        return textLabel
    }()
    
    lazy var imageIconVolume: UIButton = {
        let image = UIImage(systemName: "info.circle")?.withRenderingMode(.alwaysOriginal).withTintColor(ColorConstants.green)
        let button = UIButton(type: .system)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(indicatorWaspressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var stockVolumeHeaderLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = "Volume"
        return textLabel
    }()
    
    private lazy var stockVolumeAndIconSV: UIStackView = {
        let hStackView = UIStackView()
        hStackView.translatesAutoresizingMaskIntoConstraints = false
        hStackView.axis = .horizontal
        hStackView.spacing = 2
        hStackView.alignment = .center
        hStackView.addArrangedSubview(imageIconVolume)
        hStackView.addArrangedSubview(stockVolumeHeaderLabel)

        return hStackView
    }()

    private lazy var stockVolumeHStackView: UIStackView = {
        let hStackView = UIStackView()
        hStackView.translatesAutoresizingMaskIntoConstraints = false
        hStackView.distribution = .equalSpacing
        hStackView.axis = .horizontal
        hStackView.alignment = .leading
        hStackView.addArrangedSubview(stockVolumeAndIconSV)
        hStackView.addArrangedSubview(stockVolumeTextLabel)
        return hStackView
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

    lazy var marketCap = StatSV(frame: .zero)
    var btn: UIButton = UIButton(type: .system)
    
    lazy var volumeSV = StatSV()
    lazy var peRatioSV = StatSV()
    lazy var EPSSV = StatSV()
    
    lazy var verticalSV: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [fullNameStockLbl, horizontalSV,lineChartView, AboutSectionTitle, AboutText, sectiorSectionTitle,sectorText,marketStatsSectionTitle])
        
        sv.axis = .vertical
        sv.distribution = .equalSpacing
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.spacing = 10
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        btn.setTitle("hehe", for: .normal)
        btn.clipsToBounds = true

        setupViews()
        setData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func indicatorWaspressed() {
        
    }
    
    func setupViews() {
        lineChartView.translatesAutoresizingMaskIntoConstraints = false
        lineChartView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        verticalSV.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(verticalSV)
        verticalSV.addArrangedSubview(btn)
        
        verticalSV.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: .init(top: 10, left: 16, bottom: 10, right: 16))

    }
    
    @objc func imageIconVolumePressed() {
        
        print("hello")
    }
    
    
    


}
