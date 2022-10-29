//
//  SettingsViewcontrollerViewController.swift
//  Stonx
//
//  Created by Angel Zambrano on 10/29/22.
//

import UIKit
import Parse

class SettingsViewcontrollerViewController: UIViewController {

    let logOutButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        
        view.addSubview(logOutButton)
        logOutButton.setTitle("log out", for: .normal)
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        logOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logOutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        logOutButton.addTarget(self, action: #selector(logOutButtonWasPressed), for: .touchUpInside)
        
    }
    
    @objc func logOutButtonWasPressed() {
        PFUser.logOut()
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let delegate = windowScene.delegate as? SceneDelegate else {return}
        
        let vc = UINavigationController(rootViewController: LoginViewController())
        delegate.window?.rootViewController = vc
        
    }
    
    
    

}
