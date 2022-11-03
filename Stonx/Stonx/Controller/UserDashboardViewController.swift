//
//  UserDashboardViewController.swift
//  Stonx
//
//  Created by Angel Zambrano on 10/22/22.
//

import UIKit
import Charts

// TODO: write viewcontroller implementation stuff here

class UserDashboardViewController: UIViewController {
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
    
    private var stocksTableview: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        return tableView
    }()
    
    private lazy var investingLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = "Investing"
        textLabel.textAlignment = .left
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
        hStackView.alignment = .center
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
        textLabel.backgroundColor = .yellow

        textLabel.textColor = ColorConstants.green
        return textLabel
    }()
    
    private lazy var stockPricePercentChangeLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = "(2.51%)"
        textLabel.font = FontConstants.boldFont
        textLabel.backgroundColor = .blue

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
        setData()
        view.backgroundColor = .systemGray6
        
        stocksTableview.dataSource = self
        stocksTableview.delegate = self

        stocksTableview.alwaysBounceVertical = false
        stocksTableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        stocksTableview.register(StockTableViewCell.self, forCellReuseIdentifier: StockTableViewCell.identifier)
        stocksTableview.translatesAutoresizingMaskIntoConstraints = false
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
        scrollView.addSubview(stocksTableview)
        stackView.addArrangedSubview(investingLabel)
        stackView.addArrangedSubview(stockPriceHStackView)
        stackView.addArrangedSubview(lineChartView)
        stackView.addArrangedSubview(timeFrameHStackView)
        //stackView.addArrangedSubview(stocksTableview)
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
            
            //investin label
            stackView.arrangedSubviews[0].leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            stackView.arrangedSubviews[0].rightAnchor.constraint(equalTo: view.rightAnchor),

            // Chart Layout
            stackView.arrangedSubviews[2].rightAnchor.constraint(equalTo: view.rightAnchor),
            stackView.arrangedSubviews[2].heightAnchor.constraint(equalToConstant: 200),
            stackView.arrangedSubviews[2].leftAnchor.constraint(equalTo: view.leftAnchor),
            
            
            // Table view layout
            stocksTableview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            stocksTableview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            stocksTableview.topAnchor.constraint(equalTo: stackView.arrangedSubviews[2].bottomAnchor, constant: -10),
            stocksTableview.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),


        ])
        
        NSLayoutConstraint.activate([
            stockPriceHStackView.arrangedSubviews[1].rightAnchor.constraint(equalTo: stockPriceHStackView.arrangedSubviews[2].leftAnchor),
            
            stockPriceHStackView.arrangedSubviews[1].leftAnchor.constraint(equalTo: stockPriceHStackView.arrangedSubviews[0].rightAnchor),

            stockPriceHStackView.arrangedSubviews[2].rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            timeFrameHStackView.arrangedSubviews[4].rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10)

        ])

        
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
