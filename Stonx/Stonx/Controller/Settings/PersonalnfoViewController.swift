//
//  PersonalnfoViewController.swift
//  Stonx
//
//  Created by Angel Zambrano on 10/31/22.
//
import Parse
import UIKit

class PersonalnfoViewController: UIViewController {
    let tableview = UITableView(frame: .zero, style: .grouped)
    let settings = ["username", "full name"]
    let currentUser = PFUser.current()!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        viewSetups()
        addconstraints()
    }
        
    private func viewSetups() {
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.register(BalanceTableViewCell.self, forCellReuseIdentifier: BalanceTableViewCell.identifier)
        tableview.dataSource = self
        tableview.delegate = self
        view.addSubview(tableview)
    }
    
    private func addconstraints() {
        tableview.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
    }
}

extension PersonalnfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    // Username and email
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BalanceTableViewCell.identifier, for: indexPath) as! BalanceTableViewCell
        if indexPath.row == 0 {
            cell.accessoryType = .disclosureIndicator
            cell.configure(with: "Username")
            cell.configure(name: currentUser.username!)
            return cell
        } else {
            cell.accessoryType = .disclosureIndicator
            cell.configure(with: "email")
            cell.configure(name: currentUser.email!)
            cell.isUserInteractionEnabled = false
        }
        
        return cell
    }
}

extension PersonalnfoViewController: UITableViewDelegate {
    // you might want to get the name of the user from parse and show it in the textfield
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let setting = "Username"
            
            let alertController = UIAlertController(title: "Editing \(setting)", message: "", preferredStyle: .alert)

            // cancel button
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
                // cancel code
            }
            alertController.addAction(cancelAction)

            // Save the new username
            let nextAction = UIAlertAction(title: "Ok", style: .default) { _ in
                let text = (alertController.textFields?.first as! UITextField).text
                
                // 
                self.currentUser[UserConstants.username] = text
                self.currentUser.saveInBackground()
            }
            
            alertController.addAction(nextAction)
            
            alertController.addTextField { textField in
                textField.placeholder = "Enter \(setting)"
            }
            
            present(alertController, animated: true)
        }
    }
}
