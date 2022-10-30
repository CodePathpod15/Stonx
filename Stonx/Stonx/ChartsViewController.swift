//
//  ChartsViewController.swift
//  Stonx
//
//  Created by Angel Zambrano on 10/30/22.
//

import UIKit
import Charts

class ChartsViewController: UIViewController, ChartViewDelegate {
    
    lazy var lineChartView: LineChartView = {
        let chartView  =  LineChartView()
        chartView.translatesAutoresizingMaskIntoConstraints = false
        chartView.backgroundColor = .clear
        chartView.rightAxis.enabled = false
        
        chartView.xAxis.axisLineWidth = 0
        chartView.xAxis.enabled = false
        
        chartView.leftYAxisRenderer.axis.enabled = false
        
        
        
        return chartView
    }()
    
    func setData() {
        let set1 = LineChartDataSet(entries: yvalue)
        
        
//        set1.mode = .
        set1.drawCirclesEnabled = false
        set1.lineWidth = 2
        set1.setColor(UIColor(red: 63/255, green: 191/255, blue: 160/255, alpha: 1))
//        set1.fillAlpha = 0.8
        set1.gradientPositions = [0, 1]
        set1.fillColor = UIColor(red: 238/255, green: 254/255, blue: 242/255, alpha: 1)
        set1.drawFilledEnabled = true
        
        
        
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
    
  

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        
        view.addSubview(lineChartView)
        lineChartView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lineChartView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        lineChartView.widthAnchor.constraint(equalToConstant: 359.21).isActive = true
        lineChartView.heightAnchor.constraint(equalToConstant: 146.87).isActive = true
        
        setData()

        
    }
    


}
