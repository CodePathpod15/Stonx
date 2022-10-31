import Charts
import UIKit

class StocksViewController: UIViewController {
    private lazy var tickerSymbol: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = "Apple"
        textLabel.textAlignment = .left
        textLabel.font = FontConstants.boldLargeFont
        return textLabel
    }()

    private lazy var aboutLabelHeader: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = "About"
        textLabel.textAlignment = .center
        textLabel.font = FontConstants.boldLargeFont
        return textLabel
    }()
    
    private lazy var aboutTextLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = "Apple Inc. is an American multinational technology company specializing in consumer electronics, software and online services headquartered in Cupertino, California, United States."
        textLabel.textAlignment = .left
        textLabel.numberOfLines = 0
        textLabel.textColor = UIColor.darkGray
        return textLabel
    }()
    
    private lazy var typeHeaderLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = "Type"
        textLabel.textAlignment = .center
        textLabel.font = FontConstants.boldLargeFont
        return textLabel
    }()
    
    private lazy var typeTextLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = "Commercial Banking"
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 0
        textLabel.textColor = UIColor.darkGray
        return textLabel
    }()
    
    private lazy var marketStatsHeaderLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = "Market Stats"
        textLabel.textAlignment = .center
        textLabel.font = FontConstants.boldLargeFont
        return textLabel
    }()
    
    private lazy var marketCapHStackView: UIStackView = {
        let hStackView = UIStackView()
        hStackView.translatesAutoresizingMaskIntoConstraints = false
        hStackView.distribution = .equalSpacing
        hStackView.axis = .horizontal
        hStackView.alignment = .leading
        hStackView.addArrangedSubview(marketCapHeaderLabel)
        hStackView.addArrangedSubview(marketCapTextLabel)
        return hStackView
    }()
    
    private lazy var stockVolumeHStackView: UIStackView = {
        let hStackView = UIStackView()
        hStackView.translatesAutoresizingMaskIntoConstraints = false
        hStackView.distribution = .equalSpacing
        hStackView.axis = .horizontal
        hStackView.alignment = .leading
        hStackView.addArrangedSubview(stockVolumeHeaderLabel)
        hStackView.addArrangedSubview(stockVolumeTextLabel)
        return hStackView
    }()

    private lazy var stockPERatioHStackView: UIStackView = {
        let hStackView = UIStackView()
        hStackView.translatesAutoresizingMaskIntoConstraints = false
        hStackView.distribution = .equalSpacing
        hStackView.axis = .horizontal
        hStackView.alignment = .leading
        hStackView.addArrangedSubview(stockPERatioHeaderLabel)
        hStackView.addArrangedSubview(stockPERatioTextLabel)
        return hStackView
    }()
    
    private lazy var stockEPSHStackView: UIStackView = {
        let hStackView = UIStackView()
        hStackView.translatesAutoresizingMaskIntoConstraints = false
        hStackView.distribution = .equalSpacing
        hStackView.axis = .horizontal
        hStackView.alignment = .leading
        hStackView.addArrangedSubview(stockEPSHeaderLabel)
        hStackView.addArrangedSubview(stockEPSTextLabel)
        return hStackView
    }()
    
    private lazy var stockPriceHStackView: UIStackView = {
        let hStackView = UIStackView()
        hStackView.translatesAutoresizingMaskIntoConstraints = false
        hStackView.distribution = .equalSpacing
        hStackView.axis = .horizontal
        hStackView.alignment = .leading
        hStackView.addArrangedSubview(stockPriceLabel)
        hStackView.addArrangedSubview(stockPriceChangeLabel)
        hStackView.addArrangedSubview(stockPricePercentChangeLabel)
        return hStackView
    }()
    
    private lazy var stockPriceLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = "$20.50"
        textLabel.textAlignment = .left
        textLabel.font = FontConstants.boldFont
        textLabel.textColor = .systemGreen
        return textLabel
    }()
    
    private lazy var stockPricePercentChangeLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = "(2.51%)"
        textLabel.textAlignment = .left
        textLabel.font = FontConstants.boldFont
        textLabel.textColor = .systemGreen
        return textLabel
    }()
    
    
    private lazy var stockPriceChangeLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = "+2.32"
        textLabel.textAlignment = .right
        return textLabel
    }()
    
    private lazy var stockEPSTextLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = "2.33"
        return textLabel
    }()
    
    private lazy var stockEPSHeaderLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = "EPS"
        return textLabel
    }()
    
    private lazy var stockPERatioHeaderLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = "P/E Ratio"
        return textLabel
    }()
    
    private lazy var stockPERatioTextLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = "21.50"
        return textLabel
    }()
    
    private lazy var marketCapHeaderLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = "Market Cap"
        return textLabel
    }()
    
    private lazy var marketCapTextLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = "1.10B"
        return textLabel
    }()

    private lazy var stockVolumeHeaderLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = "Volume"
        return textLabel
    }()
    
    private lazy var stockVolumeTextLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = "1799234M"
        return textLabel
    }()
    
    private let tradeButtonBottom: UIButton = {
        let floatingButton = UIButton()
        floatingButton.setTitle("Trade", for: .normal)
        floatingButton.translatesAutoresizingMaskIntoConstraints = false
        floatingButton.backgroundColor = .label
        floatingButton.layer.cornerRadius = 25
        floatingButton.layer.borderWidth = 1

        return floatingButton
    }()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var lineChartView: LineChartView = {
        let chartView = LineChartView()
        chartView.translatesAutoresizingMaskIntoConstraints = false
        chartView.backgroundColor = .clear
        chartView.rightAxis.enabled = false
        
        chartView.xAxis.axisLineWidth = 0
        chartView.xAxis.enabled = false
        chartView.legend.enabled = false
        
        chartView.leftYAxisRenderer.axis.enabled = false
        
        return chartView
    }()
    
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
        set1.drawHorizontalHighlightIndicatorEnabled = false
        
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

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "AAPL"
        configureSubviews()
        setupConstraints()
        setData()
    }

    private func configureSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        scrollView.addSubview(tradeButtonBottom)
        stackView.addArrangedSubview(tickerSymbol)
        stackView.addArrangedSubview(stockPriceHStackView)
        stackView.addArrangedSubview(lineChartView)
        stackView.addArrangedSubview(aboutLabelHeader)
        stackView.addArrangedSubview(aboutTextLabel)
        stackView.addArrangedSubview(typeHeaderLabel)
        stackView.addArrangedSubview(typeTextLabel)
        stackView.addArrangedSubview(marketStatsHeaderLabel)
        stackView.addArrangedSubview(marketCapHStackView)
        stackView.addArrangedSubview(stockVolumeHStackView)
        stackView.addArrangedSubview(stockPERatioHStackView)
        stackView.addArrangedSubview(stockEPSHStackView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor)
        ])
        NSLayoutConstraint.activate([
            tradeButtonBottom.widthAnchor.constraint(equalToConstant: 150),
            tradeButtonBottom.heightAnchor.constraint(equalToConstant: 50),
            tradeButtonBottom.centerXAnchor.constraint(equalTo: view.trailingAnchor),
            tradeButtonBottom.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tradeButtonBottom.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20)
        ])

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -100),
            stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor)
        ])

        
        // Constraints for views that are not horizontal stack views in the main vertical satck view
        NSLayoutConstraint.activate([
            // Ticker Symbol layout
            stackView.arrangedSubviews[0].leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            stackView.arrangedSubviews[0].rightAnchor.constraint(equalTo: view.rightAnchor),

            // Chart Layout
            stackView.arrangedSubviews[2].rightAnchor.constraint(equalTo: view.rightAnchor),
            stackView.arrangedSubviews[2].heightAnchor.constraint(equalToConstant: 200),
            stackView.arrangedSubviews[2].leftAnchor.constraint(equalTo: view.leftAnchor),

            // About Section text
            stackView.arrangedSubviews[3].rightAnchor.constraint(equalTo: view.rightAnchor),
            
            // Type Section Header
            stackView.arrangedSubviews[4].rightAnchor.constraint(equalTo: view.rightAnchor),
           
            // Type Section Label
            stackView.arrangedSubviews[5].rightAnchor.constraint(equalTo: view.rightAnchor),
            stackView.arrangedSubviews[5].heightAnchor.constraint(equalToConstant: 50),

            // Type Section Text Label
            stackView.arrangedSubviews[6].rightAnchor.constraint(equalTo: view.rightAnchor),
            stackView.arrangedSubviews[6].heightAnchor.constraint(equalToConstant: 50),
            
            // Market Stats Section Label
            stackView.arrangedSubviews[7].rightAnchor.constraint(equalTo: view.rightAnchor),
            stackView.arrangedSubviews[7].heightAnchor.constraint(equalToConstant: 50)
        ])
                
        // Layout for the horizontal stack view for displaying price, price change, and percent change
        NSLayoutConstraint.activate([
            
            stockPriceHStackView.arrangedSubviews[0].widthAnchor.constraint(equalToConstant: 150),

            stockPriceHStackView.arrangedSubviews[1].rightAnchor.constraint(equalTo: stockPriceHStackView.arrangedSubviews[2].leftAnchor),
            
            stockPriceHStackView.arrangedSubviews[1].leftAnchor.constraint(equalTo: stockPriceHStackView.arrangedSubviews[0].rightAnchor),

            stockPriceHStackView.arrangedSubviews[2].rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
        ])
        
        // No need to set layout for left hand labels as it will inherit the leading vertical stackView layout
        NSLayoutConstraint.activate([
            marketCapHStackView.arrangedSubviews[1].rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            stockVolumeHStackView.arrangedSubviews[1].rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            stockVolumeHStackView.arrangedSubviews[1].rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            stockPERatioHStackView.arrangedSubviews[1].rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            stockEPSHStackView.arrangedSubviews[1].rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10)
        ])
    }
}
