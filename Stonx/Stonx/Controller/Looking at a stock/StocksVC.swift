//
//  StocksVC.swift
//  Stonx
//
//  Created by Angel Zambrano on 11/25/22.
//

import UIKit


class StocksVC: UIViewController {
    let scrollView = UIScrollView()
    let contentView = StkContentView(frame: .zero)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setUpViews()
        // Do any additional setup after loading the view.
    }
    
    func setUpViews() {
        view.addSubview(scrollView)
        title = "IBM"


//        contentView.btn.addTarget(self, action: #selector(btnPressed), for: .touchUpInside)

        

        
        view.addSubview(scrollView)

        
        scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)

  
        // add content view
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor)

        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
        
    }
    @objc func btnPressed() {
        print("here")
    }

    

  

}
