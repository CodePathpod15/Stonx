//
//  SearchStocksViewController.swift
//  Stonx
//
//  Created by Angel Zambrano on 10/22/22.
//

import UIKit

protocol ComparisonStock: AnyObject {
    func sendTicker(str: BestMatch)
}

// three dots to compare icon
// if clicked we pop a search bar with the user being able to search for a stock  and boom
class SearchStocksViewController: UIViewController, UISearchControllerDelegate, UITextFieldDelegate, ComparisonStock, UINavigationControllerDelegate {
    
    // MARK: Properties
    
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    
    private let tableview = UITableView(frame: .zero, style: .grouped)
    fileprivate var stocksTobeCompared = [String]()
    
    private var searching = false
    
    // I want to use this in my extension
    fileprivate var filteredStocks = [BestMatch]()
    
   // MARK: This is how you do an initializer

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
       
        if let textfield = textField.text {
            // we fetch the stocks using the api
            fetchStocks(query: textfield)
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        title = "Search"
        setUpViews()
        setUpConstrainrs()
    
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }

    
    
    func sendTicker(str: BestMatch) {
        stocksTobeCompared.append(str.the1Symbol)

        navigationController?.pushViewController(ComparisonViewController(stocksToBeCompared: stocksTobeCompared), animated: true)
        print("you send data back", str.the1Symbol)
    }
    
    
    func setUpViews() {
        // setting up the search contronller
        navigationItem.searchController = searchController
        
        // TODO: enable searching
         searchController.delegate = self
        
        searchController.searchBar.searchTextField.delegate = self
        
        // set up tableview
        view.addSubview(tableview)
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableview.register(SearchStockTableviewCell.self, forCellReuseIdentifier: SearchStockTableviewCell.identifier)

        
        tableview.dataSource = self
        tableview.delegate = self
        tableview.translatesAutoresizingMaskIntoConstraints = false
        
        
    }
    
    // getting the stock using the query
    
    func fetchStocks(query: String){

        API.search(searchingString: query) { result in
            
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    // updae UI here and data. reload stuff etc
                    // making sure that we have matches
                    print("Note", items?.Note)
                    
                    if let matches = items?.bestMatches {
                        self.filteredStocks = matches
                        
                    // MARK: refactor this
                    self.filteredStocks.removeAll { bestMatch in
                        return (bestMatch.the8Currency != "USD")
                    }
                    
                    self.filteredStocks.removeAll { bestMatch in
                        return (bestMatch.the4Region != "United States")
                    }
                         
                        self.tableview.reloadData()
                    }
                    
                }
            case .failure(let error):
                // otherwise, print an error to the console
                DispatchQueue.main.async {
                    switch error {
                    case APIERRORS.limit:
                        self.showAlert(with: "You have reached the five api calls per minute or 500 api calls per day")
                        break
                    default:
                        self.showAlert(with: error.localizedDescription)
                        break
                    }
                }
  
            }
        }
        
        self.tableview.reloadData()
    }
    



     func setUpConstrainrs() {
        tableview.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
    }
}




extension SearchStocksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredStocks.count
    }
  
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchStockTableviewCell.identifier, for: indexPath) as! SearchStockTableviewCell
        cell.delegate = self
        var match = filteredStocks[indexPath.row]
        cell.configure(ticker: match.the1Symbol, fullName: match.the2Name, market:   match.the4Region)
        cell.enableCompareButton(with: true)
        return cell
    }
    
}

extension SearchStocksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let bestMatch = filteredStocks[indexPath.row]
        let vc = StocksViewController(stockInfo: bestMatch)
        navigationController?.pushViewController(vc, animated: true)

    }
}


// TODO: we have to get the two stock names

extension SearchStocksViewController: ComparisonDelegate {
    func compareButtonWasPressed(with ticker: String) {
        stocksTobeCompared.removeAll()
        stocksTobeCompared.append(ticker)
        let vc = VC()
        vc.delegate = self
        let sv = UINavigationController(rootViewController: vc)
        
        sv.modalPresentationStyle = .formSheet
        self.present(sv, animated: true)
    
    }
   
}





// extending the search viewcontroller
class VC: SearchStocksViewController {
    weak var delegate: ComparisonStock?
    override func viewDidLoad() {
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        title = "Search"
        searchController.searchBar.showsCancelButton = false
        setUpViews()
        setUpConstrainrs()
    }
    
 
    
   
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let bestMatch = filteredStocks[indexPath.row]
        self.dismiss(animated: true)
        self.dismiss(animated: true)
        self.delegate?.sendTicker(str: bestMatch)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchStockTableviewCell.identifier, for: indexPath) as! SearchStockTableviewCell
        cell.delegate = self
        var match = filteredStocks[indexPath.row]
        cell.configure(ticker: match.the1Symbol, fullName: match.the2Name, market:   match.the4Region)
        cell.enableCompareButton(with: false)
        return cell
    }
}
