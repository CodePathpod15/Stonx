//
//  TransactionSuccessfulViewController.swift
//  Stonx
//
//  Created by Angel Zambrano on 11/2/22.
//

import UIKit

class TransactionSuccessfulViewController: UIViewController {

    let whiteVIew = UIView()
    let label: UILabel = {
       let titleLbl = UILabel()
        titleLbl.text = "APPL Purchased"
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        titleLbl.textColor = .white
        return titleLbl
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = ColorConstants.green
        viewSetUp()
        setUpContraints()
    }
    
    
    private func viewSetUp() {
        view.addSubview(label)
        
//        whiteVIew.backgroundColor = .white
    }
    
    
    private func setUpContraints() {
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 91).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        whiteVIew.anchor(top: <#T##NSLayoutYAxisAnchor?#>, leading: <#T##NSLayoutXAxisAnchor?#>, bottom: <#T##NSLayoutYAxisAnchor?#>, trailing: <#T##NSLayoutXAxisAnchor?#>)
    }


}
