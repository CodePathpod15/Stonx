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
        tableview.backgroundColor = .red
        tableview.dataSource = self
        tableview.translatesAutoresizingMaskIntoConstraints = false
        
        
    }
    
    
    
    

    private func setUpConstrainrs() {
        tableview.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
    }
    

}

// 
extension SearchStocksViewController: UITableViewDataSource {
    
}
