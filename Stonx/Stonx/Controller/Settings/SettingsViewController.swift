//
//  SettingsViewcontrollerViewController.swift
//  Stonx
//
//  Created by Angel Zambrano on 10/29/22.
//

import UIKit
import Parse

class SettingsViewController: UIViewController {

    // MARK: properties
    let logOutButton = UIButton(type: .system)
    private var settingsTableviw: UITableView = UITableView(frame: .zero, style: .grouped)
    var usBalance:Double = 0
    let settings = ["Personal info", "Balance"]
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getBalance()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Settings"
        getBalance()
        
        settingsTableviw.layoutMargins = UIEdgeInsets.zero
        settingsTableviw.separatorInset = UIEdgeInsets.zero
        
        setUpViews()
        setUpConstraints()
    }

    // MARK: setting up the UI
    
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

        view.addSubview(settingsTableviw)
    }
    
 
    private func setUpConstraints() {
        settingsTableviw.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
    }

    
    // MARK: helper methods
    
    /// getting the balance of the user using parse
    func getBalance() {
        let user  = PFUser.current()!
        user.fetchInBackground() {obj,err in
            if let obj = obj {
                let balance = obj.value(forKey:  UserConstants.balance) as? Double
                if let balance = balance {
                    self.usBalance = balance
                } else {
                    self.usBalance = 0
                }
                
                self.settingsTableviw.reloadData()
            } else {
                self.showAlert(with: "There was an error with your balance")
                
            }
        }
    }
    
    /// getting the balance of the user using parse
    @objc func logOutButtonWasPressed() {
        PFUser.logOut()
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let delegate = windowScene.delegate as? SceneDelegate else {return}
        
        let vc = UINavigationController(rootViewController: LoginViewController())
        delegate.window?.rootViewController = vc
        
    }
    
    enum UserAction {
        case delete
        case retire
    }
    
    // helper method to delete the user
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
                
            }
        
            alertController.addAction(nextAction)
        present(alertController, animated: true)
    }

}

// conforming to the delegate
extension SettingsViewController: UITableViewDelegate {
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

// conforming to the data sourc e
extension SettingsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let setting = settings[indexPath.row]
        switch setting {
        case "Personal info":
            let cell = tableView.dequeueReusableCell(withIdentifier: generalSettingsTableViewCell.identifier, for: indexPath) as! generalSettingsTableViewCell
            cell.layoutMargins = UIEdgeInsets.zero
            
            cell.accessoryType = .disclosureIndicator
            cell.configure(with: settings[indexPath.row])
            return cell
        case "Balance":
            let cell = tableView.dequeueReusableCell(withIdentifier: BalanceTableViewCell.identifier, for: indexPath) as! BalanceTableViewCell
            cell.configure(name: String(usBalance))
            
            cell.accessoryType = .disclosureIndicator
            cell.layoutMargins = UIEdgeInsets.zero
            
            cell.configure(with: settings[indexPath.row])
           
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
}
