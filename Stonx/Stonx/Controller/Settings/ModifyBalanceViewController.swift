//
//  ModifyBalanceViewController.swift
//  Stonx
//
//  Created by Angel Zambrano on 11/1/22.
//

import UIKit
import Parse

class ModifyBalanceViewController: UIViewController {
    // MARK: properties
    let tableview = UITableView(frame: .zero, style: .grouped)
    var usBalance:Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: .add, style: .plain, target: self, action:  #selector(addTapped))
        getBalance()
        
        
        view.backgroundColor = .white
        setUpViews()
        addingConstraints()
        self.title = "Adding Balance"
    }
    
    // MARK: UI set up
    private func setUpViews() {
        view.addSubview(tableview)
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableview.register(BalanceTableViewCell.self, forCellReuseIdentifier: BalanceTableViewCell.identifier)
        tableview.dataSource = self
    }
    
    private func addingConstraints() {
        //
        tableview.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        
    }

    // MARK: helper methods
    // getting the balance of the user
    func getBalance() {
        let user  = PFUser.current()!
        user.fetchInBackground() {obj,err in
            if let obj = obj {
                let balance = obj.value(forKey: UserConstants.balance) as? Double
                self.usBalance = balance!
                self.tableview.reloadData()
            } else {
                self.showAlert(with: "There was an error with your balance")
                
            }
        }
    }
    
    // we are going to present
    @objc func addTapped() {
        
        let alertController: UIAlertController = UIAlertController(title: "Adding Money", message: "", preferredStyle: .alert)

            //cancel button
            let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
                //cancel code
                
            }
            alertController.addAction(cancelAction)

            //Create an optional action
        let nextAction: UIAlertAction = UIAlertAction(title: "Ok", style: .default) { action -> Void in
                let text = (alertController.textFields?.first as! UITextField).text
                if text == nil {
                    return
                }
            
                if let convertedtext = Double(text!) {
                    let newBalance = self.usBalance + (convertedtext)
                    let usr = PFUser.current()!
                    usr[UserConstants.balance] = newBalance
                    
                    usr.saveInBackground() { success, error in
                        if success {
                            // do nothing
                            self.usBalance = newBalance
                            self.tableview.reloadData()
                        } else {
                            self.showAlert(with: error?.localizedDescription ?? "an error")
                        }
                    }
                }
                
                
            }
        
            alertController.addAction(nextAction)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Add money"
        }
        
        present(alertController, animated: true)
    }
    

}



extension ModifyBalanceViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BalanceTableViewCell.identifier, for: indexPath) as! BalanceTableViewCell
        cell.configure(with: "Balance")
        cell.configure(name: "$\(usBalance)")
      
        return cell
    }

}

