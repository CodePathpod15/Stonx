//
//  ComparisonViewController.swift
//  Stonx
//
//  Created by Angel Zambrano on 11/9/22.
//

import UIKit

class ComparisonViewController: UIViewController {
    // adding the content view 
    let contentView = ComparisonView(frame: .zero)
    let scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        setUp()
    }
    
    func setUp() {
        view.addSubview(scrollView)
        title = "Dashboard"

        scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)

        // add content view
        scrollView.addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor)
        // :-)
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])


    }

}
