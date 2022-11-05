//
//  UserDashboardViewController.swift
//  Stonx
//
//  Created by Angel Zambrano on 10/22/22.
//

import UIKit
import Charts
import Parse

// TODO: write viewcontroller implementation stuff here

class UserDashboardViewController: UIViewController {
    
    
    var yvalue: [ChartDataEntry] = [ChartDataEntry]()
    
    lazy var lineChartView: LineChartView = {
        let chartView = LineChartView()
        
        chartView.translatesAutoresizingMaskIntoConstraints = false
        chartView.backgroundColor = .clear
        chartView.rightAxis.enabled = false
//        chartView.isFullyZoomedOut = true
        chartView.dragEnabled = false
        
//        chartView.isPinchZoomEnabled = false
        
        chartView.xAxis.axisLineWidth = 0
        chartView.xAxis.enabled = false
        chartView.legend.enabled = false
        
        chartView.leftYAxisRenderer.axis.enabled = false
        
        return chartView
    }()
    
    private var stocksTableview: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        return tableView
    }()
    
    private lazy var investingLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.text = "Investing"
        textLabel.font = FontConstants.boldLargeFont
        return textLabel
    }()
    
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var scrollView: UIScrollView = {
        
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
        
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
        textLabel.text = "+2.32"
        textLabel.textAlignment = .right
        return textLabel
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
        setUpConstraints()
        createCharData()
        
        view.backgroundColor = .systemGray6
        
        stocksTableview.dataSource = self
        stocksTableview.delegate = self

        stocksTableview.alwaysBounceVertical = false
        stocksTableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        stocksTableview.register(StockTableViewCell.self, forCellReuseIdentifier: StockTableViewCell.identifier)
        stocksTableview.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    
    var data = [ChartDataEntry]()
    
    // create fake stock data
    func createCharData() {
        // seperated time
        API.getStockWithTimeSeries(tickerSymbol: "aapl") { result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    if let item = items {
                        let content2 = item.timeSeries5Min
                        for (time, val) in content2 {
                            let nTime = time.components(separatedBy: " ")[1]
                            let SeperatedTime = nTime.components(separatedBy: ":")
                            let totalTime:Double = Double(SeperatedTime[0])! + Double(SeperatedTime[1])!
                            self.yvalue.append(.init(x: totalTime, y: Double(val.the4Close)!))
                            
                        }
                        // sorted
                        let val2 = self.yvalue.sorted { val1, val2 in return val1.x < val2.x }
                       
                        self.yvalue = val2
                    
                        self.setData()
                        
                    }
                    
                    
                }
            case .failure(let error):
                // otherwise, print an error to the console
                print(error)
            }

        }
        
        
        
        
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
        set1.drawHorizontalHighlightIndicatorEnabled = false
        
        let data = LineChartData(dataSet: set1)
        data.setDrawValues(false)
        lineChartView.data = data
    }
    
    private func configureSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        // adding the views
        [investingLabel, stockPriceHStackView, lineChartView, timeFrameHStackView, stocksTableview].forEach({stackView.addArrangedSubview($0) })
    }
    
    private func setUpConstraints(){
        
        scrollView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -100),
            stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor)
        ])
        
        NSLayoutConstraint.activate([
            
            stockPriceHStackView.arrangedSubviews[1].rightAnchor.constraint(equalTo: stockPriceHStackView.arrangedSubviews[2].leftAnchor),
            
            stockPriceHStackView.arrangedSubviews[1].leftAnchor.constraint(equalTo: stockPriceHStackView.arrangedSubviews[0].rightAnchor),

            stockPriceHStackView.arrangedSubviews[2].rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
        ])

        NSLayoutConstraint.activate([
            timeFrameHStackView.arrangedSubviews[4].rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10)

        ])
        
        NSLayoutConstraint.activate([
            stackView.arrangedSubviews[0].leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            stackView.arrangedSubviews[0].rightAnchor.constraint(equalTo: view.rightAnchor),

            // Chart Layout
            stackView.arrangedSubviews[2].rightAnchor.constraint(equalTo: view.rightAnchor),
            stackView.arrangedSubviews[2].heightAnchor.constraint(equalToConstant: 200),
            stackView.arrangedSubviews[2].leftAnchor.constraint(equalTo: view.leftAnchor),
            
            stackView.arrangedSubviews[4].trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            stackView.arrangedSubviews[4].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            stackView.arrangedSubviews[4].bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),

            
            
        ])
        
        
        
//        NSLayoutConstraint.activate([
//            stocksTableview.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
//            stocksTableview.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
//            stocksTableview.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
    }

}

extension UserDashboardViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Stocks"
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StockTableViewCell.identifier, for: indexPath) as! StockTableViewCell
        
        return cell

    }
    
    // overrided this to change the font size of the header
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        header.textLabel?.textColor = .black

    }
}

extension UserDashboardViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 44
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tb = StocksViewController()
        navigationController?.pushViewController(tb, animated: true)
    }
    
   
}
