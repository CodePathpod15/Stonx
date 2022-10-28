//
//  WatchListViewController.swift
//  Stonx
//
//  Created by Angel Zambrano on 10/22/22.
//

import UIKit

// filter
class Filter {
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
    private let cellPadding: CGFloat = 8
    private var filters: [Filter] = [] // the filters
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        title = "Watch List"
        filters = [Filter(name:"Industry 1", selected:  false), Filter(name:"industry 2", selected:  false), Filter(name:"industry 3", selected:  false), Filter(name:"industry 4", selected:  false)]
        
      
        
        setUpViews()
        setUpConstraints()
    }
    
    
    //MARK: setting up the layout of the UI
    
    private func setUpViews() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = cellPadding
        layout.minimumLineSpacing = cellPadding
        
        
        filtCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        filtCollectionView.translatesAutoresizingMaskIntoConstraints = false
        filtCollectionView.backgroundColor = .red
        
        
        // setting up the filter collection view
        filtCollectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: FilterCollectionViewCell.identifier)
        
        filtCollectionView.dataSource = self
        filtCollectionView.delegate = self
        

        view.addSubview(filtCollectionView)
    }
    

    private func setUpConstraints() {
        // setting up the constraints
        let collectionViewPadding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            filtCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: collectionViewPadding),
           filtCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: collectionViewPadding),
           filtCollectionView.heightAnchor.constraint(equalToConstant: 60),
           filtCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -collectionViewPadding)
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
