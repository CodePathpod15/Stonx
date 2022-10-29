//
//  ViewController.swift
//  Stonx
//
//  Created by Angel Zambrano on 10/20/22.
//

import UIKit
import Parse




// TODO: show alert if password is incorrect 

class CreateAnAccountViewcontroller: UIViewController {
    
    // MARK: properties
    
    private let emailtxtField = TextField()
    
    private let usernametxtfield = TextField()
    
    private let passwordtxtField = TextField()
    

    private let createAccButton = UIButton(type: .system)
    
    
    
    let whatIsYourEmail: UILabel = {
        let lbl = UILabel()
        lbl.text = "What is your Info??"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = FontConstants.boldLargeFont
        return lbl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        
        addViews()
        addConstraints()
    }
    
    
    
    func setUpTextfield(textfield: UITextField, defaultText: String) {
        textfield.backgroundColor = ColorConstants.gray
        textfield.placeholder = defaultText
        textfield.layer.cornerRadius = 8
        textfield.layer.borderWidth = 1
        textfield.layer.borderColor = ColorConstants.darkerGray.cgColor
        textfield.font = UIFont.systemFont(ofSize: 16)
    }
    
    
    private func addViews() {
        view.addSubview(whatIsYourEmail)
        view.addSubview(emailtxtField)
        emailtxtField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(usernametxtfield)
        usernametxtfield.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(passwordtxtField)
        passwordtxtField.translatesAutoresizingMaskIntoConstraints = false
        passwordtxtField.isSecureTextEntry = true

        // set up for textfield
        setUpTextfield(textfield: emailtxtField, defaultText: "Enter your email")
        setUpTextfield(textfield: usernametxtfield, defaultText: "Enter your username")
        setUpTextfield(textfield: passwordtxtField, defaultText: "Enter your password")
        
        
        // adding button
        // set up loginButton
        view.addSubview(createAccButton)
        createAccButton.translatesAutoresizingMaskIntoConstraints = false
        createAccButton.backgroundColor = ColorConstants.green
        createAccButton.setTitle("Create Account", for: .normal)
        createAccButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        createAccButton.layer.cornerRadius = 25
        createAccButton.tintColor = .white
        createAccButton.addTarget(self, action: #selector(createAccountButtonWasPressed), for: .touchUpInside)
        
    }
    
    
    // this creates an account for the user 
    @objc private func createAccountButtonWasPressed() {
        // check if either of them is empty
        
        // make sure that email is correct format
        if !Validate.isValidEmail(emailtxtField.text ?? " ") || usernametxtfield.text == nil || usernametxtfield.text == nil {
            self.showAlert(with: "enter correct information")
            return
        }
        
        // create the account
        
        var user = PFUser()
        user.username = usernametxtfield.text
        user.email = emailtxtField.text
        user.password = passwordtxtField.text
        
        user.signUpInBackground {
            (succeeded: Bool, error: Error?) -> Void in
            if let error = error {
              let errorString = error.localizedDescription
              // Show the errorString somewhere and let the user try again.
                self.showAlert(with: errorString)
                // log the usr in
                
            } else {
            // Should I dimiss the previous viewcontroller?
            
            let FeedViewController = UINavigationController(rootViewController: TabBarController())
                FeedViewController.modalPresentationStyle = .fullScreen
            self.present(FeedViewController, animated: true)
                
                
            }
          }
        
        // TODO: if account with this email exists already, present error as an alert..
    }
    

//
    private func addConstraints() {
        // constraints for albel
        NSLayoutConstraint.activate([
            whatIsYourEmail.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 35),
            whatIsYourEmail.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 27)
        ])
        
        let padding: CGFloat = 32
        // adding constraints for the email textfield
        NSLayoutConstraint.activate([
            // constraints top anchor of email to the bottom anchor of the image field with padding of 32
            emailtxtField.topAnchor.constraint(equalTo: whatIsYourEmail.bottomAnchor, constant: padding),
            emailtxtField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            emailtxtField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            emailtxtField.heightAnchor.constraint(equalToConstant: 41)
        ])
        
        // adding constraints for the password textfield
        NSLayoutConstraint.activate([
            // constraints top anchor of email to the bottom anchor of the image field with padding of 32
            usernametxtfield.topAnchor.constraint(equalTo: emailtxtField.bottomAnchor, constant: padding-15),
            usernametxtfield.leadingAnchor.constraint(equalTo: emailtxtField.leadingAnchor),
            usernametxtfield.trailingAnchor.constraint(equalTo: emailtxtField.trailingAnchor),
            usernametxtfield.heightAnchor.constraint(equalToConstant: 41)
        ])
        
        // adding the pasword textfield
        NSLayoutConstraint.activate([
            passwordtxtField.topAnchor.constraint(equalTo: usernametxtfield.bottomAnchor, constant: padding-15),
            passwordtxtField.leadingAnchor.constraint(equalTo: usernametxtfield.leadingAnchor),
            passwordtxtField.trailingAnchor.constraint(equalTo: usernametxtfield.trailingAnchor),
            passwordtxtField.heightAnchor.constraint(equalToConstant: 41)

        ])
        
        
        // adding log in button
        NSLayoutConstraint.activate([
            // constraints top anchor of email to the bottom anchor of the image field with padding of 32
            createAccButton.topAnchor.constraint(equalTo: passwordtxtField.bottomAnchor, constant: padding),
            createAccButton.leadingAnchor.constraint(equalTo: emailtxtField.leadingAnchor),
            createAccButton.trailingAnchor.constraint(equalTo: emailtxtField.trailingAnchor),
            createAccButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        
        
    }
    

}

