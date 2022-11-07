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
    let settingConstants = [UserConstants.username, UserConstants.fullname]
    let currentUser = PFUser.current()!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        
        viewSetups()
        addconstraints()
    }
    
    // MARK: setting up the UI
    private func viewSetups(){
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

// conforming to the data source
extension PersonalnfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BalanceTableViewCell.identifier, for: indexPath) as! BalanceTableViewCell
        // configuring the title
        if indexPath.row == 0 {
                   cell.accessoryType = .disclosureIndicator
                   cell.configure(with: "Username")
                   cell.configure(name: currentUser.username!)
                   return cell
               } else {
                   cell.accessoryType = .disclosureIndicator
                   cell.configure(with: "full name")

                   // TODO: clean this up
                   if currentUser.value(forKey: "full_name") as? String  == nil {
                       cell.configure(name: "")
                   } else {
                       cell.configure(name:  currentUser.value(forKey: "full_name") as! String)
                   }

                   cell.isUserInteractionEnabled = true
               }

            return cell
        
    }
    
    
}

// conforming to the delegate
extension PersonalnfoViewController: UITableViewDelegate {
    // you might want to get the name of the user from parse and show it in the textfield
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        alertToUpdateParseAttribute(at: indexPath)
    }
    
    // helper method to display
    func alertToUpdateParseAttribute(at indexpath: IndexPath) {
           let name = settings[indexpath.row]
           let parseColumnName = settingConstants[indexpath.row]

           let alertController = UIAlertController(title: "Editing \(name)", message: "", preferredStyle: .alert)

           // cancel button
           let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
               // cancel code
           }

           alertController.addAction(cancelAction)

           let nextAction = UIAlertAction(title: "Ok", style: .default) { _ in
               let text = (alertController.textFields?.first as! UITextField).text

               //
               self.currentUser[parseColumnName] = text
               self.currentUser.saveInBackground() { success, error in
                   if success {
                       self.tableview.reloadData()
                   }

               }
           }

           alertController.addAction(nextAction)

           alertController.addTextField { textField in
               textField.placeholder = "Enter \(name)"
           }

           present(alertController, animated: true)
    }
}
