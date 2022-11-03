import Charts
import UIKit

class StocksViewController: UIViewController, UINavigationControllerDelegate {
    
    /// MARK:  propeties
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
    
    private lazy var sectorHeaderLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = "Sector"
        textLabel.textAlignment = .center
        textLabel.font = FontConstants.boldLargeFont
        return textLabel
    }()
    
    private lazy var sectorTextLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = "Technology"
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
    
    private lazy var timeFrameHStackView: UIStackView = {
        let hStackView = UIStackView()
        hStackView.translatesAutoresizingMaskIntoConstraints = false
        hStackView.distribution = .equalSpacing
        hStackView.axis = .horizontal
        hStackView.alignment = .leading
        hStackView.addArrangedSubview(oneDayTimeFrame)
        hStackView.addArrangedSubview(weeklyTimeFrame)
        hStackView.addArrangedSubview(monthlyTimeFrame)
        hStackView.addArrangedSubview(yearlyTimeFrame)
        hStackView.addArrangedSubview(allTimeFrame)
        return hStackView
    }()
    
    private lazy var oneDayTimeFrame: UIButton = {
        let textLabel = UIButton()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.setTitle("1D", for: .normal)
        textLabel.layer.cornerRadius = 12
        textLabel.backgroundColor = ColorConstants.green
        return textLabel
    }()
    
    private lazy var weeklyTimeFrame: UIButton = {
        let textLabel = UIButton()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.setTitle("1W", for: .normal)
        textLabel.layer.cornerRadius = 12
        textLabel.setTitleColor(.label, for: .normal)
        return textLabel
    }()
    
    private lazy var monthlyTimeFrame: UIButton = {
        let textLabel = UIButton()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.setTitle("1M", for: .normal)
        textLabel.setTitleColor(.label, for: .normal)
        textLabel.layer.cornerRadius = 12
        return textLabel
    }()
    
    private lazy var yearlyTimeFrame: UIButton = {
        let textLabel = UIButton()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.setTitle("1Y", for: .normal)
        textLabel.setTitleColor(.label, for: .normal)
        textLabel.layer.cornerRadius = 12
        return textLabel
    }()
    
    private lazy var allTimeFrame: UIButton = {
        let textLabel = UIButton()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.setTitle("All", for: .normal)
        textLabel.setTitleColor(.label, for: .normal)
        textLabel.layer.cornerRadius = 12
        return textLabel
    }()
    
    private lazy var stockPriceLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = "$20.50"
        textLabel.font = FontConstants.boldFont
        textLabel.textColor = ColorConstants.green
        return textLabel
    }()
    
    private lazy var stockPricePercentChangeLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = " (2.51%)"
        textLabel.font = FontConstants.boldFont
        textLabel.textColor = ColorConstants.green
        return textLabel
    }()
    
    
    private lazy var stockPriceChangeLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
