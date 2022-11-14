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
    
    
    func getThePrice(tickerSymbol: String, content: ComparisonView, isLeft: Bool) {
        
        API.getStockAboutMe(tickerSymbol: tickerSymbol) { result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    
                    if isLeft {
                        content.verticalSV.editLeftSide(tickerName: tickerSymbol, price: 0, about: items?.stockAboutDescription ?? "xx", type: items?.sector ?? "xx", marketCap: items?.marketCap ?? "xx", volume: "xx", PERatio: items?.peRatio ?? "", EPS: items?.eps ?? "")
                    } else {
                        content.verticalSV.editRightSide(tickerName: tickerSymbol, price: 0, about: items?.stockAboutDescription ?? "xx", type: items?.sector ?? "xx", marketCap: items?.marketCap ?? "xx", volume: "xx", PERatio: items?.peRatio ?? "", EPS: items?.eps ?? "")
 
                    }
                }
            case .failure(let error):
                // otherwise, print an error to the console
                print(error)
            }
        }
        
        
        // we update the volume, price
        
        API.getLatestpriceUsingNewEndpoing(tickerSymbol: tickerSymbol) { res in
            switch res {
            case .success(let latestTrade):
                DispatchQueue.main.async {
                    print(latestTrade?.trade?.p)
                    if isLeft {
                        content.configureLeft(price: (latestTrade?.trade?.p)!, volume: "")
                    } else {
                        content.configureRight(price: (latestTrade?.trade?.p)!, volume: "")
                    }
                }
                break
            case .failure(let error):
                break
            }
        }
        
        
//        API.getLatestStockPrice(tickerSymbol: tickerSymbol) { result in
//            switch result {
//            case .success(let items):
//                DispatchQueue.main.async {
//                    // update the price and
//                    // so here we know we have items
//                    if let items = items {
//                        if isLeft {
//                            content.configureLeft(price: Double(items.globalQuote.the05Price) ?? 0.00, volume: items.globalQuote.the06Volume)
//                        } else {
//                            content.configureRight(price: Double(items.globalQuote.the05Price) ?? 0.00, volume: items.globalQuote.the06Volume)
//                        }
//                    }
//                }
//            case .failure(let error):
//                // otherwise, print an error to the console
//                print(error)
//            }
//        }
    }
    
    
    init(stocksToBeCompared: [String]) {
        super.init(nibName: nil, bundle: nil)
        
        getThePrice(tickerSymbol: stocksToBeCompared[0], content: contentView, isLeft: true)
        // gets the info for the right side
        
        
        getThePrice(tickerSymbol: stocksToBeCompared[1], content: contentView, isLeft: false)
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
