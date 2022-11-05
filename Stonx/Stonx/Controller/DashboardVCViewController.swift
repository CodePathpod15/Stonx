//
//  DashboardVCViewController.swift
//  Stonx
//
//  Created by Angel Zambrano on 11/5/22.
//

import UIKit


class DashboardVCViewController: UIViewController {
    let scrollView = UIScrollView()
    let contentView = DashboardContentView(frame: .zero)
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        overrideUserInterfaceStyle = .dark
//        navigationController?.overrideUserInterfaceStyle =  .dark
        view.backgroundColor = .white
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