//        textLabel.text = "+2.32"
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
        let floatingButton = UIButton(type: .system)
        floatingButton.setTitle("Trade", for: .normal)
        floatingButton.translatesAutoresizingMaskIntoConstraints = false
        floatingButton.backgroundColor = ColorConstants.green
        floatingButton.layer.cornerRadius = 25
        floatingButton.setTitleColor(UIColor.white, for: .normal)

        floatingButton.addTarget(self, action: #selector(tradeButtonWaspressed), for: .touchUpInside)
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
    
    
    
    var tickerName = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = tickerName
        configureSubviews()
        setupConstraints()
        setData()
    }
    
    // TODO: intializer
    
    // so we pass the bestMatch from the previos vc
    init(stockInfo: BestMatch) {
        super.init(nibName: nil, bundle: nil)
        
        tickerSymbol.text = stockInfo.the2Name
        tickerName = stockInfo.the1Symbol
        
        API.getStockAboutMe(tickerSymbol: tickerName) { result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    //
                    self.aboutTextLabel.text = items?.stockAboutDescription
                    self.sectorTextLabel.text = items?.sector
                    self.stockEPSTextLabel.text =  items?.eps
                    self.stockPERatioTextLabel.text = items?.peRatio
                    // market cap
                    self.marketCapTextLabel.text = items?.marketCap
                }
            case .failure(let error):
                // otherwise, print an error to the console
                print(error)
            }
        }
        
        // we update the volume,  price and percent change
        API.getLatestStockPrice(tickerSymbol: tickerName) { result in
            
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    // update the price and
                    self.stockVolumeTextLabel.text = items?.globalQuote.the06Volume
                    self.stockPriceLabel.text = items?.globalQuote.the05Price
                    
                    
                    // so here we know we have items
                    if let items = items {
                        
                        if items.globalQuote.the10ChangePercent.contains(where: {return $0=="-"}) {
                               self.stockPricePercentChangeLabel.textColor = ColorConstants.red
                        } else {
                            self.stockPricePercentChangeLabel.textColor = ColorConstants.green
                        }
                        
                        self.stockPricePercentChangeLabel.text = items.globalQuote.the10ChangePercent
                    }
                }
                
            case .failure(let error):
                // otherwise, print an error to the console
                print(error)
            }
            
        }

        
  
    }
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
    }
    
    // this is actually fake data no needed
    // ignore
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: view set up
    
    private func configureSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        scrollView.addSubview(tradeButtonBottom)
        stackView.addArrangedSubview(tickerSymbol)
        stackView.addArrangedSubview(stockPriceHStackView)
        stackView.addArrangedSubview(lineChartView)
        stackView.addArrangedSubview(timeFrameHStackView)
        stackView.addArrangedSubview(aboutLabelHeader)
        stackView.addArrangedSubview(aboutTextLabel)
        stackView.addArrangedSubview(sectorHeaderLabel)
        stackView.addArrangedSubview(sectorTextLabel)
        stackView.addArrangedSubview(marketStatsHeaderLabel)
        stackView.addArrangedSubview(marketCapHStackView)
        stackView.addArrangedSubview(stockVolumeHStackView)
        stackView.addArrangedSubview(stockPERatioHStackView)
        stackView.addArrangedSubview(stockEPSHStackView)
    }
    

    private func setupConstraints() {
        let padding: CGFloat = 16
        scrollView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
            
        //
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
                

        // Constraints for views that are not horizontal stack views in the main vertical stack view
        // Let auto layout handle each stack height, chart height must be explicit though
        NSLayoutConstraint.activate([
            // Ticker Symbol layout
            stackView.arrangedSubviews[0].leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding),
            stackView.arrangedSubviews[0].rightAnchor.constraint(equalTo: view.rightAnchor),

            // Chart Layout
            stackView.arrangedSubviews[2].rightAnchor.constraint(equalTo: view.rightAnchor),
            stackView.arrangedSubviews[2].heightAnchor.constraint(equalToConstant: 200),
            stackView.arrangedSubviews[2].leftAnchor.constraint(equalTo: view.leftAnchor),

            // About Section Header
            stackView.arrangedSubviews[4].rightAnchor.constraint(equalTo: view.rightAnchor),
            
            // About Section Text
            stackView.arrangedSubviews[5].rightAnchor.constraint(equalTo: view.rightAnchor),
           
            // Type Section Label
            stackView.arrangedSubviews[6].rightAnchor.constraint(equalTo: view.rightAnchor),

            // Type Section Text Label
            stackView.arrangedSubviews[7].rightAnchor.constraint(equalTo: view.rightAnchor),
            
            // Market Stats Section Label
            stackView.arrangedSubviews[8].rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
                
        // Layout only needed for the price and % change to clip it to right hand side
        NSLayoutConstraint.activate([
            
            stockPriceHStackView.arrangedSubviews[1].rightAnchor.constraint(equalTo: stockPriceHStackView.arrangedSubviews[2].leftAnchor),
            
            stockPriceHStackView.arrangedSubviews[1].leftAnchor.constraint(equalTo: stockPriceHStackView.arrangedSubviews[0].rightAnchor),

            stockPriceHStackView.arrangedSubviews[2].rightAnchor.constraint(equalTo: view.rightAnchor, constant: -padding),
        ])
        
        // Provide layout for the right hand side labels
        NSLayoutConstraint.activate([
            marketCapHStackView.arrangedSubviews[1].rightAnchor.constraint(equalTo: view.rightAnchor, constant: -padding),
            stockVolumeHStackView.arrangedSubviews[1].rightAnchor.constraint(equalTo: view.rightAnchor, constant: -padding),
            stockVolumeHStackView.arrangedSubviews[1].rightAnchor.constraint(equalTo: view.rightAnchor, constant: -padding),
            stockPERatioHStackView.arrangedSubviews[1].rightAnchor.constraint(equalTo: view.rightAnchor, constant: -padding),
            stockEPSHStackView.arrangedSubviews[1].rightAnchor.constraint(equalTo: view.rightAnchor, constant: -padding)
        ])
        
        // offset the all time frame button to match right hand side offsets
        NSLayoutConstraint.activate([
            timeFrameHStackView.arrangedSubviews[4].rightAnchor.constraint(equalTo: view.rightAnchor, constant: -padding)

        ])
    }
    
    // MARK: Action methods
    
     @objc private func tradeButtonWaspressed() {
         let tradeView = TradeView()
         tradeView.translatesAutoresizingMaskIntoConstraints = false
         tradeView.delegate = self
         
         
         let currentWindow: UIWindow? = UIApplication.shared.keyWindow
         currentWindow?.addSubview(tradeView)
         
         
//         view.addSubview(tradeView)
         tradeView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
    }

    //MARK: Chart set up
    
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
    
    
    
    
    
}

// implementation of delegates
extension StocksViewController: TradingDelegate {
    func sell() {
        let vc = TransactionViewController()
        vc.delegate = self
        let view = UINavigationController(rootViewController: vc)
        view.modalPresentationStyle = .fullScreen
        self.present(view, animated: true)
    }
    
    func buy() {
        print("buy")
    }
    
    
}


extension StocksViewController: TransactionDelegate {
    func transac(of type: TransactionType) {
        let vc = TransactionSuccessfulViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
}
