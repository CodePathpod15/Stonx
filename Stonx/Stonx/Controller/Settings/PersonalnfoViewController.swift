//
//  PersonalnfoViewController.swift
//  Stonx
//
//  Created by Angel Zambrano on 10/31/22.
//

import UIKit
import Parse
// TODO: present errors. For example when information is incorrect.
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
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        let query = PFQuery(className: "User")
//        query.includeKeys(["Username","Email"])
//        query.limit = 20
//
//        query.findObjectsInBackground { posts, _ in
//            if posts != nil {
//                self.posts = posts!
//                self.tableView.reloadData()
//            }
//        }
//
//    }
    
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
            cell.configure(with: "username")
            cell.configure(name: currentUser.username!)
            return cell
        } else {
            cell.accessoryType = .disclosureIndicator
            cell.configure(with: "Email")
            cell.configure(name: currentUser.email!)
        }
        
        return cell
    }
}

extension PersonalnfoViewController: UITableViewDelegate {
    // you might want to get the name of the user from parse and show it in the textfield
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let setting = settings[indexPath.row]
        
        let alertController = UIAlertController(title: "Editing \(setting)", message: "", preferredStyle: .alert)

        // cancel button
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            // cancel code
        }
        alertController.addAction(cancelAction)

        // Create an optional action
        let nextAction = UIAlertAction(title: "Ok", style: .default) { _ in
            let text = (alertController.textFields?.first as! UITextField).text
            if indexPath.row == 1{
                
                self.currentUser["Email"] = text
                self.currentUser.saveInBackground()
            }
            
            
        }
        
        alertController.addAction(nextAction)
        
        alertController.addTextField { textField in
            textField.placeholder = "Enter \(setting)"
        }
        
        present(alertController, animated: true)
    }
}
