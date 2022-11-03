//
//  SearchStocksViewController.swift
//  Stonx
//
//  Created by Angel Zambrano on 10/22/22.
//

import UIKit

class SearchStocksViewController: UIViewController, UISearchControllerDelegate, UITextFieldDelegate {
    
    // MARK: Properties
    
    private  let searchController = UISearchController(searchResultsController: nil)
    
    private let tableview = UITableView(frame: .zero, style: .grouped)
    
    private var searching = false
    
    private var filteredStocks = [BestMatch]()
    
    
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
        
        
        
        // this is how you use the API 

        
        
        
        
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
        
//        tableview.backgroundColor = .red
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
                print(error)
            }
        }
        
        self.tableview.reloadData()
        
    }
    

    
    
    

    private func setUpConstrainrs() {
        tableview.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
    }
    

}

//
extension SearchStocksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredStocks.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchStockTableviewCell.identifier, for: indexPath) as! SearchStockTableviewCell
        var match = filteredStocks[indexPath.row]
        print(match.the1Symbol, " ",match.the1Symbol.count )
        cell.configure(ticker: match.the1Symbol, fullName: match.the2Name, market:   match.the4Region)
        return cell
    }
    
    
}

extension SearchStocksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = StocksViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
