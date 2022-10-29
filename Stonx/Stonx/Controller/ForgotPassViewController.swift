//
//  ForgotPassViewController.swift
//  Stonx
//
//  Created by Angel Zambrano on 10/27/22.
//

import UIKit
import Parse

// TODO: present error as alert if email does not exist in our database.

class ForgotPassViewController: UIViewController {
    
    private let emailTextfield = TextField()
    
    
    private let resetButton = UIButton(type: .system)
    
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
        view.addSubview(resetButton)
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.backgroundColor = ColorConstants.green
        resetButton.setTitle("reset password", for: .normal)
        resetButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        resetButton.layer.cornerRadius = 25
        resetButton.tintColor = .white
        resetButton.addTarget(self, action: #selector(resetButtonWasPressed), for: .touchUpInside)
        
    }
    
    
    // this is called whenever we want to reset our account
    @objc private func resetButtonWasPressed() {
        // TODO: if account with this email exists already, present error as an alert..
        
        if let email = emailTextfield.text {
            // TODO: Check if email is valid
            let isValid = emailIsValidFormat(email: email)
            
            if isValid {
                forgotPassword(with: email)
            } else {
                
            }
        
        } else {
            // Throw
        }
        
        
    }
    
    private func emailIsValidFormat(email: String) -> Bool{
        return false
    }
    
    
    
    // add forgot password
    private func forgotPassword(with validEmail: String) {
        PFUser.requestPasswordResetForEmail(inBackground: validEmail)
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
            resetButton.topAnchor.constraint(equalTo: emailTextfield.bottomAnchor, constant: padding),
            resetButton.leadingAnchor.constraint(equalTo: emailTextfield.leadingAnchor),
            resetButton.trailingAnchor.constraint(equalTo: emailTextfield.trailingAnchor),
            resetButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    

    
}
