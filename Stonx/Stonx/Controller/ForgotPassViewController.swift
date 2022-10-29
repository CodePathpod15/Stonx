//
//  ForgotPassViewController.swift
//  Stonx
//
//  Created by Angel Zambrano on 10/27/22.
//

import UIKit

// TODO: present error as alert if email does not exist in our database.

class ForgotPassViewController: UIViewController {
    
    private let emailTextfield = TextField()
    
    
    private let createAccButton = UIButton(type: .system)
    
    let whatIsYourEmail: UILabel = {
        let lbl = UILabel()
        lbl.text = "What is your Email?"
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
        view.addSubview(emailTextfield)
        emailTextfield.translatesAutoresizingMaskIntoConstraints = false
        
    
        // set up for textfield
        setUpTextfield(textfield: emailTextfield, defaultText: "Enter your email")
        
                
        // adding button
        // set up loginButton
        view.addSubview(createAccButton)
        createAccButton.translatesAutoresizingMaskIntoConstraints = false
        createAccButton.backgroundColor = ColorConstants.green
        createAccButton.setTitle("reset password", for: .normal)
        createAccButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        createAccButton.layer.cornerRadius = 25
        createAccButton.tintColor = .white
        createAccButton.addTarget(self, action: #selector(createAccButtonWasPressed), for: .touchUpInside)
        
    }
    
    
    @objc private func createAccButtonWasPressed() {
        // TODO: if account with this email exists already, present error as an alert..
    }
    
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
            emailTextfield.topAnchor.constraint(equalTo: whatIsYourEmail.bottomAnchor, constant: padding),
            emailTextfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            emailTextfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            emailTextfield.heightAnchor.constraint(equalToConstant: 41)
        ])
        
     
        
        
        // adding log in button
        NSLayoutConstraint.activate([
            // constraints top anchor of email to the bottom anchor of the image field with padding of 32
            createAccButton.topAnchor.constraint(equalTo: emailTextfield.bottomAnchor, constant: padding),
            createAccButton.leadingAnchor.constraint(equalTo: emailTextfield.leadingAnchor),
            createAccButton.trailingAnchor.constraint(equalTo: emailTextfield.trailingAnchor),
            createAccButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    

    
}
