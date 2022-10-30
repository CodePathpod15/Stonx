//
//  WatchListViewController.swift
//  Stonx
//
//  Created by Angel Zambrano on 10/22/22.
//

import UIKit
import Parse

// filter
class Filter: Comparable {
    // DO not use this
    static func < (lhs: Filter, rhs: Filter) -> Bool {
        return false
    }
    
    // checking if two filters are the same
    static func == (lhs: Filter, rhs: Filter) -> Bool {
        return  lhs.name == rhs.name
    }
    
    var name: String
    var selected: Bool = false
    
    init(name: String, selected: Bool) {
        self.name = name
        self.selected = selected
    }
    
    func isSelected() ->Bool {
        return selected
    }
    
}


class WatchListViewController: UIViewController {
    
    
    // MARK: properties
    
    // adding the collection view
    private var filtCollectionView: UICollectionView! // the filter collection view
    private var stocksTableview: UITableView = UITableView(frame: .zero, style: .grouped)
    private let cellPadding: CGFloat = 8
    private var filters: [Filter] = [] // the filters
    
    var stocks = [PFObject]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        title = "Watch List"
        
        getFilterData()
        
        setUpViews()
        setUpConstraints()
        getData()
    }
    
    // ths is how you would get all of user
    func getData() {
        // First get the data from here
        
        let query = PFQuery(className:"stocks_booked")
        query.whereKey("user", equalTo:PFUser.current()!)
        
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if let error = error {
                // Log details of the failure
                print(error.localizedDescription)
            } else if let objects = objects {
                // The find succeeded.
                
                self.stocks = objects
                self.stocksTableview.reloadData()

                // initializing sectors
                self.filters = [Filter(name:"all", selected:  false)]

                for object in objects {
                    let sector = object["sector"] as! String
                    let filter = Filter(name: sector, selected: false)
                    if !self.filters.contains(filter) {
                        self.filters.append(filter)
                    }
                
                }
                self.filtCollectionView.reloadData()
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

        
        stocksTableview.dataSource = self
        stocksTableview.delegate = self
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
            stocksTableview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stocksTableview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stocksTableview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
    
    
    // We might have to do something here to make sure data gets here on time 
    func configure(cell: StockTableViewCell, indexpath: IndexPath) {
        
        let stock = stocks[indexpath.row]
        let nStock = stock["ticker_symbol"] as! String
        print(nStock)
    
        // getting the correct name
        API.getStockAboutMe(tickerSymbol: nStock) { result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    let fullName = items!.name
                    cell.configureName(stockName: nStock, fullStockName: fullName! )
                   
                }
            case .failure(let error):
                // otherwise, print an error to the console
                print(error)
            }
        }
        
        
        // getting the correct price
        API.getLatestStockPrice(tickerSymbol: nStock) { result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    cell.configure(stockPrice: Double(items!.globalQuote.the05Price)!, priceChange: items!.globalQuote.the10ChangePercent)
                }
                break

            case .failure(let error):
                print(error)
                break
                // otherwise, print an error to the console
            }
        }
        
        
        
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
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks.count
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return filters[section].name
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StockTableViewCell.identifier, for: indexPath) as! StockTableViewCell
        configure(cell: cell, indexpath: indexPath)
        
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
        // we should probably pass the PFObject as
        let vc  = StockViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
   
}


