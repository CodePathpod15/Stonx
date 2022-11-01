//
//  PersonalnfoViewController.swift
//  Stonx
//
//  Created by Angel Zambrano on 10/31/22.
//

import UIKit

class PersonalnfoViewController: UIViewController {
    let tableview = UITableView(frame: .zero, style: .grouped)
    let settings = ["username", "full name"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        
        viewSetups()
        addconstraints()
    }
    
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PersonalnfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BalanceTableViewCell.identifier, for: indexPath) as! BalanceTableViewCell
        // configuring the title
        if indexPath.row == 0 {
            cell.accessoryType = .disclosureIndicator
            cell.configure(with: "username")
            cell.configure(name: "angelzzz23")
            return cell
        } else {
            cell.accessoryType = .disclosureIndicator
            cell.configure(with: "Full Name")
            cell.configure(name: "Angel Zambrano")
        }
        
        
        return cell
        
    }
    
    
}

extension PersonalnfoViewController: UITableViewDelegate {
    // you might want to get the name of the user from parse and show it in the textfield
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let setting = settings[indexPath.row]
        
        let alertController: UIAlertController = UIAlertController(title: "Editing \(setting)", message: "", preferredStyle: .alert)

            //cancel button
            let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
                //cancel code
                
            }
            alertController.addAction(cancelAction)

            //Create an optional action
        let nextAction: UIAlertAction = UIAlertAction(title: "Ok", style: .default) { action -> Void in
                let text = (alertController.textFields?.first as! UITextField).text
            
                // TODO: update this
                print(text)
                
            }
        
            alertController.addAction(nextAction)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter \(setting)"
        }
        
        present(alertController, animated: true)
    
        
    }
}
