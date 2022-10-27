//
//  LoginViewController.swift
//  Stonx
//
//  Created by Angel Zambrano on 10/22/22.
//

import UIKit

struct ColorConstants {
    static let gray = UIColor(red: 252/255, green: 252/255, blue: 253/255, alpha: 1)
    static let darkerGray = UIColor(red: 223/255, green: 223/255, blue: 230/255, alpha: 1)
    static let green = UIColor(red: 63/255, green: 191/255, blue: 160/255, alpha: 1)
}

class LoginViewController: UIViewController {
    
    // MARK: Properties
    private let imageField = UIImageView()
    
    private let emailTextfield = TextField()
    
    private let passWordTextfield = TextField()
    
    private let loginButton = UIButton(type: .system)
    // horitzontal stack view
    private let dontHaveAccLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Dont have an account?"
        return lbl
    }()
    
    private let hstackview: UIStackView = {
        // setting the properties of the horizontal stack view
        let stackview: UIStackView = UIStackView()
        stackview.axis = .horizontal
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.spacing = 4
        return stackview
    }()
    
    private let vStackviw: UIStackView = {
        let stackview: UIStackView = UIStackView()
        stackview.axis = .vertical
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    private let createAcc: UIButton = {
        let button: UIButton = UIButton(type: .system)
        button.setTitle("Create Account", for: .normal)
        return button
    }()
    
    private let forgotPassword: UIButton = {
        let button: UIButton = UIButton(type: .system)
        button.setTitle("Forgot Your Password", for: .normal)
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addViews()
        addConstraints()
        
        // Do any additional setup after loading the view.
    }
    
    
    // MARK: methods
    
    
    /// general set up of our subviews
    private func addViews()
    {
        
       
        
        
        // setting the background color of the imagefield
        imageField.backgroundColor = .red
        
        // looping to add them to a
        
        [imageField, emailTextfield, passWordTextfield, loginButton].forEach { v in
            // enable programatic constraints
            v.translatesAutoresizingMaskIntoConstraints = false
            // add view to subview
            view.addSubview(v)
        }
        
        // set up for textfield
        setUpTextfield(textfield: emailTextfield, defaultText: "Enter your email")
        setUpTextfield(textfield: passWordTextfield, defaultText: "Enter your password")
        
        // set up loginButton
        loginButton.backgroundColor = ColorConstants.green
        loginButton.setTitle("Log in", for: .normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        loginButton.layer.cornerRadius = 25
        loginButton.tintColor = .white
        
        
        // adding stackview
        view.addSubview(hstackview)
        hstackview.addArrangedSubview(dontHaveAccLbl)
        hstackview.addArrangedSubview(createAcc)
        
        
        // adding vertical stackview
        view.addSubview(vStackviw)
        vStackviw.addArrangedSubview(hstackview)
        vStackviw.addArrangedSubview(forgotPassword)
        
       
        
        
    }
    
    func setUpTextfield(textfield: UITextField, defaultText: String) {
        textfield.backgroundColor = ColorConstants.gray
        textfield.placeholder = defaultText
        textfield.layer.cornerRadius = 8
        textfield.layer.borderWidth = 1
        textfield.layer.borderColor = ColorConstants.darkerGray.cgColor
        textfield.font = UIFont.systemFont(ofSize: 16)
    }
    
    
    /// in charge of adding constraints to the view
    private func addConstraints() {
        // adding constraints for the imagefield
        NSLayoutConstraint.activate([
            imageField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            imageField.widthAnchor.constraint(equalToConstant: 224),
            imageField.heightAnchor.constraint(equalToConstant: 134),
            imageField.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        let padding: CGFloat = 32
        // adding constraints for the email textfield
        NSLayoutConstraint.activate([
            // constraints top anchor of email to the bottom anchor of the image field with padding of 32
            emailTextfield.topAnchor.constraint(equalTo: imageField.bottomAnchor, constant: padding),
            emailTextfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            emailTextfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            emailTextfield.heightAnchor.constraint(equalToConstant: 41)
        ])
        
        // adding constraints for the password textfield
        NSLayoutConstraint.activate([
            // constraints top anchor of email to the bottom anchor of the image field with padding of 32
            passWordTextfield.topAnchor.constraint(equalTo: emailTextfield.bottomAnchor, constant: padding-15),
            passWordTextfield.leadingAnchor.constraint(equalTo: emailTextfield.leadingAnchor),
            passWordTextfield.trailingAnchor.constraint(equalTo: emailTextfield.trailingAnchor),
            passWordTextfield.heightAnchor.constraint(equalToConstant: 41)
        ])
        
        
        
        // adding log in button
        NSLayoutConstraint.activate([
            // constraints top anchor of email to the bottom anchor of the image field with padding of 32
            loginButton.topAnchor.constraint(equalTo: passWordTextfield.bottomAnchor, constant: padding),
            loginButton.leadingAnchor.constraint(equalTo: emailTextfield.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: emailTextfield.trailingAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // adding the dont have account info
        NSLayoutConstraint.activate([
            vStackviw.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            vStackviw.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 23)
        ])
        
        
        
        
    }
    
    

 

}



// this is default textfield with left padding
// https://stackoverflow.com/questions/25367502/create-space-at-the-beginning-of-a-uitextfield
class TextField: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
