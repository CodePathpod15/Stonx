//
//  ComparisonViewController.swift
//  Stonx
//
//  Created by Angel Zambrano on 11/9/22.
//

import UIKit

class ComparisonViewController: UIViewController {
    // adding the content view 
    let contentView = ComparisonView(frame: .zero)
    let scrollView = UIScrollView()
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
         
    }
    
    init(stocksToBeCompared: [String]) {
        super.init(nibName: nil, bundle: nil)
        print(stocksToBeCompared)
        
//        contentView.configureLeftSideOfContentView(ticker: ])
        contentView.configureLeftSideOfContentView(ticker: stocksToBeCompared[0], price: 32.00, about: "Apple is an innovative company that likes to make things", type: "Technology", marketCap: "1.90B", volume: "3.51B", PERatio: "23.3", EPS: "5.31")
        

        contentView.configureRightSideOfStockView(ticker: stocksToBeCompared[1], price: 22.00, about: "this company isnt innovative and doesnt do things correctly but oh well", type: "Technology", marketCap: "9.90B", volume: "5.51B", PERatio: "33.3", EPS: "6.31")
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        setUp()
    }
    
    
    func setUp() {
        view.addSubview(scrollView)
        title = "Dashboard"

        scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)

        // add content view
        scrollView.addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor)
        // :-)
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])


    }

}
