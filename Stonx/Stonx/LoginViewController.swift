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

struct FontConstants {
    static let regularFont =  UIFont.systemFont(ofSize: 16)
    static let boldFont = UIFont.systemFont(ofSize: 16, weight: .bold)
    static let boldLargeFont = UIFont.systemFont(ofSize: 24, weight: .bold)
    static let cellSmallFont = UIFont.systemFont(ofSize: 12, weight: .regular)
}


class LoginViewController: UIViewController {
    
    // MARK: Properties
    private let logoImageField = UIImageView()
    
    private let emailTextfield = TextField()
    
    private let passWordTextfield = TextField()
    
    private let loginButton = UIButton(type: .system)
  

    private let dontHaveAccLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.text = "Dont have an account?"
        return lbl
    }()
    
    // this is a horizontal stack view that is used to hold the donthaveAccLbl and createAccbtn
    private let hstackview: UIStackView = {
        // setting the properties of the horizontal stack view
        let stackview: UIStackView = UIStackView()
        stackview.axis = .horizontal
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.spacing = 4
        return stackview
    }()
    
    /// vertical stack holds the hstackview and the forgotPass button
    private let vStackviw: UIStackView = {
        let stackview: UIStackView = UIStackView()
        stackview.axis = .vertical
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    private let createAcc: UIButton = {
        let button: UIButton = UIButton(type: .system)
        button.setTitle("Create Account", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        button.tintColor = ColorConstants.green
        button.addTarget(self, action: #selector(createAccButtonWasPressed), for: .touchUpInside)
        return button
    }()
    
    private let forgotPassword: UIButton = {
        let button: UIButton = UIButton(type: .system)
        button.setTitle("Forgot Your Password", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        button.tintColor = ColorConstants.green
        // TODO: add target for incorrect password
        button.addTarget(self, action: #selector(forgotPassButtonWasPressed), for: .touchUpInside)
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addViews()
        addConstraints()
        
    }
    
    let correctPss = false
    
    // MARK: IBactions
    
    @objc private func loginButtonWasPressed() {
        
        if correctPss {
            
        } else {
            showAlert()
        }
        

    }
    
    // This is called when button is pressed
    @objc private func forgotPassButtonWasPressed() {
        
        navigationController?.pushViewController(ForgotPassViewController(), animated: true)

    }
    
    @objc private func createAccButtonWasPressed() {
        navigationController?.pushViewController(CreateAnAccountViewcontroller(), animated: true)
    }
    
   
    
    // MARK: helper methods
    
    // you want to show an alert when password is wrong
    private func showAlert() {
        var dialogMessage = UIAlertController(title: "Confirm", message: "incorrect password", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            print("Ok button tapped")
         })
        
        //Add OK button to a dialog message
        dialogMessage.addAction(ok)
        // Present Alert to
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    
    
    /// general set up of our subviews
    private func addViews()
    {
   
        // setting the background color of the imagefield
        logoImageField.backgroundColor = .red
        
        // looping to add them to a
        
        [logoImageField, emailTextfield, passWordTextfield, loginButton].forEach { v in
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
        loginButton.addTarget(self, action: #selector(loginButtonWasPressed), for: .touchUpInside)
        
        
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
            logoImageField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            logoImageField.widthAnchor.constraint(equalToConstant: 224),
            logoImageField.heightAnchor.constraint(equalToConstant: 134),
            logoImageField.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        let padding: CGFloat = 32
        // adding constraints for the email textfield
        NSLayoutConstraint.activate([
            // constraints top anchor of email to the bottom anchor of the image field with padding of 32
            emailTextfield.topAnchor.constraint(equalTo: logoImageField.bottomAnchor, constant: padding),
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



// this is default textfield with left padding that I stole from stackoverflow
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
