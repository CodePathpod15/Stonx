//
//  SettingsViewcontrollerViewController.swift
//  Stonx
//
//  Created by Angel Zambrano on 10/29/22.
//

import UIKit
import Parse

class SettingsViewcontrollerViewController: UIViewController, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let c = UITableViewCell(style: .default, reuseIdentifier: "cell")
        
        let setting = settings[indexPath.row]
        
        
        
        switch setting {
        case "Personal info":
            let cell = tableView.dequeueReusableCell(withIdentifier: generalSettingsTableViewCell.identifier, for: indexPath) as! generalSettingsTableViewCell
            cell.layoutMargins = UIEdgeInsets.zero
            
            cell.accessoryType = .disclosureIndicator
            cell.configure(with: settings[indexPath.row])
//            cell.textLabel?.text =
//            print(cell.separatorInset.left)
        
            return cell
        case "Balance":
            let cell = tableView.dequeueReusableCell(withIdentifier: BalanceTableViewCell.identifier, for: indexPath) as! BalanceTableViewCell
            // configuring the title
            cell.accessoryType = .disclosureIndicator
            cell.layoutMargins = UIEdgeInsets.zero
            
            
            cell.configure(with: settings[indexPath.row])
           
//            cell.textlabe
            return cell
        case "retire":
            let cell = tableView.dequeueReusableCell(withIdentifier: generalSettingsTableViewCell.identifier, for: indexPath) as! generalSettingsTableViewCell
            cell.layoutMargins = UIEdgeInsets.zero
            
            cell.configure(with: settings[indexPath.row])
            
            return cell
        case "delete Account":
            let cell = tableView.dequeueReusableCell(withIdentifier: generalSettingsTableViewCell.identifier, for: indexPath) as! generalSettingsTableViewCell
            cell.layoutMargins = UIEdgeInsets.zero
            
            cell.configure(with: settings[indexPath.row])
            
            return cell
        case "Turn off the Lights Off":
            let cell = tableView.dequeueReusableCell(withIdentifier: DarkModeTableViewCell.identifier, for: indexPath) as! DarkModeTableViewCell
            cell.layoutMargins = UIEdgeInsets.zero
            
            
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
        title = "Settings"
        
        
        settingsTableviw.layoutMargins = UIEdgeInsets.zero
        settingsTableviw.separatorInset = UIEdgeInsets.zero
        
        
        
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
       
       let rbutton = UIBarButtonItem(title: "Log out", style: .plain, target: self, action: #selector(logOutButtonWasPressed))
       let rightButton: UIBarButtonItem = rbutton
       self.navigationItem.rightBarButtonItem = rightButton
       
       
       
        settingsTableviw.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
       settingsTableviw.register(generalSettingsTableViewCell.self, forCellReuseIdentifier: generalSettingsTableViewCell.identifier)
        settingsTableviw.register(BalanceTableViewCell.self, forCellReuseIdentifier: BalanceTableViewCell.identifier)
        settingsTableviw.register(DarkModeTableViewCell.self, forCellReuseIdentifier: DarkModeTableViewCell.identifier)
        settingsTableviw.translatesAutoresizingMaskIntoConstraints = false
        settingsTableviw.dataSource = self
       settingsTableviw.delegate = self
//        settingsTableviw.backgroundColor = .red
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
    
    //
    
    enum UserAction {
        case delete
        case retire
    }
    
    private func presentingAlertWithDestruction(action: UserAction) {
        
        let title = action == .delete ? "Deleting Account" : "Going bankrupt"
        let supportingText = action == .delete ? "Are you sure you want to delete your account?" : "You will be resetting all of your transactions"
        
        let nActionTitle = action == .delete ? "Delete Account" : "Reset"
        
        
        let alertController: UIAlertController = UIAlertController(title: title, message: supportingText, preferredStyle: .alert)

            //cancel button
            let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
                //cancel code
                
            }
            alertController.addAction(cancelAction)

            //Create an optional action
        let nextAction: UIAlertAction = UIAlertAction(title: nActionTitle, style: .destructive) { action -> Void in
                
                
                // TODO: delete user
                // take them to home page
            
            
                // TODO: reset the user's transactions
                //
                
            }
        
            alertController.addAction(nextAction)
        
    
        present(alertController, animated: true)
    }
    
    
    
    

}


extension SettingsViewcontrollerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let setting = settings[indexPath.row]
        switch setting {
        case "Personal info":
            let personalInfoVC = PersonalnfoViewController()
            navigationController?.pushViewController(personalInfoVC, animated: true)
            
            break
        case "Balance":
            let personalInfoVC = ModifyBalanceViewController()
            navigationController?.pushViewController(personalInfoVC, animated: true)
            
            break
        case "retire":
            presentingAlertWithDestruction(action: .retire)
            break
        case "delete Account":
            presentingAlertWithDestruction(action: .delete)
            break
        case "Turn off the Lights Off":
            
            break
            
        default:
            return
        }
    }
}
