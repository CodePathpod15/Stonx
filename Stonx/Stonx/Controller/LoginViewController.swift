//
//  LoginViewController.swift
//  Stonx
//
//  Created by Angel Zambrano on 10/22/22.
//

import UIKit
import Parse



class LoginViewController: UIViewController {
    
    // MARK: Properties
    private let logoImageField = UIImageView()
    
    private let usernameTextfield = TextField()
    
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
        setupViews()
        addConstraints()
        
    }
    
    // MARK: IBactions
    
    @objc private func loginButtonWasPressed() {
        
        // making sure text esits
        if usernameTextfield.text ==  "" || passWordTextfield.text == "" {
            self.showAlert(with: "enter valid email or password")
            return
        }
        
        PFUser.logInWithUsername(inBackground: usernameTextfield.text ?? "", password:passWordTextfield.text ?? "") {
          (user: PFUser?, error: Error?) -> Void in
          
            if user != nil {
            // Do stuff after successful login.
              let FeedViewController = TabBarController()
              FeedViewController.modalPresentationStyle = .fullScreen
              self.present(FeedViewController, animated: true)
          } else {
            // The login failed. Check error to see why.
              let err = error?.localizedDescription
              self.showAlert(with: err ?? "error")
          }
            
        }
        
    }
    
    
    // MARK: Navigation buttons
    
    // This is called when button is pressed
    @objc private func forgotPassButtonWasPressed() {
        
        navigationController?.pushViewController(ForgotPassViewController(), animated: true)

    }
    
    @objc private func createAccButtonWasPressed() {
        navigationController?.pushViewController(CreateAnAccountViewcontroller(), animated: true)
    }
    
   
   // MARK: view set up
    
    /// general set up of our subviews
    private func setupViews()
    {
   
        // setting the background color of the imagefield
        logoImageField.backgroundColor = .red
        
        // looping to add them to a
        
        [logoImageField, usernameTextfield, passWordTextfield, loginButton].forEach { v in
            // enable programatic constraints
            v.translatesAutoresizingMaskIntoConstraints = false
            // add view to subview
            view.addSubview(v)
        }
        // making textifled be password
        passWordTextfield.isSecureTextEntry = true
        
        // set up for textfield
        setUpTextfield(textfield: usernameTextfield, defaultText: "Enter your username")
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
            usernameTextfield.topAnchor.constraint(equalTo: logoImageField.bottomAnchor, constant: padding),
            usernameTextfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            usernameTextfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            usernameTextfield.heightAnchor.constraint(equalToConstant: 41)
        ])
        
        // adding constraints for the password textfield
        NSLayoutConstraint.activate([
            // constraints top anchor of email to the bottom anchor of the image field with padding of 32
            passWordTextfield.topAnchor.constraint(equalTo: usernameTextfield.bottomAnchor, constant: padding-15),
            passWordTextfield.leadingAnchor.constraint(equalTo: usernameTextfield.leadingAnchor),
            passWordTextfield.trailingAnchor.constraint(equalTo: usernameTextfield.trailingAnchor),
            passWordTextfield.heightAnchor.constraint(equalToConstant: 41)
        ])
        
        
        
        // adding log in button
        NSLayoutConstraint.activate([
            // constraints top anchor of email to the bottom anchor of the image field with padding of 32
            loginButton.topAnchor.constraint(equalTo: passWordTextfield.bottomAnchor, constant: padding),
            loginButton.leadingAnchor.constraint(equalTo: usernameTextfield.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: usernameTextfield.trailingAnchor),
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

// extending the viewcontronller parent class to containt this alert..
// got tired of writing this again and again and again!!! :(((
// UWU

extension UIViewController {
     func showAlert(with test: String) {
        var dialogMessage = UIAlertController(title: "Confirm", message: test, preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            // We dont print anything 
         })
        
        //Add OK button to a dialog message
        dialogMessage.addAction(ok)
        // Present Alert to
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    
}



