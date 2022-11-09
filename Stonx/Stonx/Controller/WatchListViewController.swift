//
//  WatchListViewController.swift
//  Stonx
//
//  Created by Angel Zambrano on 10/22/22.
//

import UIKit

class WatchListViewController: UIViewController {
    
    // MARK: properties
    // adding the collection view
    private var filtCollectionView: UICollectionView! // the filter collection view
    private var stocksTableview: UITableView = UITableView(frame: .zero, style: .grouped)
    private let cellPadding: CGFloat = 8
    private var filters: [Filter] = [] // the filters
    private var stocks: [Stock] = [Stock]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        title = "Watch List"
        
        getFilterData()
        
        setUpViews()
        setUpConstraints()
        
        // this gets the user watchlist
        getTheUserWatchList()
        
    }
    
    
    func getTheUserWatchList() {
        ParseModel.shared.gettingUserWatchlist { result in
            switch result {
            case .success(let stocks):
                // if we have the stocks saved
                if let stocks = stocks {
                   
                    DispatchQueue.main.async {
                        self.stocks = stocks
                        self.stocksTableview.reloadData()
                        }
                    
                }
                
                break
            case .failure(let error):
                self.showAlert(with: error.localizedDescription)
                break
            }
        }
    }
    
    func getTheUserWatchList(with sector: String) {
        
        ParseModel.shared.gettingUserWatchlist(bysector:sector) { result in
            switch result {
            case .success(let stocks):
                stocks?.forEach({print($0.ticker_symbol)})
                break
            case .failure(let error):
                self.showAlert(with: error.localizedDescription)
                break
            }
        }
        
        }
    

    
    
    
    
    // here we will call the api to get all of the data
    func getFilterData() {
        filters = [Filter(name:"all", selected:  false), Filter(name:"industry 2", selected:  false), Filter(name:"industry 3", selected:  false), Filter(name:"industry 4", selected:  false)]
        
    }
    
    
    
    //MARK: setting up the layout of the UI
    
    private func setUpViews() {
        // collection view set up
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = cellPadding
        layout.minimumLineSpacing = cellPadding
        
        
        filtCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        filtCollectionView.translatesAutoresizingMaskIntoConstraints = false
        filtCollectionView.backgroundColor = .clear
        
        
        // registering a cell
        filtCollectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: FilterCollectionViewCell.identifier)
        
        filtCollectionView.dataSource = self
        filtCollectionView.delegate = self
        
        view.addSubview(filtCollectionView)
        
        // setting up the tableview
    
        view.addSubview(stocksTableview)
//        stocksTableview.backgroundColor = .red
        stocksTableview.alwaysBounceVertical = false
        stocksTableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        stocksTableview.register(StockTableViewCell.self, forCellReuseIdentifier: StockTableViewCell.identifier)
        stocksTableview.translatesAutoresizingMaskIntoConstraints = false
        stocksTableview.backgroundColor = .clear
        
        stocksTableview.dataSource = self
        stocksTableview.delegate = self
        
//        view.backgroundColor = .systemGray6
        
    }
    

    private func setUpConstraints() {
        // setting up the constraints for filter collectionview cell
        let collectionViewPadding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            filtCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: collectionViewPadding),
           filtCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: collectionViewPadding),
           filtCollectionView.heightAnchor.constraint(equalToConstant: 60),
           filtCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -collectionViewPadding)
               ])
        
        // setting up the tableview
        NSLayoutConstraint.activate([
            stocksTableview.topAnchor.constraint(equalTo: filtCollectionView.bottomAnchor),
            stocksTableview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stocksTableview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stocksTableview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
}


extension WatchListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCollectionViewCell.identifier, for: indexPath) as! FilterCollectionViewCell
        
        cell.configure(filter: filters[indexPath.item])

        return cell

    }
    
}

extension WatchListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          
          if collectionView == self.filtCollectionView {
              let label = UILabel(frame: CGRect.zero)
              label.text = filters[indexPath.item].name
              label.sizeToFit()
              let size = label.frame.width

              return CGSize(width: size + 12, height: 32 )
          }
          
        return CGSize(width: 0, height: 0)

      }
}

extension WatchListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return filters.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks.count
    }
  
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return filters[section].name
    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StockTableViewCell.identifier, for: indexPath) as! StockTableViewCell
        cell.configure(with: stocks[indexPath.row].ticker_symbol, sharesOwned: 0, price: 0)
        
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

extension WatchListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tb = StocksViewController()
        navigationController?.pushViewController(tb, animated: true)
    }

}
