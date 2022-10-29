//
//  SettingsViewcontrollerViewController.swift
//  Stonx
//
//  Created by Angel Zambrano on 10/29/22.
//

import UIKit
import Parse

class SettingsViewcontrollerViewController: UIViewController, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let c = UITableViewCell(style: .default, reuseIdentifier: "cell")
        
        let setting = settings[indexPath.row]
        print(setting)
        
        ["Personal info", "Balance", "retire", "delete Account", "Turn off the Lights Off"]
        
        switch setting {
        case "Personal info":
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UITableViewCell
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.text = settings[indexPath.row]
            return cell
        case "Balance":
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UITableViewCell
            return cell
        case "retire":
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UITableViewCell
            cell.textLabel?.text = settings[indexPath.row]
            return cell
        case "delete Account":
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UITableViewCell
            cell.textLabel?.text = settings[indexPath.row]

            return cell
        case "Turn off the Lights Off":
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UITableViewCell
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UITableViewCell

            return cell
        }
        
        
  
        
        

    }
    

    let logOutButton = UIButton(type: .system)
    private var settingsTableviw: UITableView = UITableView(frame: .zero, style: .grouped)
    
    let settings = ["Personal info", "Balance", "retire", "delete Account", "Turn off the Lights Off"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        
//        view.addSubview(logOutButton)
//        logOutButton.setTitle("log out", for: .normal)
//        logOutButton.translatesAutoresizingMaskIntoConstraints = false
//        logOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        logOutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        logOutButton.addTarget(self, action: #selector(logOutButtonWasPressed), for: .touchUpInside)
        
        setUpViews()
        setUpConstraints()
    }
    
    // setting  up the tableview
   private func setUpViews() {
        settingsTableviw.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//       settingsTableviw.register(<#T##cellClass: AnyClass?##AnyClass?#>, forCellReuseIdentifier: <#T##String#>)
        settingsTableviw.translatesAutoresizingMaskIntoConstraints = false
        settingsTableviw.dataSource = self
        settingsTableviw.backgroundColor = .red
        view.addSubview(settingsTableviw)
    }
    
    //
    private func setUpConstraints() {
        settingsTableviw.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
    }


    
    
    
    
    @objc func logOutButtonWasPressed() {
        PFUser.logOut()
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let delegate = windowScene.delegate as? SceneDelegate else {return}
        
        let vc = UINavigationController(rootViewController: LoginViewController())
        delegate.window?.rootViewController = vc
        
    }
    
    
    

}

