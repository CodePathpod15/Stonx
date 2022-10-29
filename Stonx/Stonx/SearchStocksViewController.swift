//
//  SearchStocksViewController.swift
//  Stonx
//
//  Created by Angel Zambrano on 10/22/22.
//

import UIKit

// TODO: implement UISearchControllerDelegate

class SearchStocksViewController: UIViewController{
    
    // MARK: Properties
    
    private  let searchController = UISearchController(searchResultsController: nil)
    
    private let tableview = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        title = "Search"
        setUpViews()
        setUpConstrainrs()
    }
    
    func setUpViews() {
        // setting up the search contronller
        navigationItem.searchController = searchController
        
        // TODO: enable searching
        // searchController.delegate = self
        
        // set up tableview
        view.addSubview(tableview)
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableview.register(SearchStockTableviewCell.self, forCellReuseIdentifier: SearchStockTableviewCell.identifier)
        
//        tableview.backgroundColor = .red
        tableview.dataSource = self
        tableview.delegate = self
        tableview.translatesAutoresizingMaskIntoConstraints = false
        
        
    }
    
    
    
    

    private func setUpConstrainrs() {
        tableview.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
    }
    

}

//
extension SearchStocksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchStockTableviewCell.identifier, for: indexPath) as! SearchStockTableviewCell
        
        return cell
    }
    
    
}

extension SearchStocksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}
