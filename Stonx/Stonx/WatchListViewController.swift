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


    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        title = "Watch List"
        
        
        setUpViews()
        setUpConstraints()
    }
    
    
    //MARK: setting up the layout of the UI
    
    private func setUpViews() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = cellPadding
        layout.minimumLineSpacing = cellPadding
        
        // setting up the filter collection view
        
        filtCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        filtCollectionView.translatesAutoresizingMaskIntoConstraints = false
        filtCollectionView.backgroundColor = .red

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
