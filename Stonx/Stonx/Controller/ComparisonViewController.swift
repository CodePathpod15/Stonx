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
                        content.verticalSV.editLeftSide(tickerName: tickerSymbol, about: items?.stockAboutDescription , type: items?.sector , marketCap: items?.marketCap, PERatio: items?.peRatio , EPS: items?.eps)
                    } else {
                        content.verticalSV.editRightSide(tickerName: tickerSymbol, about: items?.stockAboutDescription , type: items?.sector , marketCap: items?.marketCap, PERatio: items?.peRatio, EPS: items?.eps)
                    }
                }
                
            case .failure(let error):
                // otherwise, print an error to the console
                DispatchQueue.main.async {
                    switch error {
                    case APIERRORS.limit:
                        self.showAlert(with: "You have reached the five api calls per minute or 500 api calls per day")
                      
                    default:
                        self.showAlert(with: error.localizedDescription)
               
                    }
                }
            }
        }
        
        // we update the volume, price
        API.getLatestpriceUsingNewEndpoing(tickerSymbol: tickerSymbol) { res in
            switch res {
            case .success(let latestTrade):
                DispatchQueue.main.async {
                    if isLeft {
                        content.configureLeft(price: (latestTrade?.trade?.p)!, volume: "")
                    } else {
                        content.configureRight(price: (latestTrade?.trade?.p)!, volume: "")
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
             
            }
        }
    }
    
    
    init(stocksToBeCompared: [String]) {
        super.init(nibName: nil, bundle: nil)
        
        // get the price of the left side
        getThePrice(tickerSymbol: stocksToBeCompared[0], content: contentView, isLeft: true)
        // gets the info for the right side
        
        // get the price fo the right side 
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
