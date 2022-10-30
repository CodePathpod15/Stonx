//
//  StockViewController.swift
//  Stonx
//
//  Created by Angel Zambrano on 10/30/22.
//

import UIKit
import Parse
/// this contains a single view controller
class StockViewController: UIViewController {
    
    var stock: PFObject? = nil
    
    // Initializers
       init(stock: PFObject) {
           super.init(nibName: nil, bundle: nil)
           self.stock = stock
       }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

    }

}
